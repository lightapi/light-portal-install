-- Light Knowledge Phase 1b incremental, upload, multi-KB, and MCP schema.
BEGIN;

ALTER TABLE knowledge_retrieval_profile_t
    ADD COLUMN maximum_knowledge_bases INTEGER NOT NULL DEFAULT 1
        CHECK(maximum_knowledge_bases BETWEEN 1 AND 4),
    ADD COLUMN lexical_evidence_required BOOLEAN NOT NULL DEFAULT TRUE,
    ADD COLUMN segment_candidate_multiplier INTEGER NOT NULL DEFAULT 4
        CHECK(segment_candidate_multiplier BETWEEN 1 AND 16),
    ADD COLUMN context_expansion_before INTEGER NOT NULL DEFAULT 0
        CHECK(context_expansion_before BETWEEN 0 AND 4),
    ADD COLUMN context_expansion_after INTEGER NOT NULL DEFAULT 0
        CHECK(context_expansion_after BETWEEN 0 AND 4);

ALTER TABLE knowledge_index_segment_t
    DROP CONSTRAINT knowledge_index_segment_t_segment_kind_check,
    DROP CONSTRAINT knowledge_index_segment_t_index_generation_id_key,
    ADD COLUMN predecessor_segment_id UUID,
    ADD COLUMN operation_count BIGINT NOT NULL DEFAULT 0
        CHECK(operation_count >= 0),
    ADD CONSTRAINT knowledge_index_segment_kind_ck
        CHECK(segment_kind IN ('BASE', 'DELTA')),
    ADD CONSTRAINT knowledge_index_segment_predecessor_fk
        FOREIGN KEY(predecessor_segment_id)
        REFERENCES knowledge_index_segment_t(index_segment_id)
        ON DELETE RESTRICT;

ALTER TABLE knowledge_generation_segment_t
    DROP CONSTRAINT knowledge_generation_segment_t_ordinal_check,
    ADD CONSTRAINT knowledge_generation_segment_ordinal_ck CHECK(ordinal >= 0);

ALTER TABLE knowledge_job_t
    DROP CONSTRAINT knowledge_job_t_job_type_check,
    ADD CONSTRAINT knowledge_job_type_phase1b_ck CHECK(job_type IN (
        'SYNC', 'DELTA_SYNC', 'FULL_REINDEX', 'PROMOTE', 'PURGE',
        'RETRIEVAL_TEST', 'CONNECTIVITY_TEST', 'UPLOAD', 'COMPACTION',
        'ANTI_ENTROPY'
    ));

CREATE TABLE knowledge_upload_t (
    upload_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    source_object_id VARCHAR(1024) NOT NULL,
    original_filename VARCHAR(512) NOT NULL,
    media_type VARCHAR(128) NOT NULL CHECK(media_type IN (
        'text/plain', 'text/markdown', 'text/html', 'application/pdf'
    )),
    content_length BIGINT NOT NULL CHECK(content_length BETWEEN 1 AND 104857600),
    staged_locator VARCHAR(2048) NOT NULL,
    staged_digest CHAR(64) NOT NULL CHECK(staged_digest ~ '^[a-f0-9]{64}$'),
    scan_state VARCHAR(16) NOT NULL DEFAULT 'PENDING'
        CHECK(scan_state IN ('PENDING', 'CLEAN', 'REJECTED', 'ERROR')),
    lifecycle_state VARCHAR(16) NOT NULL DEFAULT 'STAGED'
        CHECK(lifecycle_state IN (
            'STAGED', 'VERIFIED', 'PROMOTED', 'REJECTED', 'ORPHANED', 'PURGED'
        )),
    rejection_code VARCHAR(96),
    requested_by VARCHAR(255) NOT NULL,
    staged_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verified_ts TIMESTAMPTZ,
    promoted_ts TIMESTAMPTZ,
    purge_after_ts TIMESTAMPTZ NOT NULL,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(source_id, source_object_id, staged_digest),
    CHECK(purge_after_ts > staged_ts),
    CHECK((lifecycle_state IN ('VERIFIED', 'PROMOTED')) =
        (scan_state = 'CLEAN') OR lifecycle_state IN ('STAGED', 'REJECTED', 'ORPHANED', 'PURGED'))
);
CREATE INDEX knowledge_upload_orphan_idx
    ON knowledge_upload_t(lifecycle_state, purge_after_ts)
    WHERE lifecycle_state IN ('STAGED', 'ORPHANED', 'REJECTED');

CREATE TABLE knowledge_source_change_t (
    source_change_id UUID PRIMARY KEY,
    sync_run_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    source_object_id VARCHAR(1024) NOT NULL,
    change_sequence BIGINT NOT NULL CHECK(change_sequence > 0),
    change_kind VARCHAR(16) NOT NULL CHECK(change_kind IN (
        'ADD', 'MODIFY', 'DELETE', 'ACL_ONLY', 'METADATA_ONLY'
    )),
    previous_document_version_id UUID,
    selected_document_version_id UUID,
    selected_acl_revision_id UUID,
    input_contract_digest CHAR(64) NOT NULL
        CHECK(input_contract_digest ~ '^[a-f0-9]{64}$'),
    change_digest CHAR(64) NOT NULL CHECK(change_digest ~ '^[a-f0-9]{64}$'),
    observed_ts TIMESTAMPTZ NOT NULL,
    FOREIGN KEY(sync_run_id) REFERENCES knowledge_sync_run_t(sync_run_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(source_id, change_sequence),
    UNIQUE(sync_run_id, source_object_id)
);

CREATE TABLE knowledge_passage_anchor_t (
    passage_anchor_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    document_id UUID NOT NULL,
    document_version_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    anchor_contract_digest CHAR(64) NOT NULL
        CHECK(anchor_contract_digest ~ '^[a-f0-9]{64}$'),
    continuity_state VARCHAR(16) NOT NULL
        CHECK(continuity_state IN ('STABLE', 'MOVED', 'AMBIGUOUS', 'RETIRED')),
    anchor_sequence BIGINT NOT NULL CHECK(anchor_sequence > 0),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(passage_anchor_id, document_version_id),
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(document_version_id, knowledge_base_id)
        REFERENCES knowledge_document_version_t(document_version_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(chunk_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(chunk_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(document_version_id, chunk_id),
    UNIQUE(document_id, anchor_sequence, passage_anchor_id)
);
CREATE INDEX knowledge_passage_anchor_current_idx
    ON knowledge_passage_anchor_t(document_id, passage_anchor_id, anchor_sequence DESC);

CREATE TABLE knowledge_segment_operation_t (
    index_segment_id UUID NOT NULL,
    operation_ordinal BIGINT NOT NULL CHECK(operation_ordinal >= 0),
    operation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    operation_kind VARCHAR(24) NOT NULL CHECK(operation_kind IN (
        'ACTIVATE_DOCUMENT', 'SUPERSEDE_DOCUMENT', 'TOMBSTONE_DOCUMENT',
        'ACTIVATE_CHUNK', 'TOMBSTONE_CHUNK', 'SET_ACL_REVISION'
    )),
    document_id UUID NOT NULL,
    document_version_id UUID,
    chunk_id UUID,
    passage_anchor_id UUID,
    acl_revision_id UUID,
    operation_digest CHAR(64) NOT NULL CHECK(operation_digest ~ '^[a-f0-9]{64}$'),
    PRIMARY KEY(index_segment_id, operation_ordinal),
    UNIQUE(index_segment_id, operation_id),
    FOREIGN KEY(index_segment_id, knowledge_base_id)
        REFERENCES knowledge_index_segment_t(index_segment_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    CHECK(operation_kind <> 'ACTIVATE_CHUNK' OR chunk_id IS NOT NULL),
    CHECK(operation_kind <> 'SET_ACL_REVISION' OR acl_revision_id IS NOT NULL)
);
CREATE INDEX knowledge_segment_operation_document_idx
    ON knowledge_segment_operation_t(
        knowledge_base_id, document_id, index_segment_id, operation_ordinal
    );

CREATE TABLE knowledge_embedding_reference_t (
    embedding_artifact_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    input_digest CHAR(64) NOT NULL CHECK(input_digest ~ '^[a-f0-9]{64}$'),
    transform_contract_digest CHAR(64) NOT NULL
        CHECK(transform_contract_digest ~ '^[a-f0-9]{64}$'),
    reference_state VARCHAR(12) NOT NULL DEFAULT 'ACTIVE'
        CHECK(reference_state IN ('ACTIVE', 'RELEASED', 'PURGED')),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    released_ts TIMESTAMPTZ,
    PRIMARY KEY(embedding_artifact_id, knowledge_base_id, chunk_id),
    FOREIGN KEY(embedding_artifact_id)
        REFERENCES knowledge_embedding_artifact_t(embedding_artifact_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(chunk_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(chunk_id, knowledge_base_id)
        ON DELETE RESTRICT
);
CREATE INDEX knowledge_embedding_reference_last_ref_idx
    ON knowledge_embedding_reference_t(embedding_artifact_id, reference_state);

CREATE TABLE knowledge_compaction_run_t (
    compaction_run_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_generation_id UUID NOT NULL,
    candidate_generation_id UUID,
    canonical_watermark BIGINT NOT NULL CHECK(canonical_watermark >= 0),
    state VARCHAR(16) NOT NULL DEFAULT 'REQUESTED'
        CHECK(state IN ('REQUESTED', 'RUNNING', 'VERIFIED', 'PROMOTED', 'FAILED')),
    source_manifest_digest CHAR(64) NOT NULL
        CHECK(source_manifest_digest ~ '^[a-f0-9]{64}$'),
    resolved_corpus_digest CHAR(64),
    verification_evidence JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(verification_evidence) = 'object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(candidate_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_anti_entropy_run_t (
    anti_entropy_run_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    index_generation_id UUID NOT NULL,
    state VARCHAR(16) NOT NULL DEFAULT 'RUNNING'
        CHECK(state IN ('RUNNING', 'CONSISTENT', 'DRIFTED', 'FAILED')),
    expected_manifest_digest CHAR(64) NOT NULL
        CHECK(expected_manifest_digest ~ '^[a-f0-9]{64}$'),
    observed_manifest_digest CHAR(64),
    mismatch_counts JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(mismatch_counts) = 'object'),
    started_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT
);

CREATE FUNCTION validate_knowledge_generation_segment_phase1b()
RETURNS TRIGGER LANGUAGE plpgsql AS $function$
DECLARE
    expected RECORD;
    candidate RECORD;
BEGIN
    SELECT g.knowledge_base_id, g.space_id, g.space_revision,
           g.dimension, s.parser_contract_digest, s.chunker_contract_digest,
           s.lexical_contract_digest, s.embedding_contract_digest,
           s.acl_contract_digest
      INTO candidate
      FROM knowledge_index_generation_t g
      JOIN knowledge_index_segment_t s
        ON s.index_segment_id = NEW.index_segment_id
       AND s.knowledge_base_id = g.knowledge_base_id
     WHERE g.index_generation_id = NEW.index_generation_id
    ;
    IF candidate IS NULL THEN
        RAISE EXCEPTION 'KNOWLEDGE_GENERATION_SEGMENT_IDENTITY_MISMATCH';
    END IF;
    SELECT g.knowledge_base_id, g.space_id, g.space_revision,
           g.dimension, s.parser_contract_digest, s.chunker_contract_digest,
           s.lexical_contract_digest, s.embedding_contract_digest,
           s.acl_contract_digest
      INTO expected
      FROM knowledge_generation_segment_t gs
      JOIN knowledge_index_generation_t g
        ON g.index_generation_id = gs.index_generation_id
      JOIN knowledge_index_segment_t s
        ON s.index_segment_id = gs.index_segment_id
     WHERE gs.index_generation_id = NEW.index_generation_id
     ORDER BY gs.ordinal LIMIT 1;
    IF expected IS NOT NULL AND expected IS DISTINCT FROM candidate THEN
        RAISE EXCEPTION 'KNOWLEDGE_GENERATION_SEGMENT_CONTRACT_MISMATCH';
    END IF;
    RETURN NEW;
END
$function$;
CREATE TRIGGER knowledge_generation_segment_phase1b_trg
BEFORE INSERT OR UPDATE ON knowledge_generation_segment_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_generation_segment_phase1b();

CREATE OR REPLACE FUNCTION promote_knowledge_base_generation(
    p_promotion_id UUID,
    p_history_id UUID,
    p_knowledge_base_id UUID,
    p_environment VARCHAR,
    p_generation_id UUID,
    p_expected_pointer_version BIGINT,
    p_authorized_by VARCHAR,
    p_reason TEXT,
    p_evidence JSONB,
    p_evidence_digest CHAR(64),
    p_rollback_deadline TIMESTAMPTZ
) RETURNS BIGINT LANGUAGE plpgsql AS $$
DECLARE
    current_version BIGINT;
    previous_generation UUID;
    next_version BIGINT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM knowledge_base_t
         WHERE knowledge_base_id=p_knowledge_base_id AND environment=p_environment
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_BASE_ENVIRONMENT_MISMATCH';
    END IF;
    IF EXISTS (
        SELECT 1 FROM knowledge_index_pointer_t
         WHERE knowledge_base_id=p_knowledge_base_id AND environment<>p_environment
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_POINTER_ENVIRONMENT_MISMATCH';
    END IF;
    SELECT pointer_version,index_generation_id
      INTO current_version,previous_generation
      FROM knowledge_index_pointer_t
     WHERE knowledge_base_id=p_knowledge_base_id AND environment=p_environment
     FOR UPDATE;
    current_version := COALESCE(current_version,0);
    IF current_version<>p_expected_pointer_version THEN
        RAISE EXCEPTION 'KNOWLEDGE_POINTER_VERSION_CONFLICT';
    END IF;
    IF NOT EXISTS (
        SELECT 1
          FROM knowledge_index_generation_t generation
          JOIN knowledge_generation_segment_t member
            ON member.index_generation_id=generation.index_generation_id
          JOIN knowledge_index_segment_t segment
            ON segment.index_segment_id=member.index_segment_id
         WHERE generation.index_generation_id=p_generation_id
           AND generation.knowledge_base_id=p_knowledge_base_id
           AND generation.state='READY'
           AND member.ordinal=0
           AND segment.segment_kind='BASE'
           AND segment.state='READY'
    ) OR EXISTS (
        SELECT 1
          FROM knowledge_generation_segment_t member
          JOIN knowledge_index_segment_t segment
            ON segment.index_segment_id=member.index_segment_id
         WHERE member.index_generation_id=p_generation_id
           AND segment.state<>'READY'
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_GENERATION_NOT_READY_SEGMENT_SET';
    END IF;
    next_version := current_version+1;
    UPDATE knowledge_index_generation_t SET state='SUPERSEDED'
     WHERE index_generation_id=previous_generation AND state='PROMOTED';
    UPDATE knowledge_index_generation_t
       SET state='PROMOTED',promoted_ts=CURRENT_TIMESTAMP
     WHERE index_generation_id=p_generation_id;
    INSERT INTO knowledge_index_pointer_t(
        knowledge_base_id,environment,index_generation_id,pointer_version,update_user
    ) VALUES (
        p_knowledge_base_id,p_environment,p_generation_id,next_version,p_authorized_by
    ) ON CONFLICT(knowledge_base_id) DO UPDATE SET
        index_generation_id=EXCLUDED.index_generation_id,
        pointer_version=EXCLUDED.pointer_version,
        update_ts=CURRENT_TIMESTAMP,
        update_user=EXCLUDED.update_user
      WHERE knowledge_index_pointer_t.environment=EXCLUDED.environment;
    INSERT INTO knowledge_index_pointer_history_t(
        pointer_history_id,knowledge_base_id,environment,previous_generation_id,
        selected_generation_id,pointer_version,evaluation_evidence,authorized_by,
        reason,rollback_deadline
    ) VALUES (
        p_history_id,p_knowledge_base_id,p_environment,previous_generation,
        p_generation_id,next_version,p_evidence,p_authorized_by,p_reason,
        p_rollback_deadline
    );
    INSERT INTO knowledge_promotion_outbox_t(
        promotion_id,knowledge_base_id,environment,index_generation_id,
        pointer_version,evidence_digest
    ) VALUES (
        p_promotion_id,p_knowledge_base_id,p_environment,p_generation_id,
        next_version,p_evidence_digest
    );
    RETURN next_version;
END
$$;

GRANT SELECT ON TABLE
    knowledge_passage_anchor_t,
    knowledge_segment_operation_t
TO light_knowledge_api_role;
GRANT SELECT, INSERT ON TABLE knowledge_upload_t TO light_knowledge_api_role;
GRANT UPDATE(scan_state, lifecycle_state, rejection_code, verified_ts)
    ON TABLE knowledge_upload_t TO light_knowledge_api_role;
GRANT INSERT ON TABLE knowledge_job_t TO light_knowledge_api_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_upload_t,
    knowledge_source_change_t,
    knowledge_passage_anchor_t,
    knowledge_segment_operation_t,
    knowledge_embedding_reference_t,
    knowledge_compaction_run_t,
    knowledge_anti_entropy_run_t
TO light_knowledge_worker_role;
GRANT SELECT ON TABLE
    knowledge_upload_t,
    knowledge_source_change_t,
    knowledge_passage_anchor_t,
    knowledge_segment_operation_t,
    knowledge_embedding_reference_t,
    knowledge_compaction_run_t,
    knowledge_anti_entropy_run_t
TO light_knowledge_ops_read_role;

COMMIT;
