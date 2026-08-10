-- Phase 4 optional graph-assisted retrieval. The graph is a derived,
-- generation-pinned artifact; canonical chunks remain the only evidence.

BEGIN;

ALTER TABLE knowledge_query_audit_t
    DROP CONSTRAINT knowledge_query_audit_t_strategy_check;
ALTER TABLE knowledge_query_audit_t
    ADD CONSTRAINT knowledge_query_audit_t_strategy_check
    CHECK(strategy IN ('LEXICAL', 'VECTOR', 'HYBRID', 'GRAPH_ASSISTED',
                       'HYBRID_FALLBACK'));
ALTER TABLE knowledge_query_audit_t
    ADD COLUMN graph_generation_id UUID,
    ADD COLUMN planner_diagnostics JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(planner_diagnostics) = 'object');

ALTER TABLE knowledge_chunk_t
    ADD CONSTRAINT knowledge_chunk_identity_version_uq
    UNIQUE(chunk_id, document_version_id, knowledge_base_id);

ALTER TABLE knowledge_index_generation_t
    ADD CONSTRAINT knowledge_index_generation_identity_kb_uq
    UNIQUE(index_generation_id, knowledge_base_id);

ALTER TABLE knowledge_retrieval_profile_t
    ADD CONSTRAINT knowledge_retrieval_profile_graph_failure_policy_ck
    CHECK(graph_policy IS NULL
        OR NOT graph_policy ? 'failurePolicy'
        OR graph_policy->>'failurePolicy' IN ('FALLBACK_HYBRID', 'FAIL_CLOSED'));

CREATE TABLE knowledge_graph_generation_t (
    graph_generation_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    index_generation_id UUID NOT NULL,
    state VARCHAR(16) NOT NULL
        CHECK(state IN ('BUILDING', 'READY', 'FAILED', 'STALE')),
    visibility_mode VARCHAR(24) NOT NULL DEFAULT 'UNIFORM_SCOPE'
        CHECK(visibility_mode = 'UNIFORM_SCOPE'),
    contract_version VARCHAR(64) NOT NULL,
    contract_digest CHAR(64) NOT NULL CHECK(contract_digest ~ '^[a-f0-9]{64}$'),
    manifest_digest CHAR(64) CHECK(manifest_digest ~ '^[a-f0-9]{64}$'),
    entity_count BIGINT NOT NULL DEFAULT 0 CHECK(entity_count >= 0),
    relation_count BIGINT NOT NULL DEFAULT 0 CHECK(relation_count >= 0),
    failure_code VARCHAR(96),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id, knowledge_base_id)
        REFERENCES knowledge_index_generation_t(
            index_generation_id, knowledge_base_id) ON DELETE RESTRICT,
    UNIQUE(index_generation_id, contract_digest),
    UNIQUE(graph_generation_id, knowledge_base_id)
);

CREATE TABLE knowledge_graph_entity_t (
    graph_entity_id UUID PRIMARY KEY,
    graph_generation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    entity_type VARCHAR(32) NOT NULL CHECK(entity_type IN (
        'REPOSITORY', 'DOCUMENT', 'HEADING', 'LINK_TARGET', 'API_OPERATION',
        'CONFIGURATION_KEY', 'SERVICE', 'COMPONENT', 'DESIGN_REFERENCE')),
    normalized_key VARCHAR(2048) NOT NULL,
    display_name VARCHAR(2048) NOT NULL,
    origin VARCHAR(16) NOT NULL CHECK(origin IN ('STRUCTURAL', 'EXPLICIT', 'EXTRACTED')),
    contract_version VARCHAR(64) NOT NULL,
    FOREIGN KEY(graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_generation_t(graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    UNIQUE(graph_generation_id, entity_type, normalized_key),
    UNIQUE(graph_entity_id, graph_generation_id, knowledge_base_id)
);

CREATE TABLE knowledge_graph_entity_contribution_t (
    graph_entity_id UUID NOT NULL,
    graph_generation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    document_version_id UUID NOT NULL,
    PRIMARY KEY(graph_entity_id, chunk_id),
    FOREIGN KEY(graph_entity_id, graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_entity_t(
            graph_entity_id, graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    FOREIGN KEY(chunk_id, document_version_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(
            chunk_id, document_version_id, knowledge_base_id)
        ON DELETE RESTRICT
);

CREATE TABLE knowledge_graph_relation_t (
    graph_relation_id UUID PRIMARY KEY,
    graph_generation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    subject_entity_id UUID NOT NULL,
    object_entity_id UUID NOT NULL,
    relation_type VARCHAR(64) NOT NULL,
    origin VARCHAR(16) NOT NULL CHECK(origin IN ('STRUCTURAL', 'EXPLICIT', 'EXTRACTED')),
    contract_version VARCHAR(64) NOT NULL,
    FOREIGN KEY(graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_generation_t(graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    FOREIGN KEY(subject_entity_id, graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_entity_t(
            graph_entity_id, graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    FOREIGN KEY(object_entity_id, graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_entity_t(
            graph_entity_id, graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    UNIQUE(graph_generation_id, subject_entity_id, relation_type, object_entity_id),
    UNIQUE(graph_relation_id, graph_generation_id, knowledge_base_id)
);

CREATE TABLE knowledge_graph_relation_contribution_t (
    graph_relation_id UUID NOT NULL,
    graph_generation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    document_version_id UUID NOT NULL,
    PRIMARY KEY(graph_relation_id, chunk_id),
    FOREIGN KEY(graph_relation_id, graph_generation_id, knowledge_base_id)
        REFERENCES knowledge_graph_relation_t(
            graph_relation_id, graph_generation_id, knowledge_base_id)
        ON DELETE CASCADE,
    FOREIGN KEY(chunk_id, document_version_id, knowledge_base_id)
        REFERENCES knowledge_chunk_t(
            chunk_id, document_version_id, knowledge_base_id)
        ON DELETE RESTRICT
);

CREATE INDEX knowledge_graph_entity_lookup_idx
    ON knowledge_graph_entity_t(graph_generation_id, normalized_key);
CREATE INDEX knowledge_graph_relation_subject_idx
    ON knowledge_graph_relation_t(graph_generation_id, subject_entity_id, relation_type);
CREATE INDEX knowledge_graph_relation_object_idx
    ON knowledge_graph_relation_t(graph_generation_id, object_entity_id, relation_type);

ALTER TABLE knowledge_query_audit_t
    ADD CONSTRAINT knowledge_query_audit_graph_generation_fk
    FOREIGN KEY(graph_generation_id)
    REFERENCES knowledge_graph_generation_t(graph_generation_id) ON DELETE RESTRICT;

REVOKE ALL ON TABLE
    knowledge_graph_generation_t,
    knowledge_graph_entity_t,
    knowledge_graph_entity_contribution_t,
    knowledge_graph_relation_t,
    knowledge_graph_relation_contribution_t
FROM PUBLIC;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_graph_generation_t,
    knowledge_graph_entity_t,
    knowledge_graph_entity_contribution_t,
    knowledge_graph_relation_t,
    knowledge_graph_relation_contribution_t
TO light_knowledge_worker_role;

GRANT SELECT ON TABLE
    knowledge_graph_generation_t,
    knowledge_graph_entity_t,
    knowledge_graph_entity_contribution_t,
    knowledge_graph_relation_t,
    knowledge_graph_relation_contribution_t
TO light_knowledge_api_role, light_knowledge_ops_read_role;

COMMIT;
