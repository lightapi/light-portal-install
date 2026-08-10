-- Light Knowledge Phase 3 production operations and embedding migration.
BEGIN;

ALTER TABLE knowledge_job_t
    DROP CONSTRAINT knowledge_job_type_phase2_ck,
    ADD CONSTRAINT knowledge_job_type_phase3_ck CHECK(job_type IN (
        'SYNC', 'DELTA_SYNC', 'FULL_REINDEX', 'PROMOTE', 'PURGE',
        'RETRIEVAL_TEST', 'CONNECTIVITY_TEST', 'UPLOAD', 'COMPACTION',
        'ANTI_ENTROPY', 'CONNECTOR_SYNC', 'ACL_RECONCILE',
        'PROVIDER_NOTIFICATION', 'MIGRATION_PREFLIGHT',
        'MIGRATION_BACKFILL', 'MIGRATION_CATCHUP', 'MIGRATION_VALIDATE',
        'MIGRATION_PAUSE', 'MIGRATION_CANCEL',
        'MIGRATION_PROMOTE', 'MIGRATION_ROLLBACK', 'MIGRATION_RETIRE',
        'BACKUP_CHECKPOINT', 'RESTORE_VERIFY', 'SEGMENT_PURGE'
    ));

CREATE VIEW knowledge_embedding_profile_runtime_v
WITH (security_barrier = true) AS
SELECT profile.profile_id, profile.profile_revision,
       profile.expected_space_id, profile.expected_space_revision,
       profile.dimension, profile.document_input_transform_version,
       profile.query_input_transform_version, alias.alias_name
  FROM knowledge_embedding_profile_t profile
  JOIN knowledge_qualified_embedding_alias_v alias
    ON alias.alias_owner_host_id=profile.alias_owner_host_id
   AND alias.public_alias_id=profile.public_alias_id
   AND alias.embedding_space->>'spaceId'=profile.expected_space_id
   AND (alias.embedding_space->>'revision')::bigint=
       profile.expected_space_revision
   AND (alias.embedding_space->>'dimension')::integer=profile.dimension
   AND alias.embedding_space->>'documentInputTransformVersion'=
       profile.document_input_transform_version
 WHERE profile.active=TRUE;

CREATE TABLE knowledge_embedding_migration_t (
    migration_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    source_generation_id UUID NOT NULL,
    candidate_generation_id UUID NOT NULL UNIQUE,
    target_profile_id UUID NOT NULL,
    target_profile_revision BIGINT NOT NULL CHECK(target_profile_revision > 0),
    target_space_id VARCHAR(255) NOT NULL,
    target_space_revision BIGINT NOT NULL CHECK(target_space_revision > 0),
    target_dimension INTEGER NOT NULL CHECK(target_dimension > 0),
    estimate_version BIGINT NOT NULL CHECK(estimate_version > 0),
    estimated_chunk_count BIGINT NOT NULL CHECK(estimated_chunk_count >= 0),
    estimated_token_count BIGINT NOT NULL CHECK(estimated_token_count >= 0),
    estimated_cost_micros BIGINT NOT NULL CHECK(estimated_cost_micros >= 0),
    estimated_duration_seconds BIGINT NOT NULL CHECK(estimated_duration_seconds >= 0),
    estimated_temporary_bytes BIGINT NOT NULL CHECK(estimated_temporary_bytes >= 0),
    accepted_cost_ceiling_micros BIGINT NOT NULL
        CHECK(accepted_cost_ceiling_micros >= 0),
    rollback_window_seconds BIGINT NOT NULL
        CHECK(rollback_window_seconds BETWEEN 300 AND 2592000),
    consumed_token_count BIGINT NOT NULL DEFAULT 0 CHECK(consumed_token_count >= 0),
    consumed_cost_micros BIGINT NOT NULL DEFAULT 0 CHECK(consumed_cost_micros >= 0),
    reserved_cost_micros BIGINT NOT NULL DEFAULT 0 CHECK(reserved_cost_micros >= 0),
    completed_chunk_count BIGINT NOT NULL DEFAULT 0 CHECK(completed_chunk_count >= 0),
    catchup_chunk_count BIGINT NOT NULL DEFAULT 0 CHECK(catchup_chunk_count >= 0),
    reused_canonical_chunk_count BIGINT NOT NULL DEFAULT 0
        CHECK(reused_canonical_chunk_count >= 0),
    start_watermark BIGINT NOT NULL CHECK(start_watermark >= 0),
    snapshot_watermark BIGINT NOT NULL CHECK(snapshot_watermark >= start_watermark),
    final_watermark BIGINT CHECK(final_watermark IS NULL
        OR final_watermark >= snapshot_watermark),
    predecessor_reconciled_watermark BIGINT NOT NULL DEFAULT 0
        CHECK(predecessor_reconciled_watermark >= 0),
    state VARCHAR(24) NOT NULL DEFAULT 'REQUESTED' CHECK(state IN (
        'REQUESTED', 'PREFLIGHTED', 'BACKFILLING', 'PAUSED',
        'CATCHING_UP', 'VALIDATING', 'READY', 'PROMOTED', 'SOAKING',
        'ROLLED_BACK', 'CANCELLED', 'FAILED', 'RETIRED'
    )),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    evaluation_evidence_id UUID,
    evaluation_evidence_digest CHAR(64) CHECK(evaluation_evidence_digest IS NULL
        OR evaluation_evidence_digest ~ '^[a-f0-9]{64}$'),
    promotion_watermark BIGINT,
    rollback_deadline TIMESTAMPTZ,
    pause_reason VARCHAR(96),
    failure_code VARCHAR(96),
    requested_by VARCHAR(255) NOT NULL,
    authorized_by VARCHAR(255),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(target_profile_id, target_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision)
        ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, migration_id),
    CHECK(accepted_cost_ceiling_micros >= estimated_cost_micros),
    CHECK(completed_chunk_count <= estimated_chunk_count + catchup_chunk_count),
    CHECK(reused_canonical_chunk_count <= completed_chunk_count),
    CHECK(consumed_cost_micros + reserved_cost_micros
        <= accepted_cost_ceiling_micros),
    CHECK((state IN ('PROMOTED', 'SOAKING', 'ROLLED_BACK', 'RETIRED'))
        = (promotion_watermark IS NOT NULL)),
    CHECK((state IN ('PROMOTED', 'SOAKING')) IS FALSE
        OR rollback_deadline IS NOT NULL)
);
CREATE UNIQUE INDEX knowledge_embedding_migration_active_uq
    ON knowledge_embedding_migration_t(knowledge_base_id)
    WHERE state IN ('REQUESTED', 'PREFLIGHTED', 'BACKFILLING', 'PAUSED',
                    'CATCHING_UP', 'VALIDATING', 'READY', 'PROMOTED', 'SOAKING');
CREATE INDEX knowledge_embedding_migration_work_idx
    ON knowledge_embedding_migration_t(state, update_ts);

CREATE FUNCTION enforce_knowledge_embedding_migration_contract()
RETURNS TRIGGER LANGUAGE plpgsql AS $function$
BEGIN
    IF TG_OP = 'UPDATE' AND ROW(
        NEW.migration_id, NEW.knowledge_base_id, NEW.environment,
        NEW.source_generation_id, NEW.candidate_generation_id,
        NEW.target_profile_id, NEW.target_profile_revision,
        NEW.target_space_id, NEW.target_space_revision, NEW.target_dimension,
        NEW.estimate_version, NEW.estimated_chunk_count,
        NEW.estimated_token_count, NEW.estimated_cost_micros,
        NEW.estimated_duration_seconds, NEW.estimated_temporary_bytes,
        NEW.accepted_cost_ceiling_micros, NEW.rollback_window_seconds,
        NEW.start_watermark,
        NEW.snapshot_watermark, NEW.requested_by, NEW.created_ts
    ) IS DISTINCT FROM ROW(
        OLD.migration_id, OLD.knowledge_base_id, OLD.environment,
        OLD.source_generation_id, OLD.candidate_generation_id,
        OLD.target_profile_id, OLD.target_profile_revision,
        OLD.target_space_id, OLD.target_space_revision, OLD.target_dimension,
        OLD.estimate_version, OLD.estimated_chunk_count,
        OLD.estimated_token_count, OLD.estimated_cost_micros,
        OLD.estimated_duration_seconds, OLD.estimated_temporary_bytes,
        OLD.accepted_cost_ceiling_micros, OLD.rollback_window_seconds,
        OLD.start_watermark,
        OLD.snapshot_watermark, OLD.requested_by, OLD.created_ts
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_MIGRATION_IMMUTABLE_CONTRACT';
    END IF;
    IF TG_OP = 'UPDATE' AND NEW.version <= OLD.version THEN
        RAISE EXCEPTION 'KNOWLEDGE_MIGRATION_VERSION_CONFLICT';
    END IF;
    IF NEW.consumed_cost_micros + NEW.reserved_cost_micros
        > NEW.accepted_cost_ceiling_micros THEN
        RAISE EXCEPTION 'KNOWLEDGE_MIGRATION_COST_CEILING_EXCEEDED';
    END IF;
    RETURN NEW;
END
$function$;
CREATE TRIGGER knowledge_embedding_migration_contract_trg
BEFORE UPDATE ON knowledge_embedding_migration_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_embedding_migration_contract();

CREATE TABLE knowledge_embedding_migration_chunk_t (
    migration_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    transformed_input_digest CHAR(64) NOT NULL
        CHECK(transformed_input_digest ~ '^[a-f0-9]{64}$'),
    embedding_artifact_id UUID,
    state VARCHAR(16) NOT NULL DEFAULT 'PENDING'
        CHECK(state IN (
            'PENDING', 'CLAIMED', 'EMBEDDED', 'VERIFIED', 'FAILED'
        )),
    claim_token UUID,
    claim_expires_ts TIMESTAMPTZ,
    token_count INTEGER NOT NULL CHECK(token_count > 0),
    reserved_cost_micros BIGINT NOT NULL DEFAULT 0
        CHECK(reserved_cost_micros >= 0),
    cost_micros BIGINT NOT NULL DEFAULT 0 CHECK(cost_micros >= 0),
    attempt_count INTEGER NOT NULL DEFAULT 0 CHECK(attempt_count >= 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(migration_id, chunk_id),
    FOREIGN KEY(migration_id, knowledge_base_id)
        REFERENCES knowledge_embedding_migration_t(migration_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(chunk_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(chunk_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(embedding_artifact_id)
        REFERENCES knowledge_embedding_artifact_t(embedding_artifact_id)
        ON DELETE RESTRICT,
    CHECK((state IN ('EMBEDDED', 'VERIFIED'))
        = (embedding_artifact_id IS NOT NULL)),
    CHECK((state = 'CLAIMED') =
        (claim_token IS NOT NULL AND claim_expires_ts IS NOT NULL))
);
CREATE INDEX knowledge_embedding_migration_chunk_work_idx
    ON knowledge_embedding_migration_chunk_t(
        migration_id, state, claim_expires_ts, chunk_id
    );

CREATE TABLE knowledge_migration_evaluation_t (
    evaluation_evidence_id UUID PRIMARY KEY,
    migration_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    candidate_generation_id UUID NOT NULL,
    evaluation_contract_version VARCHAR(64) NOT NULL,
    corpus_watermark BIGINT NOT NULL CHECK(corpus_watermark >= 0),
    metrics JSONB NOT NULL CHECK(jsonb_typeof(metrics) = 'object'),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    passed BOOLEAN NOT NULL,
    expires_ts TIMESTAMPTZ NOT NULL,
    authorized_by VARCHAR(255) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(migration_id, knowledge_base_id)
        REFERENCES knowledge_embedding_migration_t(migration_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(candidate_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    UNIQUE(migration_id, evidence_digest),
    CHECK(expires_ts > created_ts)
);

CREATE TABLE knowledge_generation_retention_t (
    index_generation_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    retention_state VARCHAR(20) NOT NULL DEFAULT 'RETAINED' CHECK(retention_state IN (
        'ACTIVE', 'ROLLBACK_ELIGIBLE', 'RETAINED', 'PURGE_APPROVED', 'PURGED'
    )),
    retain_until_ts TIMESTAMPTZ,
    legal_hold BOOLEAN NOT NULL DEFAULT FALSE,
    backup_reference_count INTEGER NOT NULL DEFAULT 0
        CHECK(backup_reference_count >= 0),
    migration_reference_count INTEGER NOT NULL DEFAULT 0
        CHECK(migration_reference_count >= 0),
    last_reference_check_ts TIMESTAMPTZ,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    CHECK(retention_state <> 'PURGE_APPROVED' OR (
        legal_hold = FALSE AND backup_reference_count = 0
        AND migration_reference_count = 0
    ))
);

CREATE TABLE knowledge_backup_checkpoint_t (
    checkpoint_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    index_generation_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    object_manifest_digest CHAR(64) NOT NULL
        CHECK(object_manifest_digest ~ '^[a-f0-9]{64}$'),
    database_checkpoint_reference VARCHAR(512) NOT NULL,
    encrypted_object_checkpoint_reference VARCHAR(2048) NOT NULL,
    state VARCHAR(20) NOT NULL CHECK(state IN (
        'REQUESTED', 'VERIFIED', 'RESTORED', 'FAILED', 'EXPIRED'
    )),
    verification_evidence JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(verification_evidence) = 'object'),
    retain_until_ts TIMESTAMPTZ NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verified_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    CHECK(retain_until_ts > created_ts)
);

CREATE TABLE knowledge_purge_evidence_t (
    purge_evidence_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    index_generation_id UUID,
    purge_scope VARCHAR(24) NOT NULL CHECK(purge_scope IN (
        'GENERATION', 'SEGMENT', 'EMBEDDING_ARTIFACT', 'KNOWLEDGE_BASE'
    )),
    state VARCHAR(20) NOT NULL CHECK(state IN (
        'REQUESTED', 'BLOCKED', 'VERIFIED', 'FAILED'
    )),
    reference_counts JSONB NOT NULL CHECK(jsonb_typeof(reference_counts) = 'object'),
    deletion_counts JSONB NOT NULL CHECK(jsonb_typeof(deletion_counts) = 'object'),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    authorized_by VARCHAR(255) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_operational_policy_t (
    knowledge_base_id UUID PRIMARY KEY,
    maximum_parallel_bulk_jobs INTEGER NOT NULL DEFAULT 1
        CHECK(maximum_parallel_bulk_jobs BETWEEN 1 AND 32),
    maximum_migration_cost_micros BIGINT NOT NULL DEFAULT 100000000
        CHECK(maximum_migration_cost_micros >= 0),
    migration_cost_per_token_micros NUMERIC(18,6) NOT NULL DEFAULT 0
        CHECK(migration_cost_per_token_micros >= 0),
    rollback_window_seconds BIGINT NOT NULL DEFAULT 86400
        CHECK(rollback_window_seconds BETWEEN 300 AND 2592000),
    anti_entropy_interval_seconds BIGINT NOT NULL DEFAULT 3600
        CHECK(anti_entropy_interval_seconds BETWEEN 60 AND 604800),
    backup_interval_seconds BIGINT NOT NULL DEFAULT 86400
        CHECK(backup_interval_seconds BETWEEN 300 AND 2592000),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT
);

CREATE OR REPLACE FUNCTION knowledge_resolved_generation_chunk(
    p_index_generation_id UUID
) RETURNS TABLE(
    chunk_id UUID,
    document_id UUID,
    document_version_id UUID,
    acl_revision_id UUID
) LANGUAGE sql STABLE AS $$
    WITH generation_segments AS (
        SELECT member.index_segment_id, member.ordinal
          FROM knowledge_generation_segment_t member
          JOIN knowledge_index_segment_t segment
            ON segment.index_segment_id=member.index_segment_id
           AND segment.state IN ('READY', 'BUILDING')
         WHERE member.index_generation_id=p_index_generation_id
    ), eligible AS (
        SELECT DISTINCT ON(segment_chunk.chunk_id)
               segment_chunk.chunk_id,
               document_version.document_id,
               chunk.document_version_id,
               segment_chunk.acl_revision_id,
               generation_segment.ordinal
          FROM generation_segments generation_segment
          JOIN knowledge_segment_chunk_t segment_chunk
            ON segment_chunk.index_segment_id=generation_segment.index_segment_id
          JOIN knowledge_chunk_t chunk ON chunk.chunk_id=segment_chunk.chunk_id
          JOIN knowledge_document_version_t document_version
            ON document_version.document_version_id=chunk.document_version_id
         WHERE NOT EXISTS (
             SELECT 1
               FROM generation_segments later
               JOIN knowledge_segment_operation_t operation
                 ON operation.index_segment_id=later.index_segment_id
              WHERE later.ordinal>generation_segment.ordinal
                AND operation.document_id=document_version.document_id
                AND (operation.operation_kind IN (
                      'SUPERSEDE_DOCUMENT', 'TOMBSTONE_DOCUMENT')
                     OR (operation.operation_kind='TOMBSTONE_CHUNK'
                         AND operation.chunk_id=segment_chunk.chunk_id))
         )
         ORDER BY segment_chunk.chunk_id, generation_segment.ordinal DESC
    )
    SELECT eligible.chunk_id, eligible.document_id,
           eligible.document_version_id, eligible.acl_revision_id
      FROM eligible
$$;

REVOKE ALL ON TABLE
    knowledge_embedding_migration_t,
    knowledge_embedding_migration_chunk_t,
    knowledge_migration_evaluation_t,
    knowledge_generation_retention_t,
    knowledge_backup_checkpoint_t,
    knowledge_purge_evidence_t,
    knowledge_operational_policy_t
FROM PUBLIC;

REVOKE ALL ON TABLE knowledge_embedding_profile_runtime_v FROM PUBLIC;
REVOKE ALL ON FUNCTION knowledge_resolved_generation_chunk(UUID) FROM PUBLIC;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_embedding_migration_t,
    knowledge_embedding_migration_chunk_t,
    knowledge_migration_evaluation_t,
    knowledge_generation_retention_t,
    knowledge_backup_checkpoint_t,
    knowledge_purge_evidence_t,
    knowledge_operational_policy_t
TO light_knowledge_worker_role;

GRANT SELECT ON TABLE knowledge_embedding_profile_runtime_v
TO light_knowledge_worker_role;
GRANT EXECUTE ON FUNCTION knowledge_resolved_generation_chunk(UUID)
TO light_knowledge_worker_role;

GRANT SELECT ON TABLE
    knowledge_embedding_migration_t,
    knowledge_embedding_migration_chunk_t,
    knowledge_migration_evaluation_t,
    knowledge_generation_retention_t,
    knowledge_backup_checkpoint_t,
    knowledge_purge_evidence_t,
    knowledge_operational_policy_t
TO light_knowledge_ops_read_role;

GRANT SELECT ON TABLE knowledge_embedding_profile_runtime_v
TO light_knowledge_ops_read_role;

COMMIT;
