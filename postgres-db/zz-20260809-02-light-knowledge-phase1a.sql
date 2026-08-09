\connect configserver

-- Light Knowledge Phase 1a operational schema.
-- Phase 1a supports one immutable full BASE segment per candidate generation.
BEGIN;

CREATE EXTENSION IF NOT EXISTS pg_trgm;

ALTER TABLE agent_knowledge_base_t
    ADD COLUMN evidence_required BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN allowed_source_trust_tiers JSONB NOT NULL DEFAULT '[]'::jsonb
        CHECK(jsonb_typeof(allowed_source_trust_tiers) = 'array');

CREATE TABLE knowledge_projection_inbox_t (
    event_id UUID PRIMARY KEY,
    aggregate_type VARCHAR(96) NOT NULL,
    aggregate_id VARCHAR(512) NOT NULL,
    aggregate_sequence BIGINT NOT NULL CHECK(aggregate_sequence > 0),
    event_type VARCHAR(160) NOT NULL,
    event_ts TIMESTAMPTZ NOT NULL,
    payload JSONB NOT NULL CHECK(jsonb_typeof(payload) = 'object'),
    payload_digest CHAR(64) NOT NULL CHECK(payload_digest ~ '^[a-f0-9]{64}$'),
    state VARCHAR(16) NOT NULL DEFAULT 'RECEIVED'
        CHECK(state IN ('RECEIVED', 'APPLIED', 'GAP', 'DEAD_LETTER')),
    attempt_count INTEGER NOT NULL DEFAULT 0 CHECK(attempt_count >= 0),
    next_attempt_ts TIMESTAMPTZ,
    applied_ts TIMESTAMPTZ,
    last_error JSONB CHECK(last_error IS NULL OR jsonb_typeof(last_error) = 'object'),
    UNIQUE(aggregate_type, aggregate_id, aggregate_sequence)
);
CREATE INDEX knowledge_projection_inbox_work_idx
    ON knowledge_projection_inbox_t(state, next_attempt_ts, event_ts);

CREATE TABLE knowledge_projection_heartbeat_t (
    projector_id VARCHAR(255) PRIMARY KEY,
    applied_event_sequence BIGINT NOT NULL CHECK(applied_event_sequence >= 0),
    effective_config_digest CHAR(64) NOT NULL
        CHECK(effective_config_digest ~ '^[a-f0-9]{64}$'),
    signature_digest CHAR(64) NOT NULL
        CHECK(signature_digest ~ '^[a-f0-9]{64}$'),
    lease_expires_ts TIMESTAMPTZ NOT NULL,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK(lease_expires_ts <= update_ts + INTERVAL '30 seconds')
);

CREATE TABLE knowledge_projection_ack_t (
    event_id UUID PRIMARY KEY,
    aggregate_type VARCHAR(96) NOT NULL,
    aggregate_id VARCHAR(512) NOT NULL,
    aggregate_sequence BIGINT NOT NULL CHECK(aggregate_sequence > 0),
    projector_id VARCHAR(255) NOT NULL,
    effective_config_digest CHAR(64) NOT NULL
        CHECK(effective_config_digest ~ '^[a-f0-9]{64}$'),
    acknowledged_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(event_id) REFERENCES knowledge_projection_inbox_t(event_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(projector_id)
        REFERENCES knowledge_projection_heartbeat_t(projector_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_runtime_authorization_t (
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    agent_id UUID NOT NULL,
    retrieval_profile_id UUID NOT NULL,
    qualified_strategies JSONB NOT NULL DEFAULT '["HYBRID"]'::jsonb
        CHECK(jsonb_typeof(qualified_strategies) = 'array'),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    desired_event_sequence BIGINT NOT NULL CHECK(desired_event_sequence >= 0),
    applied_event_sequence BIGINT NOT NULL CHECK(applied_event_sequence >= 0),
    projector_id VARCHAR(255) NOT NULL,
    lease_expires_ts TIMESTAMPTZ NOT NULL,
    authorization_digest CHAR(64) NOT NULL
        CHECK(authorization_digest ~ '^[a-f0-9]{64}$'),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(knowledge_base_id, consumer_host_id, environment, agent_id),
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(consumer_host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(consumer_host_id, agent_id)
        REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE RESTRICT,
    FOREIGN KEY(retrieval_profile_id)
        REFERENCES knowledge_retrieval_profile_t(profile_id) ON DELETE RESTRICT,
    FOREIGN KEY(projector_id)
        REFERENCES knowledge_projection_heartbeat_t(projector_id)
        ON DELETE RESTRICT,
    CHECK(applied_event_sequence <= desired_event_sequence)
);
CREATE INDEX knowledge_runtime_authorization_effective_idx
    ON knowledge_runtime_authorization_t(
        consumer_host_id, agent_id, environment, knowledge_base_id, active
    );

CREATE TABLE knowledge_sync_run_t (
    sync_run_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    requested_by VARCHAR(255) NOT NULL,
    requested_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    start_watermark BIGINT NOT NULL DEFAULT 0 CHECK(start_watermark >= 0),
    snapshot_watermark BIGINT CHECK(snapshot_watermark IS NULL
        OR snapshot_watermark >= start_watermark),
    state VARCHAR(20) NOT NULL DEFAULT 'REQUESTED'
        CHECK(state IN ('REQUESTED', 'RUNNING', 'SUCCEEDED', 'FAILED', 'CANCELLED')),
    document_count BIGINT NOT NULL DEFAULT 0 CHECK(document_count >= 0),
    chunk_count BIGINT NOT NULL DEFAULT 0 CHECK(chunk_count >= 0),
    source_bytes BIGINT NOT NULL DEFAULT 0 CHECK(source_bytes >= 0),
    embedding_tokens BIGINT NOT NULL DEFAULT 0 CHECK(embedding_tokens >= 0),
    stored_bytes BIGINT NOT NULL DEFAULT 0 CHECK(stored_bytes >= 0),
    finished_ts TIMESTAMPTZ,
    error_summary JSONB CHECK(error_summary IS NULL
        OR jsonb_typeof(error_summary) = 'object'),
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT
);
CREATE INDEX knowledge_sync_run_source_idx
    ON knowledge_sync_run_t(source_id, requested_ts DESC);

CREATE TABLE knowledge_source_cursor_t (
    source_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    opaque_cursor TEXT,
    source_watermark BIGINT NOT NULL DEFAULT 0 CHECK(source_watermark >= 0),
    last_full_reconciliation_ts TIMESTAMPTZ,
    cursor_digest CHAR(64) CHECK(cursor_digest IS NULL
        OR cursor_digest ~ '^[a-f0-9]{64}$'),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT
);

CREATE TABLE knowledge_document_t (
    document_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    source_object_id VARCHAR(1024) NOT NULL,
    canonical_uri VARCHAR(2048) NOT NULL,
    lifecycle_state VARCHAR(16) NOT NULL DEFAULT 'ACTIVE'
        CHECK(lifecycle_state IN ('ACTIVE', 'DELETED', 'EXCLUDED')),
    current_document_version_id UUID,
    observed_ts TIMESTAMPTZ NOT NULL,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(source_id, source_object_id),
    UNIQUE(document_id, knowledge_base_id)
);

CREATE TABLE knowledge_document_version_t (
    document_version_id UUID PRIMARY KEY,
    document_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    source_version VARCHAR(255) NOT NULL,
    content_digest CHAR(64) NOT NULL CHECK(content_digest ~ '^[a-f0-9]{64}$'),
    parser_contract_digest CHAR(64) NOT NULL
        CHECK(parser_contract_digest ~ '^[a-f0-9]{64}$'),
    metadata_schema_version VARCHAR(64) NOT NULL,
    object_locator VARCHAR(2048) NOT NULL,
    object_digest CHAR(64) NOT NULL CHECK(object_digest ~ '^[a-f0-9]{64}$'),
    normalized_bytes BIGINT NOT NULL CHECK(normalized_bytes >= 0),
    source_modified_ts TIMESTAMPTZ,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(document_id, source_version, parser_contract_digest),
    UNIQUE(document_version_id, knowledge_base_id)
);
ALTER TABLE knowledge_document_t
    ADD CONSTRAINT knowledge_document_current_version_fk
    FOREIGN KEY(current_document_version_id, knowledge_base_id)
    REFERENCES knowledge_document_version_t(document_version_id, knowledge_base_id)
    ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE knowledge_document_acl_t (
    acl_revision_id UUID PRIMARY KEY,
    document_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    acl_sequence BIGINT NOT NULL CHECK(acl_sequence > 0),
    visibility_mode VARCHAR(24) NOT NULL
        CHECK(visibility_mode IN ('UNIFORM_SCOPE', 'MIRROR_SOURCE_ACL')),
    normalized_acl JSONB NOT NULL CHECK(jsonb_typeof(normalized_acl) = 'object'),
    normalization_contract_digest CHAR(64) NOT NULL
        CHECK(normalization_contract_digest ~ '^[a-f0-9]{64}$'),
    completeness_state VARCHAR(16) NOT NULL
        CHECK(completeness_state IN ('COMPLETE', 'STALE', 'INCOMPLETE')),
    observed_ts TIMESTAMPTZ NOT NULL,
    fresh_until_ts TIMESTAMPTZ NOT NULL,
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(document_id, acl_sequence),
    UNIQUE(acl_revision_id, knowledge_base_id),
    CHECK(fresh_until_ts >= observed_ts)
);

CREATE TABLE knowledge_chunk_t (
    chunk_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    document_version_id UUID NOT NULL,
    ordinal INTEGER NOT NULL CHECK(ordinal >= 0),
    section_path JSONB NOT NULL DEFAULT '[]'::jsonb
        CHECK(jsonb_typeof(section_path) = 'array'),
    start_offset BIGINT NOT NULL CHECK(start_offset >= 0),
    end_offset BIGINT NOT NULL CHECK(end_offset > start_offset),
    chunk_text TEXT NOT NULL,
    token_count INTEGER NOT NULL CHECK(token_count > 0),
    content_digest CHAR(64) NOT NULL CHECK(content_digest ~ '^[a-f0-9]{64}$'),
    parser_output_digest CHAR(64) NOT NULL
        CHECK(parser_output_digest ~ '^[a-f0-9]{64}$'),
    chunker_contract_digest CHAR(64) NOT NULL
        CHECK(chunker_contract_digest ~ '^[a-f0-9]{64}$'),
    lexical_input TSVECTOR NOT NULL,
    lexical_input_digest CHAR(64) NOT NULL
        CHECK(lexical_input_digest ~ '^[a-f0-9]{64}$'),
    metadata_schema_version VARCHAR(64) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(document_version_id, knowledge_base_id)
        REFERENCES knowledge_document_version_t(document_version_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(document_version_id, ordinal, chunker_contract_digest),
    UNIQUE(chunk_id, knowledge_base_id)
);
CREATE INDEX knowledge_chunk_lexical_idx
    ON knowledge_chunk_t USING GIN(lexical_input);
CREATE INDEX knowledge_chunk_identifier_idx
    ON knowledge_chunk_t USING GIN(chunk_text gin_trgm_ops);

CREATE TABLE knowledge_chunk_embedding_t (
    chunk_id UUID NOT NULL,
    embedding_artifact_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL,
    request_id VARCHAR(255) NOT NULL,
    reused BOOLEAN NOT NULL DEFAULT FALSE,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(chunk_id, embedding_artifact_id),
    FOREIGN KEY(chunk_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(chunk_id, knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_artifact_id)
        REFERENCES knowledge_embedding_artifact_t(embedding_artifact_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id, embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_index_segment_t (
    index_segment_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    index_generation_id UUID NOT NULL,
    segment_kind VARCHAR(8) NOT NULL CHECK(segment_kind = 'BASE'),
    state VARCHAR(16) NOT NULL
        CHECK(state IN ('BUILDING', 'READY', 'FAILED', 'PURGED')),
    snapshot_watermark BIGINT NOT NULL CHECK(snapshot_watermark >= 0),
    parser_contract_digest CHAR(64) NOT NULL,
    chunker_contract_digest CHAR(64) NOT NULL,
    lexical_contract_digest CHAR(64) NOT NULL,
    embedding_contract_digest CHAR(64) NOT NULL,
    acl_contract_digest CHAR(64) NOT NULL,
    physical_locator VARCHAR(2048) NOT NULL,
    manifest_digest CHAR(64) NOT NULL CHECK(manifest_digest ~ '^[a-f0-9]{64}$'),
    document_count BIGINT NOT NULL CHECK(document_count >= 0),
    chunk_count BIGINT NOT NULL CHECK(chunk_count >= 0),
    vector_count BIGINT NOT NULL CHECK(vector_count >= 0),
    acl_count BIGINT NOT NULL CHECK(acl_count >= 0),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    UNIQUE(index_generation_id),
    UNIQUE(index_segment_id, knowledge_base_id)
);

CREATE TABLE knowledge_segment_document_t (
    index_segment_id UUID NOT NULL,
    document_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    document_version_id UUID NOT NULL,
    acl_revision_id UUID NOT NULL,
    PRIMARY KEY(index_segment_id, document_id),
    FOREIGN KEY(index_segment_id, knowledge_base_id)
        REFERENCES knowledge_index_segment_t(index_segment_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(document_version_id, knowledge_base_id)
        REFERENCES knowledge_document_version_t(document_version_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(acl_revision_id, knowledge_base_id)
        REFERENCES knowledge_document_acl_t(acl_revision_id, knowledge_base_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_segment_chunk_t (
    index_segment_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    acl_revision_id UUID NOT NULL,
    PRIMARY KEY(index_segment_id, chunk_id),
    FOREIGN KEY(index_segment_id, knowledge_base_id)
        REFERENCES knowledge_index_segment_t(index_segment_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(chunk_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(chunk_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(acl_revision_id, knowledge_base_id)
        REFERENCES knowledge_document_acl_t(acl_revision_id, knowledge_base_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_segment_vector_t (
    index_segment_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    embedding_artifact_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    projection VECTOR NOT NULL,
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    PRIMARY KEY(index_segment_id, chunk_id),
    FOREIGN KEY(index_segment_id, chunk_id)
        REFERENCES knowledge_segment_chunk_t(index_segment_id, chunk_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(embedding_artifact_id, dimension)
        REFERENCES knowledge_embedding_artifact_t(
            embedding_artifact_id, dimension
        ) ON DELETE RESTRICT,
    CHECK(vector_dims(projection) = dimension)
);
CREATE FUNCTION enforce_knowledge_segment_vector_dimension()
RETURNS TRIGGER LANGUAGE plpgsql AS $function$
DECLARE expected_dimension INTEGER;
BEGIN
    SELECT generation.dimension INTO expected_dimension
      FROM knowledge_index_segment_t segment
      JOIN knowledge_index_generation_t generation
        ON generation.index_generation_id = segment.index_generation_id
     WHERE segment.index_segment_id = NEW.index_segment_id;
    IF expected_dimension IS NULL OR NEW.dimension <> expected_dimension THEN
        RAISE EXCEPTION 'KNOWLEDGE_SEGMENT_VECTOR_DIMENSION_MISMATCH';
    END IF;
    RETURN NEW;
END
$function$;
CREATE TRIGGER knowledge_segment_vector_dimension_trg
BEFORE INSERT OR UPDATE ON knowledge_segment_vector_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_segment_vector_dimension();
CREATE TABLE knowledge_generation_segment_t (
    index_generation_id UUID NOT NULL,
    ordinal INTEGER NOT NULL CHECK(ordinal = 0),
    index_segment_id UUID NOT NULL,
    PRIMARY KEY(index_generation_id, ordinal),
    UNIQUE(index_generation_id, index_segment_id),
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(index_segment_id)
        REFERENCES knowledge_index_segment_t(index_segment_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_index_pointer_history_t (
    pointer_history_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    previous_generation_id UUID,
    selected_generation_id UUID NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    evaluation_evidence JSONB NOT NULL
        CHECK(jsonb_typeof(evaluation_evidence) = 'object'),
    authorized_by VARCHAR(255) NOT NULL,
    reason TEXT NOT NULL,
    release_notes TEXT,
    rollback_deadline TIMESTAMPTZ NOT NULL,
    promoted_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(previous_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(selected_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, environment, pointer_version)
);

CREATE TABLE knowledge_promotion_outbox_t (
    promotion_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    index_generation_id UUID NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    state VARCHAR(16) NOT NULL DEFAULT 'PENDING'
        CHECK(state IN ('PENDING', 'SENT', 'ACKNOWLEDGED', 'FAILED')),
    attempt_count INTEGER NOT NULL DEFAULT 0 CHECK(attempt_count >= 0),
    next_attempt_ts TIMESTAMPTZ,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    acknowledged_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, environment, index_generation_id)
);
CREATE INDEX knowledge_promotion_outbox_work_idx
    ON knowledge_promotion_outbox_t(state, next_attempt_ts, created_ts);

CREATE TABLE knowledge_promotion_ack_t (
    promotion_id UUID PRIMARY KEY,
    portal_event_id UUID NOT NULL UNIQUE,
    portal_aggregate_sequence BIGINT NOT NULL CHECK(portal_aggregate_sequence > 0),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    acknowledged_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(promotion_id)
        REFERENCES knowledge_promotion_outbox_t(promotion_id) ON DELETE RESTRICT
);

CREATE TABLE knowledge_query_admission_t (
    admission_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    request_id VARCHAR(255) NOT NULL,
    admitted_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lease_expires_ts TIMESTAMPTZ NOT NULL,
    reserved_cost_micros BIGINT NOT NULL CHECK(reserved_cost_micros >= 0),
    state VARCHAR(16) NOT NULL DEFAULT 'ADMITTED'
        CHECK(state IN ('ADMITTED', 'COMPLETED', 'RELEASED')),
    FOREIGN KEY(knowledge_base_id, consumer_host_id)
        REFERENCES knowledge_consumer_quota_t(knowledge_base_id, consumer_host_id)
        ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, consumer_host_id, request_id),
    CHECK(lease_expires_ts > admitted_ts)
);
CREATE INDEX knowledge_query_admission_active_idx
    ON knowledge_query_admission_t(
        knowledge_base_id, consumer_host_id, lease_expires_ts
    ) WHERE state = 'ADMITTED';

CREATE TABLE knowledge_query_audit_t (
    query_audit_id UUID PRIMARY KEY,
    request_id VARCHAR(255) NOT NULL,
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    index_generation_id UUID NOT NULL,
    retrieval_profile_id UUID NOT NULL,
    strategy VARCHAR(24) NOT NULL CHECK(strategy IN ('LEXICAL', 'VECTOR', 'HYBRID')),
    segment_manifest_digest CHAR(64) NOT NULL
        CHECK(segment_manifest_digest ~ '^[a-f0-9]{64}$'),
    query_digest CHAR(64) NOT NULL CHECK(query_digest ~ '^[a-f0-9]{64}$'),
    result_identities JSONB NOT NULL CHECK(jsonb_typeof(result_identities) = 'array'),
    fallback_reason VARCHAR(64),
    latency_ms BIGINT NOT NULL CHECK(latency_ms >= 0),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(consumer_host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(retrieval_profile_id)
        REFERENCES knowledge_retrieval_profile_t(profile_id) ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, consumer_host_id, request_id)
);

CREATE TABLE knowledge_ingestion_error_t (
    ingestion_error_id UUID PRIMARY KEY,
    sync_run_id UUID NOT NULL,
    source_object_id VARCHAR(1024),
    error_class VARCHAR(96) NOT NULL,
    retryable BOOLEAN NOT NULL,
    redacted_detail JSONB NOT NULL CHECK(jsonb_typeof(redacted_detail) = 'object'),
    occurrence_count INTEGER NOT NULL DEFAULT 1 CHECK(occurrence_count > 0),
    first_seen_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_seen_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(sync_run_id) REFERENCES knowledge_sync_run_t(sync_run_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_job_t (
    job_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID,
    job_type VARCHAR(24) NOT NULL
        CHECK(job_type IN (
            'SYNC', 'FULL_REINDEX', 'PROMOTE', 'PURGE', 'RETRIEVAL_TEST',
            'CONNECTIVITY_TEST'
        )),
    state VARCHAR(16) NOT NULL DEFAULT 'QUEUED'
        CHECK(state IN ('QUEUED', 'RUNNING', 'SUCCEEDED', 'FAILED', 'CANCELLED')),
    idempotency_key VARCHAR(255) NOT NULL,
    requested_by VARCHAR(255) NOT NULL,
    claim_token UUID,
    lease_expires_ts TIMESTAMPTZ,
    attempt_count INTEGER NOT NULL DEFAULT 0 CHECK(attempt_count >= 0),
    next_attempt_ts TIMESTAMPTZ,
    payload JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(payload) = 'object'),
    result JSONB CHECK(result IS NULL OR jsonb_typeof(result) = 'object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, idempotency_key)
);
CREATE INDEX knowledge_job_work_idx
    ON knowledge_job_t(state, next_attempt_ts, created_ts);

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
         WHERE knowledge_base_id = p_knowledge_base_id
           AND environment = p_environment
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_BASE_ENVIRONMENT_MISMATCH';
    END IF;
    IF EXISTS (
        SELECT 1 FROM knowledge_index_pointer_t
         WHERE knowledge_base_id = p_knowledge_base_id
           AND environment <> p_environment
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_POINTER_ENVIRONMENT_MISMATCH';
    END IF;
    SELECT pointer_version, index_generation_id
      INTO current_version, previous_generation
      FROM knowledge_index_pointer_t
     WHERE knowledge_base_id = p_knowledge_base_id
       AND environment = p_environment
     FOR UPDATE;

    current_version := COALESCE(current_version, 0);
    IF current_version <> p_expected_pointer_version THEN
        RAISE EXCEPTION 'KNOWLEDGE_POINTER_VERSION_CONFLICT';
    END IF;
    IF NOT EXISTS (
        SELECT 1
          FROM knowledge_index_generation_t generation
          JOIN knowledge_generation_segment_t member
            ON member.index_generation_id = generation.index_generation_id
          JOIN knowledge_index_segment_t segment
            ON segment.index_segment_id = member.index_segment_id
         WHERE generation.index_generation_id = p_generation_id
           AND generation.knowledge_base_id = p_knowledge_base_id
           AND generation.state = 'READY'
           AND member.ordinal = 0
           AND segment.segment_kind = 'BASE'
           AND segment.state = 'READY'
           AND segment.index_generation_id = generation.index_generation_id
    ) THEN
        RAISE EXCEPTION 'KNOWLEDGE_GENERATION_NOT_READY_FULL_BASE';
    END IF;

    next_version := current_version + 1;
    UPDATE knowledge_index_generation_t
       SET state = 'SUPERSEDED'
     WHERE index_generation_id = previous_generation
       AND state = 'PROMOTED';
    UPDATE knowledge_index_generation_t
       SET state = 'PROMOTED', promoted_ts = CURRENT_TIMESTAMP
     WHERE index_generation_id = p_generation_id;

    INSERT INTO knowledge_index_pointer_t(
        knowledge_base_id, environment, index_generation_id,
        pointer_version, update_user
    ) VALUES (
        p_knowledge_base_id, p_environment, p_generation_id,
        next_version, p_authorized_by
    ) ON CONFLICT (knowledge_base_id) DO UPDATE SET
        index_generation_id = EXCLUDED.index_generation_id,
        pointer_version = EXCLUDED.pointer_version,
        update_ts = CURRENT_TIMESTAMP,
        update_user = EXCLUDED.update_user
      WHERE knowledge_index_pointer_t.environment = EXCLUDED.environment;

    INSERT INTO knowledge_index_pointer_history_t(
        pointer_history_id, knowledge_base_id, environment,
        previous_generation_id, selected_generation_id, pointer_version,
        evaluation_evidence, authorized_by, reason, rollback_deadline
    ) VALUES (
        p_history_id, p_knowledge_base_id, p_environment,
        previous_generation, p_generation_id, next_version,
        p_evidence, p_authorized_by, p_reason, p_rollback_deadline
    );
    INSERT INTO knowledge_promotion_outbox_t(
        promotion_id, knowledge_base_id, environment, index_generation_id,
        pointer_version, evidence_digest
    ) VALUES (
        p_promotion_id, p_knowledge_base_id, p_environment, p_generation_id,
        next_version, p_evidence_digest
    );
    RETURN next_version;
END
$$;

REVOKE ALL ON TABLE
    knowledge_projection_inbox_t,
    knowledge_projection_heartbeat_t,
    knowledge_projection_ack_t,
    knowledge_runtime_authorization_t,
    knowledge_sync_run_t,
    knowledge_source_cursor_t,
    knowledge_document_t,
    knowledge_document_version_t,
    knowledge_document_acl_t,
    knowledge_chunk_t,
    knowledge_chunk_embedding_t,
    knowledge_index_segment_t,
    knowledge_segment_document_t,
    knowledge_segment_chunk_t,
    knowledge_segment_vector_t,
    knowledge_generation_segment_t,
    knowledge_index_pointer_history_t,
    knowledge_promotion_outbox_t,
    knowledge_promotion_ack_t,
    knowledge_query_admission_t,
    knowledge_query_audit_t,
    knowledge_ingestion_error_t,
    knowledge_job_t
FROM PUBLIC;

GRANT SELECT ON TABLE
    knowledge_runtime_authorization_t,
    knowledge_document_t,
    knowledge_document_version_t,
    knowledge_document_acl_t,
    knowledge_chunk_t,
    knowledge_chunk_embedding_t,
    knowledge_index_segment_t,
    knowledge_segment_document_t,
    knowledge_segment_chunk_t,
    knowledge_segment_vector_t,
    knowledge_generation_segment_t,
    knowledge_index_pointer_history_t
TO light_knowledge_api_role;
GRANT SELECT, INSERT, UPDATE ON TABLE
    knowledge_query_admission_t,
    knowledge_query_audit_t,
    knowledge_query_usage_t
TO light_knowledge_api_role;

GRANT SELECT, INSERT, UPDATE ON TABLE
    knowledge_projection_inbox_t,
    knowledge_projection_heartbeat_t,
    knowledge_projection_ack_t,
    knowledge_runtime_authorization_t
TO light_knowledge_portal_projector_role;
GRANT SELECT ON TABLE event_store_t TO light_knowledge_portal_projector_role;
GRANT SELECT, INSERT, UPDATE ON TABLE
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_consumer_quota_t
TO light_knowledge_portal_projector_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_sync_run_t,
    knowledge_source_cursor_t,
    knowledge_document_t,
    knowledge_document_version_t,
    knowledge_document_acl_t,
    knowledge_chunk_t,
    knowledge_chunk_embedding_t,
    knowledge_index_segment_t,
    knowledge_segment_document_t,
    knowledge_segment_chunk_t,
    knowledge_segment_vector_t,
    knowledge_generation_segment_t,
    knowledge_index_pointer_history_t,
    knowledge_promotion_outbox_t,
    knowledge_ingestion_error_t,
    knowledge_job_t
TO light_knowledge_worker_role;
GRANT SELECT ON TABLE knowledge_promotion_ack_t TO light_knowledge_worker_role;
GRANT EXECUTE ON FUNCTION promote_knowledge_base_generation(
    UUID, UUID, UUID, VARCHAR, UUID, BIGINT, VARCHAR, TEXT, JSONB, CHAR, TIMESTAMPTZ
) TO light_knowledge_worker_role;

GRANT SELECT, INSERT ON TABLE knowledge_promotion_ack_t
TO light_knowledge_portal_projector_role;
GRANT SELECT, UPDATE ON TABLE knowledge_promotion_outbox_t
TO light_knowledge_portal_projector_role;

GRANT SELECT ON TABLE
    knowledge_projection_inbox_t,
    knowledge_projection_heartbeat_t,
    knowledge_projection_ack_t,
    knowledge_runtime_authorization_t,
    knowledge_sync_run_t,
    knowledge_source_cursor_t,
    knowledge_document_t,
    knowledge_document_version_t,
    knowledge_document_acl_t,
    knowledge_chunk_t,
    knowledge_chunk_embedding_t,
    knowledge_index_segment_t,
    knowledge_segment_document_t,
    knowledge_segment_chunk_t,
    knowledge_segment_vector_t,
    knowledge_generation_segment_t,
    knowledge_index_pointer_history_t,
    knowledge_promotion_outbox_t,
    knowledge_promotion_ack_t,
    knowledge_query_admission_t,
    knowledge_query_audit_t,
    knowledge_ingestion_error_t,
    knowledge_job_t
TO light_knowledge_ops_read_role;

COMMIT;
