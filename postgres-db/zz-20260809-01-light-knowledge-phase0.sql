\connect configserver

-- Light Knowledge Phase 0 schema contract.
-- This is a guarded clean cutover from the August 8 stability foundation.
-- A non-empty deployment requires an explicitly reviewed converter.
BEGIN;

DO $inventory_guard$
DECLARE
    table_name TEXT;
    has_rows BOOLEAN;
BEGIN
    FOREACH table_name IN ARRAY ARRAY[
        'knowledge_embedding_artifact_t',
        'knowledge_base_import_identity_map_t',
        'knowledge_base_import_t',
        'knowledge_base_manifest_export_t',
        'knowledge_base_strategy_qualification_t',
        'agent_knowledge_base_t',
        'knowledge_source_t',
        'knowledge_ingestion_policy_t',
        'knowledge_query_usage_t',
        'knowledge_consumer_quota_t',
        'knowledge_index_pointer_t',
        'knowledge_index_generation_t',
        'knowledge_base_t',
        'knowledge_retrieval_profile_t'
    ] LOOP
        IF to_regclass(table_name) IS NOT NULL THEN
            EXECUTE format('SELECT EXISTS (SELECT 1 FROM %I LIMIT 1)', table_name)
               INTO has_rows;
            IF has_rows THEN
                RAISE EXCEPTION
                    'LIGHT_KNOWLEDGE_NONEMPTY_REQUIRES_APPROVED_MIGRATION: %',
                    table_name;
            END IF;
        END IF;
    END LOOP;
END
$inventory_guard$;

DROP TRIGGER IF EXISTS knowledge_index_pointer_valid_trg
    ON knowledge_index_pointer_t;
DROP FUNCTION IF EXISTS validate_knowledge_index_pointer();
DROP TRIGGER IF EXISTS knowledge_index_generation_profile_trg
    ON knowledge_index_generation_t;
DROP FUNCTION IF EXISTS validate_knowledge_index_generation_profile();
DROP FUNCTION IF EXISTS enforce_knowledge_manifest_export_immutable() CASCADE;
DROP FUNCTION IF EXISTS enforce_knowledge_import_identity_immutable() CASCADE;
DROP FUNCTION IF EXISTS enforce_knowledge_import_identity_map_append_only()
    CASCADE;

DROP TABLE IF EXISTS knowledge_embedding_artifact_t CASCADE;
DROP TABLE IF EXISTS knowledge_base_import_identity_map_t CASCADE;
DROP TABLE IF EXISTS knowledge_base_import_t CASCADE;
DROP TABLE IF EXISTS knowledge_base_manifest_export_t CASCADE;
DROP TABLE IF EXISTS knowledge_base_strategy_qualification_t CASCADE;
DROP TABLE IF EXISTS agent_knowledge_base_t CASCADE;
DROP TABLE IF EXISTS knowledge_source_t CASCADE;
DROP TABLE IF EXISTS knowledge_ingestion_policy_t CASCADE;
DROP TABLE IF EXISTS knowledge_query_usage_t CASCADE;
DROP TABLE IF EXISTS knowledge_consumer_quota_t CASCADE;
DROP TABLE IF EXISTS knowledge_index_pointer_t CASCADE;
DROP TABLE IF EXISTS knowledge_index_generation_t CASCADE;
DROP TABLE IF EXISTS knowledge_base_t CASCADE;
DROP TABLE IF EXISTS knowledge_retrieval_profile_t CASCADE;

CREATE TABLE knowledge_retrieval_profile_t (
    profile_id UUID PRIMARY KEY,
    host_id UUID,
    strategy VARCHAR(24) NOT NULL DEFAULT 'HYBRID'
        CHECK(strategy IN ('LEXICAL', 'VECTOR', 'HYBRID', 'GRAPH_ASSISTED')),
    lexical_candidates INTEGER NOT NULL CHECK(lexical_candidates > 0),
    vector_candidates INTEGER NOT NULL CHECK(vector_candidates > 0),
    top_k INTEGER NOT NULL CHECK(top_k > 0
        AND top_k <= lexical_candidates + vector_candidates),
    token_budget INTEGER NOT NULL CHECK(token_budget > 0),
    fusion_method VARCHAR(16) NOT NULL DEFAULT 'RRF'
        CHECK(fusion_method = 'RRF'),
    operational_failure_policy VARCHAR(24) NOT NULL DEFAULT 'FAIL_REQUEST'
        CHECK(operational_failure_policy IN ('FAIL_REQUEST', 'RETURN_PARTIAL')),
    graph_policy JSONB CHECK(graph_policy IS NULL
        OR jsonb_typeof(graph_policy) = 'object'),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT
);

CREATE TABLE knowledge_ingestion_policy_t (
    ingestion_policy_id UUID PRIMARY KEY,
    host_id UUID,
    policy_name VARCHAR(255) NOT NULL,
    max_documents BIGINT NOT NULL CHECK(max_documents > 0),
    max_chunks BIGINT NOT NULL CHECK(max_chunks > 0),
    max_source_bytes BIGINT NOT NULL CHECK(max_source_bytes > 0),
    max_stored_bytes BIGINT NOT NULL CHECK(max_stored_bytes > 0),
    max_embedding_tokens BIGINT NOT NULL CHECK(max_embedding_tokens > 0),
    max_spend_micros BIGINT NOT NULL CHECK(max_spend_micros >= 0),
    max_wall_time_seconds BIGINT NOT NULL CHECK(max_wall_time_seconds > 0),
    max_concurrency INTEGER NOT NULL CHECK(max_concurrency > 0),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX knowledge_ingestion_policy_global_name_uq
    ON knowledge_ingestion_policy_t(policy_name)
    WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX knowledge_ingestion_policy_tenant_name_uq
    ON knowledge_ingestion_policy_t(host_id, policy_name)
    WHERE host_id IS NOT NULL AND active IS TRUE;

CREATE TABLE knowledge_base_t (
    knowledge_base_id UUID PRIMARY KEY,
    host_id UUID,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    status VARCHAR(24) NOT NULL DEFAULT 'DRAFT'
        CHECK(status IN (
            'DRAFT', 'ACTIVE', 'DEPRECATED', 'INACTIVE',
            'DELETING', 'DELETED'
        )),
    desired_embedding_profile_id UUID,
    desired_embedding_profile_revision BIGINT
        CHECK(desired_embedding_profile_revision IS NULL
            OR desired_embedding_profile_revision > 0),
    retention_policy JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(retention_policy) = 'object'),
    replacement_knowledge_base_id UUID,
    deprecation_deadline TIMESTAMPTZ,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    CHECK((desired_embedding_profile_id IS NULL)
        = (desired_embedding_profile_revision IS NULL)),
    CHECK(replacement_knowledge_base_id IS NULL
        OR replacement_knowledge_base_id <> knowledge_base_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(desired_embedding_profile_id, desired_embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision)
        ON DELETE RESTRICT
);
ALTER TABLE knowledge_base_t
    ADD CONSTRAINT knowledge_base_replacement_fk
    FOREIGN KEY(replacement_knowledge_base_id)
    REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT;
CREATE UNIQUE INDEX knowledge_base_global_name_uq
    ON knowledge_base_t(environment, name)
    WHERE host_id IS NULL AND status <> 'DELETED';
CREATE UNIQUE INDEX knowledge_base_tenant_name_uq
    ON knowledge_base_t(host_id, environment, name)
    WHERE host_id IS NOT NULL AND status <> 'DELETED';

CREATE TABLE knowledge_source_t (
    source_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_type VARCHAR(32) NOT NULL
        CHECK(source_type IN ('GIT_MARKDOWN', 'UPLOAD', 'CONFLUENCE', 'SHAREPOINT')),
    display_name VARCHAR(255) NOT NULL,
    config_json JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(config_json) = 'object'),
    secret_reference VARCHAR(1024),
    status VARCHAR(24) NOT NULL DEFAULT 'DRAFT'
        CHECK(status IN ('DRAFT', 'ACTIVE', 'INACTIVE', 'DELETING', 'DELETED')),
    acl_mode VARCHAR(24) NOT NULL DEFAULT 'UNIFORM_SCOPE'
        CHECK(acl_mode IN ('UNIFORM_SCOPE', 'MIRROR_SOURCE_ACL')),
    source_trust_tier VARCHAR(32) NOT NULL DEFAULT 'UNREVIEWED',
    approval_policy JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(approval_policy) = 'object'),
    schedule JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(schedule) = 'object'),
    acl_reconciliation_policy JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(acl_reconciliation_policy) = 'object'),
    ingestion_policy_id UUID NOT NULL,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(ingestion_policy_id)
        REFERENCES knowledge_ingestion_policy_t(ingestion_policy_id)
        ON DELETE RESTRICT
);
CREATE UNIQUE INDEX knowledge_source_name_uq
    ON knowledge_source_t(knowledge_base_id, display_name)
    WHERE status <> 'DELETED';

CREATE TABLE agent_knowledge_base_t (
    host_id UUID NOT NULL,
    agent_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    retrieval_profile_id UUID NOT NULL,
    priority INTEGER NOT NULL DEFAULT 50 CHECK(priority BETWEEN 1 AND 100),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, agent_id, knowledge_base_id, environment),
    FOREIGN KEY(host_id, agent_id)
        REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE CASCADE,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(retrieval_profile_id)
        REFERENCES knowledge_retrieval_profile_t(profile_id) ON DELETE RESTRICT
);

CREATE TABLE knowledge_base_strategy_qualification_t (
    knowledge_base_id UUID NOT NULL,
    strategy VARCHAR(24) NOT NULL
        CHECK(strategy IN ('HYBRID', 'GRAPH_ASSISTED')),
    status VARCHAR(24) NOT NULL
        CHECK(status IN ('QUALIFIED', 'REVOKED', 'EXPIRED')),
    compatible_profile_constraints JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(compatible_profile_constraints) = 'object'),
    qualification_evidence_id VARCHAR(255) NOT NULL,
    qualified_at TIMESTAMPTZ NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    PRIMARY KEY(knowledge_base_id, strategy),
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    CHECK(expires_at > qualified_at)
);

CREATE TABLE knowledge_base_manifest_export_t (
    manifest_export_id UUID NOT NULL,
    host_id UUID,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    publication_id UUID NOT NULL,
    payload_digest CHAR(64) NOT NULL
        CHECK(payload_digest ~ '^[a-f0-9]{64}$'),
    source_knowledge_base_id UUID NOT NULL,
    source_knowledge_base_version BIGINT NOT NULL
        CHECK(source_knowledge_base_version > 0),
    manifest_format_version INTEGER NOT NULL CHECK(manifest_format_version > 0),
    exporter_reference VARCHAR(255) NOT NULL,
    issued_at TIMESTAMPTZ NOT NULL,
    signing_key_id VARCHAR(255) NOT NULL,
    signature_digest CHAR(64) NOT NULL
        CHECK(signature_digest ~ '^[a-f0-9]{64}$'),
    delivery_classification VARCHAR(32) NOT NULL,
    expires_ts TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (manifest_export_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CHECK(expires_ts > issued_at)
);
CREATE UNIQUE INDEX knowledge_manifest_export_global_publication_uq
    ON knowledge_base_manifest_export_t(environment, publication_id)
    WHERE host_id IS NULL;
CREATE UNIQUE INDEX knowledge_manifest_export_tenant_publication_uq
    ON knowledge_base_manifest_export_t(host_id, environment, publication_id)
    WHERE host_id IS NOT NULL;

CREATE OR REPLACE FUNCTION enforce_knowledge_manifest_export_immutable()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION
        'manifest export audit rows are immutable; expiry deletes the whole row';
END
$$;
CREATE TRIGGER knowledge_manifest_export_immutable_trg
BEFORE UPDATE ON knowledge_base_manifest_export_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_manifest_export_immutable();

CREATE TABLE knowledge_base_import_t (
    knowledge_base_import_id UUID NOT NULL,
    host_id UUID,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    publication_id UUID NOT NULL,
    payload_digest CHAR(64) NOT NULL
        CHECK(payload_digest ~ '^[a-f0-9]{64}$'),
    manifest_format_version INTEGER NOT NULL CHECK(manifest_format_version > 0),
    exporter_identity VARCHAR(255),
    signing_key_id VARCHAR(255),
    source_environment VARCHAR(32) NOT NULL,
    source_knowledge_base_id UUID NOT NULL,
    source_knowledge_base_version BIGINT NOT NULL
        CHECK(source_knowledge_base_version > 0),
    state VARCHAR(32) NOT NULL DEFAULT 'DEPENDENCIES_PENDING'
        CHECK(state IN (
            'DEPENDENCIES_PENDING', 'READY_TO_BUILD', 'BUILD_APPROVED',
            'BUILDING', 'FAILED_RETRYABLE', 'COMPLETED', 'ABANDONED'
        )),
    terminal_reason_code VARCHAR(64),
    authorizing_actor_reference VARCHAR(255) NOT NULL,
    target_knowledge_base_id UUID,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (knowledge_base_import_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CHECK((state = 'ABANDONED' AND terminal_reason_code IS NOT NULL)
        OR (state <> 'ABANDONED' AND terminal_reason_code IS NULL))
);
CREATE UNIQUE INDEX knowledge_base_import_global_publication_uq
    ON knowledge_base_import_t(environment, publication_id)
    WHERE host_id IS NULL;
CREATE UNIQUE INDEX knowledge_base_import_tenant_publication_uq
    ON knowledge_base_import_t(host_id, environment, publication_id)
    WHERE host_id IS NOT NULL;

CREATE OR REPLACE FUNCTION enforce_knowledge_import_identity_immutable()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF ROW(
        NEW.knowledge_base_import_id, NEW.host_id, NEW.environment,
        NEW.publication_id, NEW.payload_digest, NEW.manifest_format_version,
        NEW.exporter_identity, NEW.signing_key_id, NEW.source_environment,
        NEW.source_knowledge_base_id, NEW.source_knowledge_base_version,
        NEW.authorizing_actor_reference, NEW.created_ts
    ) IS DISTINCT FROM ROW(
        OLD.knowledge_base_import_id, OLD.host_id, OLD.environment,
        OLD.publication_id, OLD.payload_digest, OLD.manifest_format_version,
        OLD.exporter_identity, OLD.signing_key_id, OLD.source_environment,
        OLD.source_knowledge_base_id, OLD.source_knowledge_base_version,
        OLD.authorizing_actor_reference, OLD.created_ts
    ) THEN
        RAISE EXCEPTION
            'publication identity, digest, and source lineage are immutable';
    END IF;
    IF OLD.target_knowledge_base_id IS NOT NULL
       AND NEW.target_knowledge_base_id IS DISTINCT FROM
           OLD.target_knowledge_base_id THEN
        RAISE EXCEPTION 'generated target Knowledge Base identity is immutable';
    END IF;
    IF OLD.state IN ('COMPLETED', 'ABANDONED')
       AND NEW IS DISTINCT FROM OLD THEN
        RAISE EXCEPTION 'terminal publication state is immutable';
    END IF;
    IF NEW.state <> OLD.state AND NOT (
        (OLD.state = 'DEPENDENCIES_PENDING'
            AND NEW.state IN ('READY_TO_BUILD', 'ABANDONED'))
        OR (OLD.state = 'READY_TO_BUILD'
            AND NEW.state IN ('BUILD_APPROVED', 'ABANDONED'))
        OR (OLD.state = 'BUILD_APPROVED'
            AND NEW.state IN ('BUILDING', 'ABANDONED'))
        OR (OLD.state = 'BUILDING'
            AND NEW.state IN ('FAILED_RETRYABLE', 'COMPLETED', 'ABANDONED'))
        OR (OLD.state = 'FAILED_RETRYABLE'
            AND NEW.state IN ('BUILDING', 'ABANDONED'))
    ) THEN
        RAISE EXCEPTION 'invalid publication state transition: % -> %',
            OLD.state, NEW.state;
    END IF;
    RETURN NEW;
END
$$;
CREATE TRIGGER knowledge_import_identity_immutable_trg
BEFORE UPDATE ON knowledge_base_import_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_import_identity_immutable();

CREATE TABLE knowledge_base_import_identity_map_t (
    knowledge_base_import_id UUID NOT NULL,
    source_resource_type VARCHAR(32) NOT NULL,
    source_resource_id UUID NOT NULL,
    generated_target_resource_id UUID NOT NULL,
    PRIMARY KEY(
        knowledge_base_import_id,
        source_resource_type,
        source_resource_id
    ),
    FOREIGN KEY(knowledge_base_import_id)
        REFERENCES knowledge_base_import_t(knowledge_base_import_id)
        ON DELETE RESTRICT,
    UNIQUE(knowledge_base_import_id, generated_target_resource_id)
);

CREATE OR REPLACE FUNCTION enforce_knowledge_import_identity_map_append_only()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION 'publication identity-map rows are append-only';
END
$$;
CREATE TRIGGER knowledge_import_identity_map_append_only_trg
BEFORE UPDATE OR DELETE ON knowledge_base_import_identity_map_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_import_identity_map_append_only();

CREATE TABLE knowledge_index_generation_t (
    index_generation_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL,
    space_id VARCHAR(255) NOT NULL,
    space_revision BIGINT NOT NULL CHECK(space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    parser_contract_digest CHAR(64) NOT NULL,
    chunker_contract_digest CHAR(64) NOT NULL,
    metadata_contract_digest CHAR(64) NOT NULL,
    citation_contract_digest CHAR(64) NOT NULL,
    acl_normalization_contract_digest CHAR(64) NOT NULL,
    lexical_contract_digest CHAR(64) NOT NULL,
    contract_set_digest CHAR(64) NOT NULL,
    query_input_transform_version VARCHAR(255) NOT NULL,
    snapshot_watermark BIGINT NOT NULL CHECK(snapshot_watermark >= 0),
    final_watermark BIGINT CHECK(final_watermark IS NULL
        OR final_watermark >= snapshot_watermark),
    ordered_segment_manifest_digest CHAR(64),
    strategy_projections JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(strategy_projections) = 'object'),
    state VARCHAR(16) NOT NULL
        CHECK(state IN (
            'BUILDING', 'CATCHING_UP', 'VALIDATING', 'READY',
            'PROMOTED', 'FAILED', 'SUPERSEDED', 'PURGED'
        )),
    evidence JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(evidence) = 'object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    promoted_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id, embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision)
        ON DELETE RESTRICT,
    CHECK(parser_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(chunker_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(metadata_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(citation_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(acl_normalization_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(lexical_contract_digest ~ '^[a-f0-9]{64}$'),
    CHECK(contract_set_digest ~ '^[a-f0-9]{64}$'),
    CHECK(ordered_segment_manifest_digest IS NULL
        OR ordered_segment_manifest_digest ~ '^[a-f0-9]{64}$')
);

CREATE OR REPLACE FUNCTION validate_knowledge_index_generation_profile()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
          FROM knowledge_embedding_profile_t profile
         WHERE profile.profile_id = NEW.embedding_profile_id
           AND profile.profile_revision = NEW.embedding_profile_revision
           AND profile.expected_space_id = NEW.space_id
           AND profile.expected_space_revision = NEW.space_revision
           AND profile.dimension = NEW.dimension
           AND profile.query_input_transform_version
               = NEW.query_input_transform_version
    ) THEN
        RAISE EXCEPTION
            'index generation must preserve its immutable embedding profile contract';
    END IF;
    RETURN NEW;
END
$$;
CREATE TRIGGER knowledge_index_generation_profile_trg
BEFORE INSERT OR UPDATE ON knowledge_index_generation_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_generation_profile();

CREATE TABLE knowledge_index_pointer_t (
    knowledge_base_id UUID PRIMARY KEY,
    environment VARCHAR(32) NOT NULL CHECK(length(environment) > 0),
    index_generation_id UUID NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT
);

CREATE OR REPLACE FUNCTION validate_knowledge_index_pointer()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
          FROM knowledge_index_generation_t generation
          JOIN knowledge_base_t knowledge_base
            ON knowledge_base.knowledge_base_id = generation.knowledge_base_id
         WHERE generation.index_generation_id = NEW.index_generation_id
           AND generation.knowledge_base_id = NEW.knowledge_base_id
           AND generation.state = 'PROMOTED'
           AND knowledge_base.environment = NEW.environment
    ) THEN
        RAISE EXCEPTION
            'index pointer must select one matching promoted generation and environment';
    END IF;
    RETURN NEW;
END
$$;
CREATE TRIGGER knowledge_index_pointer_valid_trg
BEFORE INSERT OR UPDATE ON knowledge_index_pointer_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_pointer();

CREATE TABLE knowledge_consumer_quota_t (
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    max_concurrency INTEGER NOT NULL CHECK(max_concurrency > 0),
    requests_per_minute INTEGER NOT NULL CHECK(requests_per_minute > 0),
    max_cost_micros_per_day BIGINT NOT NULL CHECK(max_cost_micros_per_day > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(knowledge_base_id, consumer_host_id),
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE CASCADE,
    FOREIGN KEY(consumer_host_id)
        REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE TABLE knowledge_query_usage_t (
    usage_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    request_id VARCHAR(255) NOT NULL,
    request_day DATE NOT NULL,
    charged_micros BIGINT NOT NULL CHECK(charged_micros >= 0),
    result_count INTEGER NOT NULL DEFAULT 0 CHECK(result_count >= 0),
    status VARCHAR(24) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id, consumer_host_id)
        REFERENCES knowledge_consumer_quota_t(
            knowledge_base_id,
            consumer_host_id
        ) ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, consumer_host_id, request_id)
);

CREATE TABLE knowledge_embedding_artifact_t (
    embedding_artifact_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    owner_host_id UUID,
    transformed_input_digest CHAR(64) NOT NULL
        CHECK(transformed_input_digest ~ '^[a-f0-9]{64}$'),
    space_id VARCHAR(255) NOT NULL,
    space_revision BIGINT NOT NULL CHECK(space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    document_input_transform_version VARCHAR(255) NOT NULL,
    embedding VECTOR NOT NULL CHECK(vector_dims(embedding) = dimension),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(owner_host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    UNIQUE(
        knowledge_base_id,
        transformed_input_digest,
        space_id,
        space_revision,
        document_input_transform_version
    ),
    UNIQUE(embedding_artifact_id, dimension)
);

DO $roles$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles
         WHERE rolname = 'light_knowledge_portal_projector_role'
    ) THEN
        CREATE ROLE light_knowledge_portal_projector_role NOLOGIN;
    END IF;
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles
         WHERE rolname = 'light_knowledge_api_role'
    ) THEN
        CREATE ROLE light_knowledge_api_role NOLOGIN;
    END IF;
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles
         WHERE rolname = 'light_knowledge_worker_role'
    ) THEN
        CREATE ROLE light_knowledge_worker_role NOLOGIN;
    END IF;
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles
         WHERE rolname = 'light_knowledge_schema_migration_role'
    ) THEN
        CREATE ROLE light_knowledge_schema_migration_role NOLOGIN;
    END IF;
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles
         WHERE rolname = 'light_knowledge_ops_read_role'
    ) THEN
        CREATE ROLE light_knowledge_ops_read_role NOLOGIN;
    END IF;
END
$roles$;

REVOKE ALL ON TABLE
    knowledge_embedding_profile_t,
    knowledge_retrieval_profile_t,
    knowledge_ingestion_policy_t,
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_base_strategy_qualification_t,
    knowledge_base_manifest_export_t,
    knowledge_base_import_t,
    knowledge_base_import_identity_map_t,
    knowledge_index_generation_t,
    knowledge_index_pointer_t,
    knowledge_consumer_quota_t,
    knowledge_query_usage_t,
    knowledge_embedding_artifact_t
FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO
    light_knowledge_portal_projector_role,
    light_knowledge_api_role,
    light_knowledge_worker_role,
    light_knowledge_ops_read_role;
GRANT USAGE, CREATE ON SCHEMA public TO
    light_knowledge_schema_migration_role;

GRANT SELECT, INSERT, UPDATE ON TABLE
    knowledge_embedding_profile_t,
    knowledge_retrieval_profile_t,
    knowledge_ingestion_policy_t,
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_base_strategy_qualification_t
TO light_knowledge_portal_projector_role;
GRANT SELECT, INSERT ON TABLE
    knowledge_base_manifest_export_t,
    knowledge_base_import_identity_map_t
TO light_knowledge_portal_projector_role;
GRANT SELECT, INSERT, UPDATE ON TABLE knowledge_base_import_t
TO light_knowledge_portal_projector_role;

GRANT SELECT ON TABLE
    knowledge_embedding_profile_t,
    knowledge_retrieval_profile_t,
    knowledge_ingestion_policy_t,
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_base_strategy_qualification_t,
    knowledge_index_generation_t,
    knowledge_index_pointer_t,
    knowledge_consumer_quota_t,
    knowledge_embedding_artifact_t
TO light_knowledge_api_role;
GRANT SELECT, INSERT, UPDATE ON TABLE knowledge_query_usage_t
TO light_knowledge_api_role;

GRANT SELECT ON TABLE
    knowledge_embedding_profile_t,
    knowledge_retrieval_profile_t,
    knowledge_ingestion_policy_t,
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_base_strategy_qualification_t
TO light_knowledge_worker_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_index_generation_t,
    knowledge_index_pointer_t,
    knowledge_consumer_quota_t,
    knowledge_query_usage_t,
    knowledge_embedding_artifact_t
TO light_knowledge_worker_role;

GRANT SELECT ON TABLE
    knowledge_embedding_profile_t,
    knowledge_retrieval_profile_t,
    knowledge_ingestion_policy_t,
    knowledge_base_t,
    knowledge_source_t,
    agent_knowledge_base_t,
    knowledge_base_strategy_qualification_t,
    knowledge_base_manifest_export_t,
    knowledge_base_import_t,
    knowledge_base_import_identity_map_t,
    knowledge_index_generation_t,
    knowledge_index_pointer_t,
    knowledge_consumer_quota_t,
    knowledge_query_usage_t,
    knowledge_embedding_artifact_t
TO light_knowledge_ops_read_role;

COMMIT;
