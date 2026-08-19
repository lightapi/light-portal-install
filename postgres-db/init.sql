CREATE DATABASE configserver;
\c configserver;

-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

DROP TABLE IF EXISTS cascade_relationship_policy_t CASCADE;
DROP TABLE IF EXISTS event_replay_retention_log_t CASCADE;
DROP TABLE IF EXISTS event_replay_audit_t CASCADE;
DROP TABLE IF EXISTS event_replay_action_request_t CASCADE;
DROP TABLE IF EXISTS event_failure_publish_outbox_t CASCADE;
DROP TABLE IF EXISTS event_projection_worker_t CASCADE;
DROP TABLE IF EXISTS event_projection_control_t CASCADE;
DROP TABLE IF EXISTS event_projection_deferred_scope_t CASCADE;
DROP TABLE IF EXISTS event_projection_deferred_t CASCADE;
DROP TABLE IF EXISTS event_replay_barrier_t CASCADE;
DROP TABLE IF EXISTS event_replay_lease_t CASCADE;
DROP TABLE IF EXISTS event_replay_attempt_t CASCADE;
DROP TABLE IF EXISTS event_replay_item_t CASCADE;
DROP TABLE IF EXISTS event_failure_event_t CASCADE;
DROP TABLE IF EXISTS event_failure_delivery_t CASCADE;
DROP TABLE IF EXISTS event_failure_transaction_t CASCADE;
DROP TABLE IF EXISTS event_replay_request_t CASCADE;


DROP TABLE IF EXISTS execution_fixed_action_t CASCADE;
DROP TABLE IF EXISTS agent_delegation_replay_t CASCADE;
DROP TABLE IF EXISTS agent_fixed_action_t CASCADE;
DROP TABLE IF EXISTS agent_job_t CASCADE;
DROP TABLE IF EXISTS agent_trigger_t CASCADE;
DROP TABLE IF EXISTS agent_channel_message_t CASCADE;
DROP TABLE IF EXISTS agent_channel_binding_t CASCADE;
DROP TABLE IF EXISTS execution_runtime_tool_manifest_t CASCADE;
DROP TABLE IF EXISTS execution_credential_grant_audit_t CASCADE;
DROP TABLE IF EXISTS execution_provenance_t CASCADE;
DROP TABLE IF EXISTS agent_turn_materialization_t CASCADE;
DROP TABLE IF EXISTS skill_package_proposal_t CASCADE;
DROP TABLE IF EXISTS skill_package_t CASCADE;
DROP TABLE IF EXISTS agent_session_event_t CASCADE;
DROP TABLE IF EXISTS agent_approval_t CASCADE;
DROP TABLE IF EXISTS agent_action_attempt_t CASCADE;
DROP TABLE IF EXISTS agent_turn_t CASCADE;
DROP TABLE IF EXISTS agent_session_t CASCADE;
DROP TABLE IF EXISTS agent_policy_snapshot_t CASCADE;
DROP TABLE IF EXISTS execution_runtime_audit_t CASCADE;
DROP TABLE IF EXISTS workflow_approval_t CASCADE;
DROP TABLE IF EXISTS workflow_artifact_t CASCADE;
DROP TABLE IF EXISTS execution_input_t CASCADE;
DROP TABLE IF EXISTS execution_session_cleanup_request_t CASCADE;
DROP TABLE IF EXISTS execution_session_t CASCADE;
DROP TABLE IF EXISTS execution_attempt_t CASCADE;
DROP TABLE IF EXISTS runner_scheduling_request_t CASCADE;
DROP TABLE IF EXISTS runner_backend_t CASCADE;
DROP TABLE IF EXISTS runner_session_t CASCADE;
DROP TABLE IF EXISTS workflow_execution_policy_t CASCADE;

-- Unsupported flat-memory table cleanup. These tables are intentionally not recreated.
DROP TABLE IF EXISTS session_memory_t CASCADE;

DROP TABLE IF EXISTS user_memory_t CASCADE;

DROP TABLE IF EXISTS agent_memory_t CASCADE;

DROP TABLE IF EXISTS org_memory_t CASCADE;

DROP TABLE IF EXISTS agent_session_history_t CASCADE;

DROP TABLE IF EXISTS agent_memory_link_t CASCADE;

DROP TABLE IF EXISTS agent_memory_unit_entity_t CASCADE;

DROP TABLE IF EXISTS agent_memory_entity_cooccur_t CASCADE;

DROP TABLE IF EXISTS agent_memory_reflection_t CASCADE;

DROP TABLE IF EXISTS agent_memory_directive_t CASCADE;

DROP TABLE IF EXISTS agent_memory_unit_t CASCADE;

DROP TABLE IF EXISTS agent_memory_entity_t CASCADE;

DROP TABLE IF EXISTS agent_memory_doc_t CASCADE;

DROP TABLE IF EXISTS agent_memory_bank_t CASCADE;

DROP TABLE IF EXISTS agent_skill_t CASCADE;

DROP TABLE IF EXISTS skill_dependency_t CASCADE;

DROP TABLE IF EXISTS skill_workflow_t CASCADE;

DROP TABLE IF EXISTS skill_tool_t CASCADE;

DROP TABLE IF EXISTS tool_param_t CASCADE;

DROP TABLE IF EXISTS tool_t CASCADE;

DROP TABLE IF EXISTS skill_param_t CASCADE;

DROP TABLE IF EXISTS skill_t CASCADE;

DROP TABLE IF EXISTS llm_gateway_instance_property_ownership_t CASCADE;
DROP TABLE IF EXISTS gateway_tool_binding_t CASCADE;
DROP TABLE IF EXISTS gateway_tool_publication_t CASCADE;
DROP TABLE IF EXISTS llm_gateway_instance_publication_t CASCADE;
DROP TABLE IF EXISTS llm_gateway_publication_t CASCADE;
DROP TABLE IF EXISTS llm_projection_resource_t CASCADE;
DROP TABLE IF EXISTS llm_model_policy_binding_t CASCADE;
DROP TABLE IF EXISTS agent_definition_t CASCADE;
DROP TABLE IF EXISTS llm_model_policy_t CASCADE;
DROP TABLE IF EXISTS llm_pricing_version_t CASCADE;
DROP TABLE IF EXISTS llm_alias_route_t CASCADE;
DROP TABLE IF EXISTS llm_public_alias_t CASCADE;
DROP TABLE IF EXISTS llm_provider_credential_t CASCADE;
DROP TABLE IF EXISTS llm_provider_deployment_t CASCADE;
DROP TABLE IF EXISTS llm_provider_endpoint_t CASCADE;
DROP TABLE IF EXISTS llm_network_zone_t CASCADE;
DROP TABLE IF EXISTS llm_provider_account_t CASCADE;
DROP TABLE IF EXISTS llm_model_registration_t CASCADE;
DROP TABLE IF EXISTS llm_model_t CASCADE;

DROP TABLE IF EXISTS audit_log_t CASCADE;

DROP TABLE IF EXISTS task_asst_t CASCADE;

DROP TABLE IF EXISTS task_info_t CASCADE;

DROP TABLE IF EXISTS process_info_t CASCADE;

DROP TABLE IF EXISTS worklist_column_t CASCADE;

DROP TABLE IF EXISTS worklist_t CASCADE;

DROP TABLE IF EXISTS wf_definition_t CASCADE;

DROP TABLE IF EXISTS schedule_t CASCADE;

DROP TABLE IF EXISTS scheduler_lock_t CASCADE;

DROP TABLE IF EXISTS log_counter CASCADE;

DROP TABLE IF EXISTS consumer_offsets CASCADE;

DROP TABLE IF EXISTS tag_t CASCADE;

DROP TABLE IF EXISTS entity_tag_t CASCADE;

DROP TABLE IF EXISTS category_t CASCADE;

DROP TABLE IF EXISTS entity_category_t CASCADE;

DROP TABLE IF EXISTS schema_t CASCADE;

DROP TABLE IF EXISTS rule_test_case_t CASCADE;

DROP TABLE IF EXISTS rule_group_t CASCADE;

DROP TABLE IF EXISTS rule_t CASCADE;

DROP TABLE IF EXISTS api_endpoint_rule_t CASCADE;

DROP TABLE IF EXISTS api_endpoint_t CASCADE;

DROP TABLE IF EXISTS instance_clone_request_t CASCADE;

DROP TABLE IF EXISTS instance_graph_revision_t CASCADE;

DROP TABLE IF EXISTS deployment_instance_property_t CASCADE;

DROP TABLE IF EXISTS deployment_instance_t CASCADE;

DROP TABLE IF EXISTS instance_t CASCADE;

DROP TABLE IF EXISTS api_scope_t CASCADE;

DROP TABLE IF EXISTS api_t CASCADE;

DROP TABLE IF EXISTS api_version_t CASCADE;

DROP TABLE IF EXISTS app_api_t CASCADE;

DROP TABLE IF EXISTS app_t CASCADE;

DROP TABLE IF EXISTS chain_handler_t CASCADE;

DROP TABLE IF EXISTS config_property_t CASCADE;

DROP TABLE IF EXISTS config_t CASCADE;

DROP TABLE IF EXISTS environment_property_t CASCADE;

DROP TABLE IF EXISTS instance_api_path_prefix_t;

DROP TABLE IF EXISTS instance_api_property_t CASCADE;

DROP TABLE IF EXISTS instance_api_t CASCADE;

DROP TABLE IF EXISTS instance_app_api_t CASCADE;

DROP TABLE IF EXISTS instance_app_property_t CASCADE;

DROP TABLE IF EXISTS instance_app_api_property_t CASCADE;

DROP TABLE IF EXISTS instance_app_t CASCADE;

DROP TABLE IF EXISTS instance_path_t CASCADE;

DROP TABLE IF EXISTS instance_property_t CASCADE;

DROP TABLE IF EXISTS network_zone_t CASCADE;

DROP TABLE IF EXISTS instance_file_t CASCADE;

DROP TABLE IF EXISTS product_property_t CASCADE;

DROP TABLE IF EXISTS product_version_property_t CASCADE;

DROP TABLE IF EXISTS product_version_config_t CASCADE;

DROP TABLE IF EXISTS product_version_config_property_t CASCADE;

DROP TABLE IF EXISTS product_version_config_profile_t CASCADE;

DROP TABLE IF EXISTS config_profile_property_t CASCADE;

DROP TABLE IF EXISTS config_profile_config_t CASCADE;

DROP TABLE IF EXISTS config_profile_t CASCADE;

DROP TABLE IF EXISTS product_version_environment_t CASCADE;

DROP TABLE IF EXISTS product_version_t CASCADE;

DROP TABLE IF EXISTS platform_t CASCADE;

DROP TABLE IF EXISTS pipeline_t CASCADE;

DROP TABLE IF EXISTS snapshot_instance_file_t CASCADE;

DROP TABLE IF EXISTS snapshot_product_version_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_product_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_environment_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_instance_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_instance_app_api_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_instance_app_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_instance_api_property_t CASCADE;

DROP TABLE IF EXISTS snapshot_deployment_instance_property_t CASCADE;

DROP TABLE IF EXISTS config_snapshot_property_t CASCADE;

DROP TABLE IF EXISTS config_snapshot_t CASCADE;

DROP TABLE IF EXISTS deployment_t CASCADE;

DROP TABLE IF EXISTS product_version_pipeline_t CASCADE;

DROP TABLE IF EXISTS runtime_instance_t CASCADE;

DROP TABLE IF EXISTS api_endpoint_scope_t CASCADE;

DROP TABLE IF EXISTS host_t CASCADE;

DROP TABLE IF EXISTS org_t CASCADE;

DROP table IF EXISTS relation_t CASCADE;;

DROP table IF EXISTS relation_type_t CASCADE;

DROP table IF EXISTS value_locale_t CASCADE;

DROP table IF EXISTS ref_value_t CASCADE;

DROP table IF EXISTS ref_table_t CASCADE;

DROP table IF EXISTS attribute_permission_t CASCADE;

DROP table IF EXISTS attribute_row_filter_t CASCADE;

DROP table IF EXISTS attribute_col_filter_t CASCADE;

DROP table IF EXISTS attribute_user_t CASCADE;

DROP table IF EXISTS attribute_t CASCADE;

DROP table IF EXISTS group_user_t CASCADE;

DROP table IF EXISTS group_permission_t CASCADE;

DROP table IF EXISTS group_row_filter_t CASCADE;

DROP table IF EXISTS group_col_filter_t CASCADE;

DROP table IF EXISTS group_t CASCADE; -- move to ref

DROP table IF EXISTS user_permission_t CASCADE;

DROP table IF EXISTS user_row_filter_t CASCADE;

DROP table IF EXISTS user_col_filter_t CASCADE;

DROP table IF EXISTS role_user_t CASCADE;

DROP table IF EXISTS role_permission_t CASCADE;

DROP table IF EXISTS role_row_filter_t CASCADE;

DROP table IF EXISTS role_col_filter_t CASCADE;

DROP table IF EXISTS role_t CASCADE;

DROP table IF EXISTS position_permission_t;

DROP table IF EXISTS position_row_filter_t;

DROP table IF EXISTS position_col_filter_t;

DROP table IF EXISTS user_position_t CASCADE;

DROP table IF EXISTS position_t CASCADE;

DROP table IF EXISTS employee_t CASCADE;

DROP table IF EXISTS customer_t CASCADE;

DROP table IF EXISTS user_crypto_wallet_t CASCADE;

DROP table IF EXISTS user_host_t CASCADE;

DROP TABLE IF EXISTS user_t CASCADE;

DROP TABLE IF EXISTS auth_session_audit_t CASCADE;

DROP TABLE IF EXISTS auth_session_t CASCADE;

DROP TABLE IF EXISTS auth_refresh_token_t CASCADE;

DROP TABLE IF EXISTS auth_code_t CASCADE;

DROP TABLE IF EXISTS auth_ref_token_t CASCADE;

DROP TABLE IF EXISTS auth_client_token_t CASCADE;

DROP TABLE IF EXISTS auth_client_t CASCADE;

DROP TABLE IF EXISTS auth_client_owner_t CASCADE;

DROP TABLE IF EXISTS auth_provider_client_t CASCADE;

DROP TABLE IF EXISTS auth_provider_api_t CASCADE;

DROP TABLE IF EXISTS auth_provider_key_t CASCADE;

DROP TABLE IF EXISTS auth_provider_t CASCADE;

DROP TABLE IF EXISTS notification_t CASCADE;

DROP TABLE IF EXISTS message_t CASCADE;

DROP TABLE IF EXISTS config_property_t CASCADE;

DROP TABLE IF EXISTS command_idempotency_t CASCADE;
DROP TABLE IF EXISTS entity_identity_materialization_t CASCADE;
DROP TABLE IF EXISTS entity_identity_t CASCADE;
DROP TABLE IF EXISTS entity_aggregate_t CASCADE;
DROP TABLE IF EXISTS event_store_t CASCADE;
DROP TABLE IF EXISTS outbox_message_t CASCADE;
DROP TABLE IF EXISTS dead_letter_queue CASCADE;


CREATE TABLE event_store_t (
    id UUID PRIMARY KEY,                   -- Unique ID for the event itself
    host_id UUID NOT NULL,                 -- host_id will be the Kafka key for multi-tenancy
    user_id UUID NOT NULL,                 -- user_id will be the Kafka key for single-tenancy
    nonce BIGINT NOT NULL,                 -- The nonce per user sequence number
    aggregate_id VARCHAR(255) NOT NULL,    -- The ID of the aggregate (e.g., customer-123)
    aggregate_version BIGINT DEFAULT 1 NOT NULL,     -- Monotonically increasing sequence number per aggregate
    aggregate_type VARCHAR(255) NOT NULL,  -- The type of aggregate (e.g., 'Customer')
    event_type VARCHAR(255) NOT NULL,      -- The specific type of event (e.g., 'CustomerNameChanged')
    event_ts TIMESTAMP WITH TIME ZONE NOT NULL, -- When the event occurred
    payload JSONB NOT NULL,                -- The full event payload (JSON)
    metadata JSONB,                        -- Optional: correlation IDs, causation IDs, user ID, etc.
    -- Constraints for event order and uniqueness per aggregate
    UNIQUE (user_id, nonce),
    UNIQUE (aggregate_id, aggregate_version)
);

-- Index for efficient lookup by aggregate
CREATE INDEX idx_event_store_aggregate ON event_store_t (aggregate_id);
CREATE INDEX idx_event_store_event_ts_id ON event_store_t (event_ts, id)
    WHERE event_type LIKE 'Knowledge%'
       OR event_type LIKE 'AgentKnowledgeBase%';

CREATE TABLE entity_aggregate_t (
    aggregate_type   VARCHAR(255) NOT NULL,
    aggregate_id     VARCHAR(255) NOT NULL,
    entity_status    VARCHAR(16)  NOT NULL,
    created_event_id UUID         NOT NULL,
    created_ts       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    retired_ts       TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (aggregate_type, aggregate_id),
    CHECK (entity_status IN ('ACTIVE', 'RETIRED')),
    CHECK ((entity_status = 'ACTIVE' AND retired_ts IS NULL)
        OR (entity_status = 'RETIRED' AND retired_ts IS NOT NULL))
);

CREATE TABLE entity_identity_t (
    scope_type              VARCHAR(16)  NOT NULL,
    scope_id                VARCHAR(255) NOT NULL,
    aggregate_type          VARCHAR(255) NOT NULL,
    identity_schema_version INTEGER      NOT NULL,
    identity_hash           BYTEA        NOT NULL,
    identity_explanation    JSONB,
    aggregate_id            VARCHAR(255) NOT NULL,
    binding_status          VARCHAR(16)  NOT NULL,
    created_event_id        UUID         NOT NULL,
    created_ts              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    demoted_ts              TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (scope_type, scope_id, aggregate_type, identity_schema_version, identity_hash),
    FOREIGN KEY (aggregate_type, aggregate_id)
        REFERENCES entity_aggregate_t (aggregate_type, aggregate_id),
    CHECK (binding_status IN ('CURRENT', 'ALIAS')),
    CHECK ((binding_status = 'CURRENT' AND demoted_ts IS NULL)
        OR (binding_status = 'ALIAS' AND demoted_ts IS NOT NULL))
);

CREATE UNIQUE INDEX entity_identity_current_aggregate_version_uk
    ON entity_identity_t (aggregate_type, aggregate_id, identity_schema_version)
    WHERE binding_status = 'CURRENT';

CREATE TABLE command_idempotency_t (
    scope_type                  VARCHAR(16)  NOT NULL,
    scope_id                    VARCHAR(255) NOT NULL,
    principal_id                VARCHAR(255) NOT NULL,
    command_type                VARCHAR(255) NOT NULL,
    idempotency_key             VARCHAR(128) NOT NULL,
    request_hash                BYTEA        NOT NULL,
    request_fingerprint_version INTEGER      NOT NULL,
    aggregate_id                VARCHAR(255) NOT NULL,
    event_id                    UUID         NOT NULL,
    completed_ts                TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY (
        scope_type, scope_id, principal_id, command_type, idempotency_key
    ),
    CHECK (octet_length(request_hash) = 32),
    CHECK (request_fingerprint_version > 0),
    CHECK (length(idempotency_key) BETWEEN 1 AND 128)
);

CREATE INDEX command_idempotency_retention_idx
    ON command_idempotency_t (command_type, completed_ts);

-- Verified historical coverage gate for semantic-identity enforcement. A
-- missing or non-VERIFIED row keeps the aggregate group write-fenced.
CREATE TABLE entity_identity_materialization_t (
    aggregate_type             VARCHAR(255) NOT NULL,
    birth_event_type           VARCHAR(255) NOT NULL,
    policy_registry_version    VARCHAR(64)  NOT NULL,
    normalizer_version         INTEGER      NOT NULL,
    covered_event_count        BIGINT       NOT NULL,
    input_digest               BYTEA        NOT NULL,
    expected_owner_count       BIGINT       NOT NULL,
    expected_binding_count     BIGINT       NOT NULL,
    verification_digest        BYTEA        NOT NULL,
    scope_attestation_digest   BYTEA        NOT NULL,
    completion_status          VARCHAR(16)  NOT NULL,
    completed_by               VARCHAR(255) NOT NULL,
    completed_ts               TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (aggregate_type),
    CHECK (normalizer_version > 0),
    CHECK (covered_event_count >= 0),
    CHECK (expected_owner_count >= 0),
    CHECK (expected_binding_count >= 0),
    CHECK (octet_length(input_digest) = 32),
    CHECK (octet_length(verification_digest) = 32),
    CHECK (octet_length(scope_attestation_digest) = 32),
    CHECK (completion_status IN ('VERIFIED'))
);

CREATE TABLE outbox_message_t (
    id UUID PRIMARY KEY,                   -- Unique ID for this outbox message
    host_id UUID NOT NULL,                 -- host_id will be the Kafka key for multi-tenancy
    user_id UUID NOT NULL,                 -- user_id will be the Kafka key for single-tenancy
    nonce BIGINT NOT NULL,                 -- The nonce per user sequence number
    aggregate_id VARCHAR(255) NOT NULL,    -- The ID of the aggregate (for Kafka key)
    aggregate_version BIGINT DEFAULT 1 NOT NULL,     -- Monotonically increasing sequence number per aggregate
    aggregate_type VARCHAR(255) NOT NULL,  -- The type of aggregate (for Kafka topic routing)
    event_type VARCHAR(255) NOT NULL,      -- The specific type of event
    event_ts TIMESTAMP WITH TIME ZONE NOT NULL, -- When the event was created
    payload JSONB NOT NULL,                -- The full event payload (JSON)
    metadata JSONB,                        -- Optional: correlation IDs, causation IDs, user ID, etc.
    c_offset BIGINT UNIQUE,                -- Gapless offset for Postgres pub/sub
    transaction_id UUID NOT NULL,          -- Generated UUID to group all events belong the same transaction
    transaction_ordinal INTEGER NOT NULL CHECK (transaction_ordinal >= 0),
    transaction_count INTEGER NOT NULL CHECK (transaction_count > 0 AND transaction_ordinal < transaction_count)
    -- Note: No sequence_number here, as the Event Store manages that.
    -- Debezium will process these by insertion order.
);
-- An index on timestamp can be useful for manual cleanup or if not using CDC
-- CREATE INDEX idx_outbox_timestamp ON outbox_messages (timestamp);

CREATE TABLE dead_letter_queue (
  group_id VARCHAR(255),
  host_id UUID,
  user_id UUID,
  c_offset BIGINT,
  transaction_id VARCHAR(36),
  payload JSONB,
  exception TEXT,
  created_dt TIMESTAMP DEFAULT NOW()
);

-- Release-owned policy for projection cascades triggered by parent soft deletes.
-- Column shape validates a policy; it never selects a destructive action.
CREATE TABLE cascade_relationship_policy_t (
    parent_schema       VARCHAR(63) NOT NULL DEFAULT 'public',
    parent_table        VARCHAR(63) NOT NULL,
    child_schema        VARCHAR(63) NOT NULL DEFAULT 'public',
    child_table         VARCHAR(63) NOT NULL,
    constraint_name     VARCHAR(63) NOT NULL,
    delete_action       VARCHAR(16) NOT NULL,
    restore_action      VARCHAR(16) NOT NULL DEFAULT 'NONE',
    policy_description  VARCHAR(1024),
    update_user         VARCHAR(255) NOT NULL DEFAULT SESSION_USER,
    update_ts           TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (
        parent_schema,
        parent_table,
        child_schema,
        child_table,
        constraint_name
    ),
    CHECK (delete_action IN ('SOFT_DELETE', 'HARD_DELETE', 'IGNORE')),
    CHECK (restore_action IN ('RESTORE', 'NONE')),
    CHECK (
        (delete_action = 'SOFT_DELETE' AND restore_action = 'RESTORE')
        OR (delete_action IN ('HARD_DELETE', 'IGNORE') AND restore_action = 'NONE')
    )
);

CREATE TABLE scheduler_lock_t (
    lock_id INT PRIMARY KEY,
    instance_id VARCHAR(255) NOT NULL,
    last_heartbeat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO scheduler_lock_t (lock_id, instance_id, last_heartbeat)
VALUES (1, 'none', CURRENT_TIMESTAMP)
ON CONFLICT (lock_id) DO NOTHING;

-- Counter for gapless offsets
CREATE TABLE IF NOT EXISTS log_counter (
    id INT PRIMARY KEY,
    next_offset BIGINT NOT NULL
);
INSERT INTO log_counter (id, next_offset) VALUES (1, 1) ON CONFLICT DO NOTHING;

-- Consumer progress tracking
CREATE TABLE IF NOT EXISTS consumer_offsets (
    group_id TEXT NOT NULL,
    topic_id INT NOT NULL, -- 1 for global outbox
    partition_id INT NOT NULL DEFAULT 0, -- logical partition index
    next_offset BIGINT NOT NULL DEFAULT 1,
    PRIMARY KEY (group_id, topic_id, partition_id)
);


CREATE TABLE schedule_t (
    schedule_id          UUID NOT NULL, -- unique id for schedule event.
    host_id              UUID NOT NULL,
    schedule_name        VARCHAR(126) NOT NULL,
    frequency_unit       VARCHAR(16) NOT NULL,
    frequency_time       INTEGER NOT NULL,
    start_ts             TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    next_run_ts          TIMESTAMP WITH TIME ZONE NOT NULL,
    event_topic          VARCHAR(126) NOT NULL,
    event_type           VARCHAR(126) NOT NULL,
    event_data           TEXT NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, schedule_id)
);

CREATE INDEX idx_schedule_host_id ON schedule_t (host_id);
CREATE INDEX idx_schedule_active_next_run ON schedule_t (active, next_run_ts);
CREATE INDEX idx_schedule_host_owner_user ON schedule_t (host_id, owner_user_id);
CREATE INDEX idx_schedule_host_owner_position ON schedule_t (host_id, owner_position_id);


CREATE TABLE tag_t (
    tag_id               UUID NOT NULL,   -- unique id to identify the category
    host_id              UUID,            -- null mean global category
    entity_type          VARCHAR(50) NOT NULL,   -- entity type
    tag_name             VARCHAR(126) NOT NULL CHECK (
        tag_name = LOWER(tag_name) AND
        tag_name ~ '^[a-z0-9_-]+$'
    ),  -- tag name must be lower case and url friendly.
    tag_desc             VARCHAR(1024),          -- decription
    tag_group_code       VARCHAR(64),            -- optional group code for dropdown grouping.
    tag_group_label      VARCHAR(128),           -- optional group label for dropdown grouping.
    group_sort_order     INT,                    -- sort order for groups in dropdowns.
    tag_sort_order       INT,                    -- sort order for tags within a group.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (tag_id)
);

-- 1. Unique index for GLOBAL tags (where host_id IS NULL)
-- Ensures uniqueness of (entity_type, tag_name) ONLY when host_id is NULL
CREATE UNIQUE INDEX idx_tag_unique_global
ON tag_t (entity_type, tag_name)
WHERE host_id IS NULL;

-- 2. Unique index for TENANT-SPECIFIC tags (where host_id IS NOT NULL)
-- Ensures uniqueness of (host_id, entity_type, tag_name)
-- for rows that belong to a specific host.
CREATE UNIQUE INDEX idx_tag_unique_tenant
ON tag_t (host_id, entity_type, tag_name)
WHERE host_id IS NOT NULL;


CREATE INDEX idx_tag_entity_type ON tag_t (entity_type);
CREATE INDEX idx_tag_name ON tag_t (tag_name);
CREATE INDEX idx_tag_host_id ON tag_t (host_id);

CREATE TABLE entity_tag_t (
    entity_id             VARCHAR(126) NOT NULL,
    entity_type           VARCHAR(50) NOT NULL,
    tag_id                UUID NOT NULL REFERENCES tag_t(tag_id) ON DELETE CASCADE,
    aggregate_version     BIGINT DEFAULT 1 NOT NULL,
    active                BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user           VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts             TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (entity_id, entity_type, tag_id)
);

CREATE INDEX idx_entity_tag_id ON entity_tag_t (tag_id);
CREATE INDEX idx_entity_tag_entity ON entity_tag_t (entity_id, entity_type);
CREATE INDEX idx_entity_tag_filter ON entity_tag_t (entity_type, tag_id, entity_id) WHERE active = TRUE;


CREATE TABLE category_t (
    category_id          UUID NOT NULL,   -- unique id to identify the category
    host_id              UUID,            -- null mean global category
    entity_type          VARCHAR(50) NOT NULL,   -- the entity type
    category_name        VARCHAR(126) NOT NULL CHECK (
        category_name = LOWER(category_name) AND
        category_name ~ '^[a-z0-9_-]+$'
    ),  -- category name, must be lower case and url friendly.
    category_desc        VARCHAR(1024),          -- decription
    parent_category_id   UUID REFERENCES category_t(category_id) ON DELETE SET NULL, -- parent category id, null if there is no parent.
    sort_order           INT DEFAULT 0,          -- sort order on the UI
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (category_id)
);

-- 1. Unique index for GLOBAL categories (where host_id IS NULL)
-- Ensures uniqueness of (entity_type, category_name, parent_category_id) ONLY when host_id is NULL
CREATE UNIQUE INDEX idx_category_unique_global
ON category_t (entity_type, category_name, parent_category_id)
NULLS NOT DISTINCT -- Handles NULLs in parent_category_id correctly
WHERE host_id IS NULL;

-- 2. Unique index for TENANT-SPECIFIC categories (where host_id IS NOT NULL)
-- Ensures uniqueness of (host_id, entity_type, category_name, parent_category_id)
-- for rows that belong to a specific host.
CREATE UNIQUE INDEX idx_category_unique_tenant
ON category_t (host_id, entity_type, category_name, parent_category_id)
NULLS NOT DISTINCT -- Handles NULLs in parent_category_id correctly
WHERE host_id IS NOT NULL;


CREATE INDEX idx_category_entity_type ON category_t (entity_type);
CREATE INDEX idx_category_parent ON category_t (parent_category_id);
CREATE INDEX idx_category_name ON category_t (category_name);
CREATE INDEX idx_category_host_id ON category_t (host_id);

CREATE TABLE entity_category_t (
    entity_id             VARCHAR(126) NOT NULL,
    entity_type           VARCHAR(50) NOT NULL,
    category_id           UUID NOT NULL REFERENCES category_t(category_id) ON DELETE CASCADE,
    aggregate_version     BIGINT DEFAULT 1 NOT NULL,
    active                BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user           VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts             TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (entity_id, entity_type, category_id)
);

CREATE INDEX idx_entity_category_id ON entity_category_t (category_id);
CREATE INDEX idx_entity_category_entity ON entity_category_t (entity_id, entity_type);
CREATE INDEX idx_entity_category_filter ON entity_category_t (entity_type, category_id, entity_id) WHERE active = TRUE;

CREATE TABLE schema_t (
    schema_id            VARCHAR(126) NOT NULL CHECK (
        schema_id = LOWER(schema_id) AND
        schema_id ~ '^[a-z0-9_-]+$'
    ),  -- schema id, must be lower case and url friendly and uniquely identify a schema
    host_id              UUID,            -- null means global schema
    schema_alias         VARCHAR(126) CHECK (
        schema_alias IS NULL OR (
            schema_alias = LOWER(schema_alias) AND
            schema_alias ~ '^[a-z0-9_-]+$'
        )
    ),  -- optional url-friendly external schema alias
    schema_version       VARCHAR(12) NOT NULL,   -- the version of the schema
    schema_type          VARCHAR(16) NOT NULL,   -- schema type
    spec_version         VARCHAR(12) NOT NULL,   -- schema specification version
    schema_source        VARCHAR(126) NOT NULL,  -- which api or app owns the schema
    schema_name          VARCHAR(126) NOT NULL,  -- schema name
    schema_desc          VARCHAR(1024),          -- description of the schema
    schema_body          VARCHAR(65535) NOT NULL,-- schema body
    schema_owner         UUID NOT NULL,          -- schema owner
    schema_status        CHAR(1) DEFAULT 'P' NOT NULL,  -- D draft P published R retired
    external_visible     BOOLEAN NOT NULL DEFAULT FALSE, -- whether /r/schema can expose this schema
    example              VARCHAR(65535),         -- json example
    comment_status       CHAR(1) DEFAULT 'O' NOT NULL, -- comment open or closed. O open C close
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (schema_id)
);

ALTER TABLE schema_t
    ADD CHECK ( schema_status IN ('D', 'P', 'R'));

-- Ensures uniqueness of (schema_id, schema_version) ONLY when host_id is NULL
CREATE UNIQUE INDEX idx_schema_unique_global
ON schema_t (schema_id, schema_version)
WHERE host_id IS NULL;

-- 2. Unique index for TENANT-SPECIFIC schemas (where host_id IS NOT NULL)
-- Ensures uniqueness of (host_id, schema_id, schema_version)
-- for rows that belong to a specific host.
CREATE UNIQUE INDEX idx_schema_unique_tenant
ON schema_t (host_id, schema_id, schema_version)
WHERE host_id IS NOT NULL;


-- Add index on host_id for efficient tenant-specific lookups
CREATE INDEX idx_schema_host_id ON schema_t (host_id);
CREATE UNIQUE INDEX idx_schema_alias_global
ON schema_t (schema_alias)
WHERE host_id IS NULL AND schema_alias IS NOT NULL;

CREATE UNIQUE INDEX idx_schema_alias_tenant
ON schema_t (host_id, schema_alias)
WHERE host_id IS NOT NULL AND schema_alias IS NOT NULL;

CREATE INDEX idx_schema_external_alias_global
ON schema_t (schema_alias, schema_version)
WHERE host_id IS NULL AND external_visible = TRUE AND active = TRUE;

CREATE INDEX idx_schema_external_alias_tenant
ON schema_t (host_id, schema_alias, schema_version)
WHERE host_id IS NOT NULL AND external_visible = TRUE AND active = TRUE;

-- Add index on schema_name for lookups by name
CREATE INDEX idx_schema_schema_name ON schema_t (schema_name);
-- Add index on schema_type for filtering by schema type
CREATE INDEX idx_schema_schema_type ON schema_t (schema_type);

-- all entities that can potentially share between hosts will not have host_id column.

CREATE TABLE rule_t (
    rule_id              VARCHAR(255) NOT NULL, -- com.networknt.rule01. or rule01.networknt.com.
    host_id              UUID,                  -- null for global rule
    rule_name            VARCHAR(128) NOT NULL, -- short human-readable name.
    rule_type            VARCHAR(32) NOT NULL,  -- catalog type used to filter rule selection.
    common               CHAR(1) DEFAULT 'N' NOT NULL,
    version              VARCHAR(32),           -- version that follows major.minor.patch pattern.
    author               VARCHAR(128),
    rule_desc            VARCHAR(1024),
    condition_language   VARCHAR(16) DEFAULT 'cel' NOT NULL,
    condition_security_profile VARCHAR(32),
    rule_body            VARCHAR(65535) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (rule_id)
);

ALTER TABLE rule_t
    ADD CHECK ( common IN ('Y', 'N'));

ALTER TABLE rule_t
    ADD CHECK ( condition_language IN ('cel'));

ALTER TABLE rule_t
    ADD CHECK ( condition_security_profile IS NULL OR condition_security_profile IN ('strict', 'standard', 'internal-admin'));

-- Ensures uniqueness of (rule_id) ONLY when host_id is NULL
CREATE UNIQUE INDEX idx_rule_unique_global
ON rule_t (rule_id)
WHERE host_id IS NULL;

-- Ensures uniqueness of (host_id, rule_id) for rows that belong to a specific host.
CREATE UNIQUE INDEX idx_rule_unique_tenant
ON rule_t (host_id, rule_id)
WHERE host_id IS NOT NULL;

-- Add index on host_id for efficient tenant-specific lookups
CREATE INDEX idx_rule_host_id ON rule_t (host_id);

CREATE TABLE rule_test_case_t (
    rule_id              VARCHAR(255) NOT NULL,
    test_id              VARCHAR(128) NOT NULL,
    host_id              UUID,
    test_name            VARCHAR(256) NOT NULL,
    test_desc            VARCHAR(1024),
    executor_type        VARCHAR(32) DEFAULT 'java' NOT NULL,
    test_mode            VARCHAR(32) DEFAULT 'conditions' NOT NULL,
    input_context        JSONB NOT NULL,
    expected_result      BOOLEAN,
    expected_outputs     JSONB,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (rule_id, test_id),
    CONSTRAINT rule_test_case_rule_fk FOREIGN KEY (rule_id) REFERENCES rule_t(rule_id) ON DELETE CASCADE
);

ALTER TABLE rule_test_case_t
    ADD CHECK (executor_type IN ('java', 'rust', 'both'));

ALTER TABLE rule_test_case_t
    ADD CHECK (test_mode IN ('conditions', 'full'));

CREATE INDEX idx_rule_test_case_host_rule_active ON rule_test_case_t (host_id, rule_id, active);
CREATE INDEX idx_rule_test_case_update ON rule_test_case_t (host_id, update_ts DESC);


-- define a list of rules that needs to be executed together in sequence.
CREATE TABLE rule_group_t (
    group_id             VARCHAR(64) NOT NULL,
    rule_id              VARCHAR(255) NOT NULL,
    host_id              UUID,                 -- null for global rule group.
    group_name           VARCHAR(128) NOT NULL,
    execute_sequence     INT NOT NULL,         -- execute sequence for the rule_id in the group.
    group_desc           VARCHAR(4000),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(group_id, rule_id)
);

-- Ensures uniqueness of (group_id, rule_id) ONLY when host_id is NULL
CREATE UNIQUE INDEX idx_rule_group_unique_global
ON rule_group_t (group_id, rule_id)
WHERE host_id IS NULL;

-- Ensures uniqueness of (host_id, group_id, rule_id) for rows that belong to a specific host.
CREATE UNIQUE INDEX idx_rule_group_unique_tenant
ON rule_group_t (host_id, group_id, rule_id)
WHERE host_id IS NOT NULL;

-- Add index on host_id for efficient tenant-specific lookups
CREATE INDEX idx_rule_group_host_id ON rule_group_t (host_id);

-- api must associate with a host, so host_id is in this table.
CREATE TABLE api_endpoint_rule_t (
    host_id              UUID NOT NULL,
    endpoint_id          UUID NOT NULL,
    rule_id              VARCHAR(255) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
ALTER TABLE api_endpoint_rule_t ADD CONSTRAINT api_rule_pk PRIMARY KEY ( host_id, endpoint_id, rule_id);
CREATE INDEX idx_api_endpoint_rule_endpoint_active ON api_endpoint_rule_t(host_id, endpoint_id, active);


CREATE TABLE api_t (
    host_id                 UUID NOT NULL,
    api_id                  VARCHAR(16) NOT NULL,    -- unique identifier within the org/host.
    api_name                VARCHAR(128) NOT NULL,
    api_desc                VARCHAR(1024),
    operation_owner         UUID,
    delivery_owner          UUID,
    region                  VARCHAR(16),
    business_group          VARCHAR(64),
    lob                     VARCHAR(16),
    platform                VARCHAR(20),
    capability              VARCHAR(20),
    git_repo                VARCHAR(1024),
    api_status              VARCHAR(32) NOT NULL,
    owner_user_id           UUID,
    owner_position_id       VARCHAR(128),
    aggregate_version       BIGINT DEFAULT 1 NOT NULL,
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE api_t ADD CONSTRAINT api_pk PRIMARY KEY (host_id, api_id);



CREATE TABLE api_version_t (
    host_id                 UUID NOT NULL,
    api_version_id          UUID NOT NULL,
    api_id                  VARCHAR(16) NOT NULL,
    api_version             VARCHAR(16) NOT NULL,
    api_type                VARCHAR(16) NOT NULL,   -- openapi, graphql, hybrid, mcp, lightapi
    transport_config        TEXT,                   -- JSON format for transport_config for mcp
    -- {"transport": "stdio", "command": "npx", "args": ["-y", "@mcp/server-google"], "env": {"KEY": "VAL"}}
    -- {"transport": "streamable http", "url": "http://example.com:8080/mcp"}
    protocol                VARCHAR(5) NOT NULL DEFAULT 'https',
    service_id              VARCHAR(512) NOT NULL,  -- several api version can have one service_id
    env_tag                 VARCHAR(16),
    target_host             VARCHAR(128),
    api_version_desc        VARCHAR(1024),
    spec_link               VARCHAR(1024),
    spec                    TEXT,
    owner_user_id           UUID,
    owner_position_id       VARCHAR(128),
    aggregate_version       BIGINT DEFAULT 1 NOT NULL,
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, api_version_id),
    FOREIGN KEY(host_id, api_id) REFERENCES api_t(host_id, api_id) ON DELETE CASCADE
);


ALTER TABLE api_version_t ADD CONSTRAINT api_version_uk UNIQUE(host_id, api_id, api_version);
CREATE INDEX idx_api_version_catalog_summary ON api_version_t(host_id, api_id, active, update_ts DESC);

CREATE TABLE api_endpoint_t (
    host_id              UUID NOT NULL,
    endpoint_id          UUID NOT NULL,
    api_version_id       UUID NOT NULL,
    endpoint             VARCHAR(1024) NOT NULL,  -- endpoint path@method
    http_method          VARCHAR(10),
    endpoint_path        VARCHAR(1024),
    endpoint_name        VARCHAR(128) NOT NULL,
    tool_schema          TEXT,                    -- The JSON Schema for the tool's input
    response_schema      TEXT,                    -- Optional JSON Schema for the tool's output
    tool_metadata        TEXT,                    -- JSON tool metadata. {"destructive": true, "read_only": false}
    routing_domain       VARCHAR(128),
    semantic_namespace   VARCHAR(128),
    sensitivity_tier     VARCHAR(64),
    semantic_weight      REAL DEFAULT 1.0,
    source_protocol      VARCHAR(50),
    lifecycle_status     VARCHAR(32) DEFAULT 'active',
    cost_tier            VARCHAR(32),
    target_personas      TEXT,
    endpoint_desc        TEXT,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, endpoint_id),
    FOREIGN KEY(host_id, api_version_id) REFERENCES api_version_t(host_id, api_version_id) ON DELETE CASCADE
);

ALTER TABLE api_endpoint_t
    ADD CHECK ( http_method IN ( 'delete', 'get', 'patch', 'post', 'put', 'call' ) );

ALTER TABLE api_endpoint_t
    ADD CONSTRAINT chk_api_endpoint_source_protocol CHECK (source_protocol IN ('openapi', 'mcp', 'lightapi', 'http') OR source_protocol IS NULL),
    ADD CONSTRAINT chk_api_endpoint_lifecycle CHECK (lifecycle_status IS NOT NULL AND lifecycle_status IN ('active', 'deprecated', 'retired')),
    ADD CONSTRAINT chk_api_endpoint_cost CHECK (cost_tier IN ('low', 'medium', 'high') OR cost_tier IS NULL);

CREATE INDEX idx_api_endpoint_routing ON api_endpoint_t(host_id, active, routing_domain, semantic_namespace, sensitivity_tier);
CREATE INDEX idx_api_endpoint_source_protocol ON api_endpoint_t(host_id, source_protocol);
CREATE INDEX idx_api_endpoint_lifecycle_cost ON api_endpoint_t(host_id, active, lifecycle_status, cost_tier);
CREATE INDEX idx_api_endpoint_version_active ON api_endpoint_t(host_id, api_version_id, active);
ALTER TABLE api_endpoint_t ADD CONSTRAINT api_endpoint_natural_uk UNIQUE(host_id, api_version_id, endpoint);


CREATE TABLE api_endpoint_scope_t (
    host_id                 UUID NOT NULL,
    endpoint_id             UUID NOT NULL,
    scope                   VARCHAR(128) NOT NULL,
    scope_desc              VARCHAR(1024),
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE api_endpoint_scope_t ADD CONSTRAINT api_endpoint_scope_pk PRIMARY KEY (host_id, endpoint_id, scope );

-- The calling relationship between app and api with scope.
CREATE TABLE app_api_t (
    host_id                 UUID NOT NULL,
    app_id                  VARCHAR(512) NOT NULL,
    endpoint_id             UUID NOT NULL,
    scope                   VARCHAR(128) NOT NULL,
    owner_user_id           UUID,
    owner_position_id       VARCHAR(128),
    aggregate_version       BIGINT DEFAULT 1 NOT NULL,
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, app_id, endpoint_id, scope),
    FOREIGN KEY(host_id, endpoint_id, scope) REFERENCES api_endpoint_scope_t(host_id, endpoint_id, scope) ON DELETE CASCADE
);


CREATE TABLE app_t (
    host_id              UUID NOT NULL,
    app_id               VARCHAR(512) NOT NULL,
    app_name             VARCHAR(128) NOT NULL,
    app_desc             VARCHAR(2048),
    is_kafka_app         BOOLEAN DEFAULT false,
    operation_owner      UUID,
    delivery_owner       UUID,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE app_t ADD CONSTRAINT app_pk PRIMARY KEY ( host_id, app_id);




CREATE TABLE chain_handler_t (
    chain_id          UUID NOT NULL,
    configuration_id  UUID NOT NULL,
    sequence_id       INTEGER NOT NULL,
    aggregate_version BIGINT DEFAULT 1 NOT NULL,
    active            BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user       VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts         TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE chain_handler_t ADD CONSTRAINT chain_handler_pk PRIMARY KEY ( chain_id,
                                                                          configuration_id );



-- each config file will have an entry in this table including the deployment files.
CREATE TABLE config_t (
    config_id                 UUID NOT NULL,
    config_name               VARCHAR(128) NOT NULL,
    config_phase              CHAR(1) NOT NULL DEFAULT 'R', -- D deployment R runtime
    config_type               VARCHAR(32) DEFAULT 'Handler',
    light4j_version           VARCHAR(12), -- initial population has no version. Each new config file introduced willl have a version
    class_path                VARCHAR(1024),
    config_desc               VARCHAR(4096),
    aggregate_version         BIGINT DEFAULT 1 NOT NULL,
    active                    BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user               VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                 TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE config_t
    ADD CHECK ( config_type IN ( 'Handler', 'Module', 'Template') );

ALTER TABLE config_t
    ADD CHECK ( config_phase IN ( 'G', 'D', 'R') ); -- G generator, D deployment, R runtime

ALTER TABLE config_t ADD CONSTRAINT config_pk PRIMARY KEY ( config_id );

ALTER TABLE config_t ADD CONSTRAINT config_uk UNIQUE (config_name);



-- each config file will have a config_id reference and this table contains all the properties including default.
CREATE TABLE config_property_t (
    config_id                 UUID NOT NULL,
    property_id               UUID NOT NULL,
    property_name             VARCHAR(64) NOT NULL,
    property_type             VARCHAR(32) DEFAULT 'Config' NOT NULL,
    light4j_version           VARCHAR(12), -- only newly introduced property has a version.
    display_order             INTEGER,
    required                  BOOLEAN DEFAULT false NOT NULL,
    property_desc             VARCHAR(4096),
    property_value            TEXT,
    value_type                VARCHAR(32),
    resource_type             VARCHAR(30) DEFAULT 'none',
    aggregate_version         BIGINT DEFAULT 1 NOT NULL,
    active                    BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user               VARCHAR(255) DEFAULT SESSION_USER NOT NULL,
    update_ts                 TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(property_id)
);

ALTER TABLE config_property_t
    ADD CHECK ( property_type IN ( 'Cert', 'Config', 'File') );


COMMENT ON COLUMN config_property_t.property_value IS
    'Property Default Value';

COMMENT ON COLUMN config_property_t.value_type IS
    'One of string, boolean, integer, float, map, list';

COMMENT ON COLUMN config_property_t.resource_type IS
  'One of none, api, app, app_api, api|app_api, app|app_api, all';

ALTER TABLE config_property_t ADD CONSTRAINT config_property_uk UNIQUE ( config_id, property_name );


CREATE TABLE environment_property_t (
    host_id            UUID NOT NULL,
    environment        VARCHAR(16) NOT NULL,
    property_id        UUID NOT NULL,
    property_value     TEXT,
    aggregate_version  BIGINT DEFAULT 1 NOT NULL,
    active             BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user        VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts          TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, environment, property_id),
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE CASCADE
);


-- for each platform like jenkins, ansible etc.
CREATE TABLE platform_t (
    host_id                     UUID NOT NULL,
    platform_id                 UUID NOT NULL,
    platform_name               VARCHAR(126) NOT NULL,
    platform_version            VARCHAR(8) NOT NULL,
    client_type                 VARCHAR(10)NOT NULL,
    client_url                  VARCHAR(255) NOT NULL,
    credentials                 VARCHAR(255) NOT NULL,
    proxy_url                   VARCHAR(255),
    proxy_port                  INTEGER,
    handler_class               VARCHAR(1024) NOT NULL, -- The handler class in light-portal to interact with the platform.
    console_url                 VARCHAR(255), -- the url pattern that we can access the console logs.
    environment                 VARCHAR(16),
    zone                        VARCHAR(16),
    region                      VARCHAR(16),
    lob                         VARCHAR(16),
    aggregate_version           BIGINT DEFAULT 1 NOT NULL,
    active                      BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user                 VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, platform_id)
);

ALTER TABLE platform_t ADD CONSTRAINT platform_uk UNIQUE(host_id, platform_name, platform_version);

--  each platform will have multiple pipelines.
CREATE TABLE pipeline_t (
    host_id                     UUID NOT NULL,
    pipeline_id                 UUID NOT NULL,
    platform_id                 UUID NOT NULL,
    pipeline_version            VARCHAR(16) NOT NULL,     -- if there is no version, it doesn't make sense we have current flag.
    pipeline_name               VARCHAR(1024) NOT NULL,   -- name of the pipeline that will be displayed in dropdown.
    current                     BOOLEAN DEFAULT false,    -- The current pipeline for the platform_id if it is true.
    endpoint                    VARCHAR(1024) NOT NULL,
    version_status              VARCHAR(16) NOT NULL,     -- from ref table pipeline_version_status. Supported, Outdated, Deprecated, Removed
    system_env                  VARCHAR(16) NOT NULL,     -- a pipeline must be
    runtime_env                 VARCHAR(16),
    request_schema              TEXT NOT NULL,
    response_schema             TEXT NOT NULL,
    aggregate_version           BIGINT DEFAULT 1 NOT NULL,
    active                      BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user                 VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, pipeline_id),
    FOREIGN KEY(host_id, platform_id) REFERENCES platform_t(host_id, platform_id) ON DELETE CASCADE
);

ALTER TABLE pipeline_t ADD CONSTRAINT pipeline_uk UNIQUE(host_id, platform_id, pipeline_name, pipeline_version);


CREATE TABLE instance_t (
    host_id              UUID NOT NULL,
    instance_id          UUID NOT NULL,
    instance_name        VARCHAR(126) NOT NULL,
    product_version_id   UUID NOT NULL,
    service_id           VARCHAR(512) NOT NULL, -- for a standalone product, use service_id for query.
    current              BOOLEAN DEFAULT false, -- for this service_id, the current product version
    readonly             BOOLEAN DEFAULT false, -- lock the instance level configuration customization.
    environment          VARCHAR(16),
    service_desc         VARCHAR(4096),         -- service description and it should be the same for all instances
    instance_desc        VARCHAR(1024),         -- instance description and it is related to the specific prod version
    zone                 VARCHAR(16),
    region               VARCHAR(16),
    lob                  VARCHAR(16),
    resource_name        VARCHAR(126),          -- identify the resource, host, or namespace.
    business_name        VARCHAR(126),
    env_tag              VARCHAR(16),           -- envirnment tag along with service_id for service lookup and configuration.
    topic_classification VARCHAR(126),          -- for kafka sidecar only.
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_id)
);


COMMENT ON COLUMN instance_t.service_id IS
' Naming Convention: (delimit with dash, use lower case)
  <product>-<region/country>-[lob]-<app/domain>-<resource/host>-<zone>
    - Light Gateway: lg-ca-eadp-sag1-aiz
    - Light Balancer: lb-ca-gb-sv0a0332-corp
    - Light Proxy Client: lpc-ca-gb-sv0a0332leg1-corp
    - Light Proxy Server: lps-ph-sv0a0123-aiz
    - Light Proxy Sidecar: lp-ca-gb-claims-payments-corp
    - Light Proxy Lambda: lpl-ca-xp-client-corp
    - Kafka Sidecar: ks-ca-grs-member-corp
';


-- Allow only one record with NULL env_tag per combination
CREATE UNIQUE INDEX instance_uk_null_env
ON instance_t (host_id, service_id, product_version_id)
WHERE env_tag IS NULL;

-- Allow multiple records with different non-NULL env_tags
CREATE UNIQUE INDEX instance_uk_with_env
ON instance_t (host_id, service_id, env_tag, product_version_id)
WHERE env_tag IS NOT NULL;


-- one to many from the instance_t table.
CREATE TABLE deployment_instance_t (
    host_id                UUID NOT NULL,
    instance_id            UUID NOT NULL,
    deployment_instance_id UUID NOT NULL,         -- UUID as part of the PK
    platform_job_id        VARCHAR(255),          -- deployment platform job id that is used to link to logging etc. returned from sync call or async response
    service_id             VARCHAR(512) NOT NULL, -- A unique engish identifier with the leg id.
    ip_address             VARCHAR(30),           -- for VM deployment only, both v4 or v6
    port_number            INT,                   -- port number to match the runtime instance along with ip address and service_id(logical instance)
    system_env             VARCHAR(16) NOT NULL,  -- choose from product_version_environment_t table as dropdown.
    runtime_env            VARCHAR(16) NOT NULL,  -- which jdk, sytem etc.
    pipeline_id            UUID NOT NULL,         -- picked up pipeline for the deployment
    deploy_status          VARCHAR(32) DEFAULT 'NotDeployed' NOT NULL,  -- NotDeployed, Deploying, Deployed, DeployFailed, UnDeployed, UnDeployFailed
    owner_user_id          UUID,
    owner_position_id      VARCHAR(128),
    aggregate_version      BIGINT DEFAULT 1 NOT NULL,
    active                 BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user            VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts              TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, deployment_instance_id),
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE
);

ALTER TABLE deployment_instance_t ADD CONSTRAINT deployment_instance_uk UNIQUE(host_id, instance_id, service_id);
CREATE INDEX idx_deployment_instance_host_owner_user ON deployment_instance_t (host_id, owner_user_id);
CREATE INDEX idx_deployment_instance_host_owner_position ON deployment_instance_t (host_id, owner_position_id);

-- customized config at the deployment instance level. Usually, it is the hostname.
CREATE TABLE deployment_instance_property_t (
    host_id                 UUID NOT NULL,
    deployment_instance_id  UUID NOT NULL,
    property_id             UUID NOT NULL,
    property_value          TEXT,
    aggregate_version       BIGINT DEFAULT 1 NOT NULL,
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, deployment_instance_id, property_id),
    FOREIGN KEY(host_id, deployment_instance_id) REFERENCES deployment_instance_t(host_id, deployment_instance_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE CASCADE
);


-- one gateway instance can have multiple APIs managed by it.
CREATE TABLE instance_api_t (
    host_id              UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    instance_id          UUID NOT NULL,
    api_version_id       UUID NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_api_id),
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, api_version_id) REFERENCES api_version_t(host_id, api_version_id) ON DELETE CASCADE
);

ALTER TABLE instance_api_t ADD CONSTRAINT instance_api_uk UNIQUE (host_id, instance_id, api_version_id);
CREATE INDEX idx_instance_api_version_active ON instance_api_t(host_id, api_version_id, active);


-- customized config property for the instance api.
CREATE TABLE instance_api_property_t (
    host_id              UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_api_id, property_id),
    FOREIGN KEY(host_id, instance_api_id) REFERENCES instance_api_t(host_id, instance_api_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE CASCADE
);

-- path prefix definition for the instance api.
CREATE TABLE instance_api_path_prefix_t (
    host_id              UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    path_prefix          VARCHAR(1024) NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_api_id, path_prefix),
    FOREIGN KEY(host_id, instance_api_id) REFERENCES instance_api_t(host_id, instance_api_id) ON DELETE CASCADE
);

-- one gateway instance may have many applications connecting to it to consume APIs.
CREATE TABLE instance_app_t (
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    instance_id          UUID NOT NULL,
    app_id               VARCHAR(512) NOT NULL,
    app_version          VARCHAR(16) NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_app_id),
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, app_id) REFERENCES app_t(host_id, app_id) ON DELETE CASCADE
);

ALTER TABLE instance_app_t ADD CONSTRAINT instance_app_uk UNIQUE (host_id, instance_id, app_id, app_version);



CREATE TABLE instance_app_property_t (
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_app_id, property_id),
    FOREIGN KEY(host_id, instance_app_id) REFERENCES instance_app_t(host_id, instance_app_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE CASCADE
);

-- add instance api and app association relation, there is no instance_id in the table because both instance api
-- and instance app will have an associated instance id. The two instance app and api should related to the same
-- instance. For example, light-gateway instance that link both client application to api microservice.
CREATE TABLE instance_app_api_t (
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_app_id, instance_api_id),
    FOREIGN KEY(host_id, instance_app_id) REFERENCES instance_app_t(host_id, instance_app_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, instance_api_id) REFERENCES instance_api_t(host_id, instance_api_id) ON DELETE CASCADE
);


CREATE TABLE instance_app_api_property_t (
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_app_id, instance_api_id, property_id)
);

ALTER TABLE instance_app_api_property_t
    ADD CONSTRAINT instance_app_api_property_fk FOREIGN KEY (host_id, instance_app_id, instance_api_id)
        REFERENCES instance_app_api_t (host_id, instance_app_id, instance_api_id)
            ON DELETE CASCADE;

ALTER TABLE instance_app_api_property_t
    ADD CONSTRAINT config_property_fk1 FOREIGN KEY (property_id)
        REFERENCES config_property_t( property_id)
            ON DELETE CASCADE;


CREATE TABLE instance_property_t (
    host_id              UUID NOT NULL,
    instance_id          UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE instance_property_t ADD CONSTRAINT instance_property_pk PRIMARY KEY ( host_id, instance_id,
                                                                                  property_id);

-- Stores additional config files specific for the instance.
CREATE TABLE instance_file_t (
    host_id              UUID NOT NULL,
    instance_file_id     UUID NOT NULL,
    instance_id          UUID NOT NULL,
    config_phase         CHAR(1) DEFAULT 'R' NOT NULL,
    file_type            VARCHAR(32) DEFAULT 'File',
    file_name            VARCHAR (126) NOT NULL,
    file_value           TEXT NOT NULL,
    file_desc            VARCHAR(1024) NOT NULL,
    expiration_ts        TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, instance_file_id)
);

COMMENT ON COLUMN instance_file_t.expiration_ts IS
  'An expiration timestamp is optional, but mostly should be used for Certificates that are bound to expire some day.';

ALTER TABLE instance_file_t ADD v_file_name VARCHAR(126) GENERATED ALWAYS AS ( LOWER(file_name) ) STORED;

ALTER TABLE instance_file_t
    ADD CHECK ( file_type IN ( 'Cert', 'File' ) );

ALTER TABLE instance_file_t
    ADD CONSTRAINT instance_file_config_phase_check
        CHECK ( config_phase IN ( 'G', 'D', 'R' ) );

CREATE UNIQUE INDEX instance_file_uk
    ON instance_file_t (host_id, instance_id, config_phase, v_file_name)
    WHERE active = TRUE;

ALTER TABLE instance_file_t
  ADD CONSTRAINT instance_file_fk FOREIGN KEY (host_id, instance_id)
    REFERENCES instance_t (host_id, instance_id)
      ON DELETE CASCADE;


-- product level customized properties which is generic or common for the product.
CREATE TABLE product_property_t (
    product_id           VARCHAR(8) NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE product_property_t ADD CONSTRAINT product_property_pk PRIMARY KEY ( product_id,
                                                                                property_id);

CREATE TABLE product_version_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    product_id           VARCHAR(8) NOT NULL,
    product_version      VARCHAR(12) NOT NULL, -- internal product version
    light4j_version      VARCHAR(12) NOT NULL, -- open source release version
    break_code           BOOLEAN DEFAULT false, -- breaking code change to upgrade to this version.
    break_config         BOOLEAN DEFAULT false, -- config server need this to decide if clone is allowed for this version.
    release_note         TEXT,
    version_desc         VARCHAR(1024),
    release_type         VARCHAR(24) NOT NULL, -- Alpha Version, Beta Version, Release Candidate, General Availability, Production Release
    current              BOOLEAN DEFAULT false,
    version_status       VARCHAR(16) NOT NULL, -- Supported, Deprecated, NotSupported
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id)
);

ALTER TABLE product_version_t ADD CONSTRAINT product_version_uk UNIQUE (host_id, product_id, product_version);

-- mapping of product version to systme environment
CREATE TABLE product_version_environment_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    system_env           VARCHAR(16) NOT NULL,
    runtime_env          VARCHAR(16) NOT NULL,
    current              BOOLEAN DEFAULT false,  -- The default system and runtime env conbination for the product version in the host.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id, system_env, runtime_env),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE
);


-- reusable config contract/profile shared by product versions.
CREATE TABLE config_profile_t (
    profile_id           UUID PRIMARY KEY,
    profile_name         VARCHAR (255) NOT NULL,
    runtime_family       VARCHAR (32) NOT NULL,
    product_id           VARCHAR (8) NOT NULL,
    light4j_version      VARCHAR (32),
    contract_version     VARCHAR (64) NOT NULL,
    profile_desc         VARCHAR (1024),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE UNIQUE INDEX config_profile_unique_idx
    ON config_profile_t(runtime_family, product_id, contract_version)
    WHERE active = true;

-- config files included in a reusable config profile.
CREATE TABLE config_profile_config_t (
    profile_id           UUID NOT NULL,
    config_id            UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(profile_id, config_id),
    FOREIGN KEY(profile_id)
        REFERENCES config_profile_t(profile_id) ON DELETE CASCADE,
    FOREIGN KEY(config_id)
        REFERENCES config_t(config_id) ON DELETE CASCADE
);

-- config properties included in a reusable config profile.
CREATE TABLE config_profile_property_t (
    profile_id           UUID NOT NULL,
    property_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(profile_id, property_id),
    FOREIGN KEY(profile_id)
        REFERENCES config_profile_t(profile_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id)
        REFERENCES config_property_t(property_id) ON DELETE CASCADE
);

-- config file and product version mapping (applicable config for pv)
CREATE TABLE product_version_config_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    config_id            UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id, config_id),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE,
    FOREIGN KEY(config_id)
        REFERENCES config_t(config_id) ON DELETE CASCADE
);

-- config property and product version mapping (applicable config properties for pv)
CREATE TABLE product_version_config_property_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    property_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id, property_id),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id)
        REFERENCES config_property_t(property_id) ON DELETE CASCADE
);

-- product version link to the reusable config profile contract.
CREATE TABLE product_version_config_profile_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    profile_id           UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE,
    FOREIGN KEY(profile_id)
        REFERENCES config_profile_t(profile_id) ON DELETE RESTRICT
);

-- customized property for product version within the host.
CREATE TABLE product_version_property_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (126) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id, property_id),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE CASCADE
);

-- each product version will have several pipelines
CREATE TABLE product_version_pipeline_t (
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    pipeline_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (126) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, product_version_id, pipeline_id),
    FOREIGN KEY(host_id, product_version_id)
        REFERENCES product_version_t(host_id, product_version_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, pipeline_id) REFERENCES pipeline_t (host_id, pipeline_id) ON DELETE CASCADE
);

--
CREATE TABLE deployment_t (
    host_id                  UUID NOT NULL,
    deployment_id            UUID NOT NULL,
    deployment_instance_id   UUID NOT NULL,   -- since deployment is per leg, we need to link to deployment instance.
    deployment_status        VARCHAR(16) NOT NULL, --
    deployment_type          VARCHAR(16) NOT NULL,
    schedule_ts              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    platform_job_id          VARCHAR(126),           -- update by the executor once it is started
    aggregate_version        BIGINT DEFAULT 1 NOT NULL,
    active                   BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user              VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, deployment_id),
    FOREIGN KEY(host_id, deployment_instance_id) REFERENCES deployment_instance_t(host_id, deployment_instance_id) ON DELETE CASCADE
);



-- runtime instance created by the control pane or from the UI for legacy APIs.
-- deployment_instance_id is removed; runtime instances are identified by service_id and
-- optional env_tag, which can be used by higher-level logic or auxiliary tables to
-- associate them with deployments where needed.
CREATE TABLE runtime_instance_t (
    host_id                  UUID NOT NULL,
    runtime_instance_id      UUID NOT NULL,  -- auto generated uuid as part of pk
    service_id               VARCHAR(512) NOT NULL, -- serviceId from the server.yml
    env_tag                  VARCHAR(16) NOT NULL DEFAULT '',  -- if there is no envTag, then '' is used
    protocol                 VARCHAR(16) NOT NULL DEFAULT 'https',  -- the transport protocol: http, https, ws, wss
    ip_address               VARCHAR(253) NOT NULL, -- detected host/IP from the server instance and registered on the control pane.
    port_number              INT NOT NULL,          -- registered on control pane.
    instance_status          VARCHAR(16) NOT NULL,  -- Deployed, Running, Shutdown, Starting
    owner_user_id            UUID,
    owner_position_id        VARCHAR(128),
    aggregate_version        BIGINT DEFAULT 1 NOT NULL,
    active                   BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user              VARCHAR (255),
    delete_ts                TIMESTAMP WITH TIME ZONE,
    update_user              VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, runtime_instance_id),
    CONSTRAINT protocol_check CHECK (protocol IN ('http', 'https', 'ws', 'wss'))
);

-- This is the way to identify if a service is restarting or reconnecting to the controller.
ALTER TABLE runtime_instance_t ADD CONSTRAINT runtime_instance_uk UNIQUE ( host_id, service_id, env_tag, protocol, ip_address, port_number);



CREATE TABLE org_t (
    domain               VARCHAR(64) NOT NULL,  -- networknt.com lightapi.net
    org_name             VARCHAR(128) NOT NULL,
    org_desc             VARCHAR(4096) NOT NULL,
    org_owner            UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(domain)
);


CREATE TABLE host_t (
    host_id              UUID NOT NULL, -- a generated unique identifier.
    domain               VARCHAR(64) NOT NULL,
    sub_domain           VARCHAR(64) NOT NULL, -- dev, sit, stg, prd, pre-sit, sit-green, sit-ca, sit-us etc.
    host_desc            VARCHAR(4096),
    host_owner           UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id),
    FOREIGN KEY(domain) REFERENCES org_t(domain) ON DELETE CASCADE
);


ALTER TABLE host_t ADD CONSTRAINT domain_uk UNIQUE ( domain, sub_domain );


-- Command-side coordination for an instance and its cloneable child graph.
-- This table intentionally does not reference instance_t: a command can reserve
-- a target revision before InstanceCreatedEvent projects, and an instance delete
-- retains the revision tombstone for replay and idempotency.
CREATE TABLE instance_graph_revision_t (
    host_id              UUID NOT NULL,
    instance_id          UUID NOT NULL,
    accepted_revision    BIGINT NOT NULL DEFAULT 0,
    projected_revision   BIGINT NOT NULL DEFAULT 0,
    accepted_ts          TIMESTAMP WITH TIME ZONE,
    projected_ts         TIMESTAMP WITH TIME ZONE,
    CONSTRAINT instance_graph_revision_pk PRIMARY KEY(host_id, instance_id),
    CONSTRAINT instance_graph_revision_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE CASCADE,
    CONSTRAINT instance_graph_revision_nonnegative_ck CHECK(
        accepted_revision >= 0 AND projected_revision >= 0
    ),
    CONSTRAINT instance_graph_revision_projection_ck CHECK(
        projected_revision <= accepted_revision
    )
);

CREATE INDEX instance_graph_revision_lag_idx
    ON instance_graph_revision_t(host_id, instance_id)
    WHERE accepted_revision <> projected_revision;


-- Durable idempotency and asynchronous projection outcome for instance clone.
-- Source/target instance and requested-by foreign keys are intentionally
-- omitted so audit rows survive instance/user/catalog lifecycle changes.
CREATE TABLE instance_clone_request_t (
    host_id                   UUID NOT NULL,
    clone_request_id          UUID NOT NULL,
    request_hash              VARCHAR(128) NOT NULL,
    source_instance_id        UUID NOT NULL,
    source_graph_digest       VARCHAR(128) NOT NULL,
    catalog_schema_digest     VARCHAR(128) NOT NULL,
    target_instance_id        UUID NOT NULL,
    target_instance_name      VARCHAR(126) NOT NULL,
    target_service_id         VARCHAR(512) NOT NULL,
    target_env_tag            VARCHAR(16),
    target_product_version_id UUID NOT NULL,
    transaction_id            UUID NOT NULL,
    terminal_event_id         UUID NOT NULL,
    snapshot_id               UUID,
    clone_status              VARCHAR(32) NOT NULL DEFAULT 'ACCEPTED',
    event_count               INTEGER NOT NULL,
    payload_bytes             BIGINT NOT NULL,
    result_summary            JSONB NOT NULL DEFAULT '{}'::jsonb,
    error_code                VARCHAR(64),
    error_message             VARCHAR(2048),
    requested_by              UUID NOT NULL,
    created_ts                TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts                TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT instance_clone_request_pk PRIMARY KEY(host_id, clone_request_id),
    CONSTRAINT instance_clone_request_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE CASCADE,
    CONSTRAINT instance_clone_request_status_ck CHECK(
        clone_status IN ('ACCEPTED', 'PROJECTED', 'SNAPSHOT_READY', 'FAILED_DLQ')
    ),
    CONSTRAINT instance_clone_request_event_count_ck CHECK(event_count >= 0),
    CONSTRAINT instance_clone_request_payload_bytes_ck CHECK(payload_bytes >= 0),
    CONSTRAINT instance_clone_request_result_summary_ck CHECK(
        jsonb_typeof(result_summary) = 'object'
    ),
    CONSTRAINT instance_clone_request_snapshot_ck CHECK(
        clone_status <> 'SNAPSHOT_READY' OR snapshot_id IS NOT NULL
    )
);

CREATE INDEX instance_clone_request_target_id_idx
    ON instance_clone_request_t(host_id, target_instance_id);

CREATE INDEX instance_clone_request_target_identity_idx
    ON instance_clone_request_t(
        host_id, target_service_id, target_env_tag, target_product_version_id
    );

CREATE UNIQUE INDEX instance_clone_request_transaction_uk
    ON instance_clone_request_t(host_id, transaction_id);

CREATE INDEX instance_clone_request_status_idx
    ON instance_clone_request_t(host_id, clone_status, updated_ts);


-- Table for defining reference types (e.g., 'Countries', 'OrderStatus')
CREATE TABLE ref_table_t (
    table_id             UUID NOT NULL, -- UUID genereated by Util
    host_id              UUID,          -- NULL for global/shared tables
    table_name           VARCHAR(80) NOT NULL, -- Name of the ref table for lookup.
    table_desc           TEXT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE, -- Only active table returns values
    editable             BOOLEAN NOT NULL DEFAULT TRUE, -- Table value and locale can be updated via ref admin
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(table_id)
);

-- Partial unique indexes for table_name scope
CREATE UNIQUE INDEX idx_ref_table_unique_global ON ref_table_t (table_name) WHERE host_id IS NULL;
CREATE UNIQUE INDEX idx_ref_table_unique_tenant ON ref_table_t (host_id, table_name) WHERE host_id IS NOT NULL;
CREATE INDEX idx_ref_table_host_id ON ref_table_t(host_id); -- Index for host lookup

-- Table for individual values within a reference table
CREATE TABLE ref_value_t (
    value_id             UUID NOT NULL,
    table_id             UUID NOT NULL,
    value_code           VARCHAR(80) NOT NULL, -- The dropdown value
    value_desc           TEXT NULL,            -- Optional detailed description
    start_ts             TIMESTAMP WITH TIME ZONE NULL,
    end_ts               TIMESTAMP WITH TIME ZONE NULL,
    display_order        INT DEFAULT 0,        -- for editor and dropdown list.
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(value_id),
    FOREIGN KEY (table_id) REFERENCES ref_table_t (table_id) ON DELETE CASCADE,
    CONSTRAINT unique_ref_value_code_in_table UNIQUE (table_id, value_code) -- Enforce unique codes within a table
);

CREATE INDEX idx_ref_value_table_id ON ref_value_t(table_id); -- Index for finding values by table


CREATE TABLE value_locale_t (
    value_id             UUID NOT NULL,
    language             VARCHAR(2) NOT NULL,
    value_label          VARCHAR(255) NOT NULL, -- The drop label in language.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(value_id,language),
    FOREIGN KEY (value_id) REFERENCES ref_value_t (value_id) ON DELETE CASCADE
);

CREATE INDEX idx_value_locale_lang ON value_locale_t(language);


CREATE TABLE relation_type_t (
    relation_id          UUID NOT NULL,
    host_id              UUID,          -- NULL for global/shared relation types
    relation_name        VARCHAR(32) NOT NULL, -- The lookup keyword for the relation.
    relation_desc        TEXT NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(relation_id)
);

CREATE UNIQUE INDEX idx_relation_type_unique_global ON relation_type_t (relation_name) WHERE host_id IS NULL;
CREATE UNIQUE INDEX idx_relation_type_unique_tenant ON relation_type_t (host_id, relation_name) WHERE host_id IS NOT NULL;
CREATE INDEX idx_relation_type_host_id ON relation_type_t(host_id);



CREATE TABLE relation_t (
    relation_id          UUID NOT NULL,
    value_id_from        UUID NOT NULL,
    value_id_to          UUID NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (relation_id, value_id_from, value_id_to),
    FOREIGN KEY (relation_id) REFERENCES relation_type_t (relation_id) ON DELETE CASCADE,
    FOREIGN KEY (value_id_from) REFERENCES ref_value_t (value_id) ON DELETE CASCADE,
    FOREIGN KEY (value_id_to) REFERENCES ref_value_t (value_id) ON DELETE CASCADE
);

CREATE INDEX idx_relation_from ON relation_t(value_id_from);
CREATE INDEX idx_relation_to ON relation_t(value_id_to);


CREATE TABLE user_t (
    user_id              UUID NOT NULL,
    email                VARCHAR(255) NOT NULL,
    password             VARCHAR(1024) NULL,
    language             CHAR(2) NOT NULL,
    first_name           VARCHAR(32) NULL,
    last_name            VARCHAR(32) NULL,
    user_type            CHAR(1) NULL, -- E employee C customer or E employee P personal B business
    phone_number         VARCHAR(20) NULL,
    gender               CHAR(1) NULL,
    birthday             DATE NULL,
    country              VARCHAR(3) NULL,
    province             VARCHAR(32) NULL,
    city                 VARCHAR(32) NULL,
    address              VARCHAR(128) NULL,
    post_code            VARCHAR(16) NULL,
    verified             BOOLEAN NOT NULL DEFAULT false,
    token                VARCHAR(64) NULL,
    locked               BOOLEAN NOT NULL DEFAULT false,
    nonce                BIGINT NOT NULL DEFAULT 0,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE user_t ADD CONSTRAINT user_pk PRIMARY KEY ( user_id );

ALTER TABLE user_t ADD CONSTRAINT user_email_uk UNIQUE ( email );

CREATE TABLE user_host_t (
    host_id              UUID NOT NULL,
    user_id              UUID NOT NULL,
    current              BOOLEAN DEFAULT false,
    -- other relationship-specific attributes (e.g., roles within the host)
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, user_id),
    FOREIGN KEY (user_id) REFERENCES user_t (user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host_t (host_id) ON DELETE CASCADE
);

CREATE TABLE user_crypto_wallet_t (
    user_id              UUID NOT NULL,
    crypto_type          VARCHAR(32) NOT NULL,
    crypto_address       VARCHAR(128) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, crypto_type, crypto_address),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE
);

CREATE TABLE customer_t (
    host_id              UUID NOT NULL,
    customer_id          VARCHAR(50) NOT NULL,
    user_id              UUID NOT NULL,
    -- Other customer-specific attributes
    referral_id          VARCHAR(50), -- the customer_id who refers this customer.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, customer_id),
    -- make sure that the user_host_t host_id update is cascaded
    FOREIGN KEY (host_id, user_id) REFERENCES user_host_t(host_id, user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (host_id, referral_id) REFERENCES customer_t(host_id, customer_id) ON DELETE CASCADE
);

CREATE TABLE employee_t (
    host_id              UUID NOT NULL,
    employee_id          VARCHAR(50) NOT NULL,  -- Employee ID or number or ACF2 ID. Unique within the host.
    user_id              UUID NOT NULL,
    title                VARCHAR(126),
    manager_id           VARCHAR(50), -- manager's employee_id if there is one.
    hire_date            DATE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, employee_id),
    -- make sure that the user_host_t host_id update is cascaded
    FOREIGN KEY (host_id, user_id) REFERENCES user_host_t(host_id, user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (host_id, manager_id) REFERENCES employee_t(host_id, employee_id) ON DELETE CASCADE
);

CREATE TABLE position_t (
    host_id              UUID NOT NULL,
    position_id          VARCHAR(128) NOT NULL,
    position_desc        VARCHAR(2048),
    inherit_to_ancestor  CHAR(1) DEFAULT 'N',
    inherit_to_sibling   CHAR(1) DEFAULT 'N',
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, position_id)
);

CREATE TABLE user_position_t (
    host_id              UUID NOT NULL,
    user_id              UUID NOT NULL,
    position_id          VARCHAR(128) NOT NULL,
    position_type        CHAR(1) NOT NULL, -- P position of own, D inherited from a decendant, S inherited from a sibling.
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, user_id, position_id),
    FOREIGN KEY (host_id, position_id) REFERENCES position_t(host_id, position_id) ON DELETE CASCADE
);

CREATE TABLE position_permission_t (
    host_id              UUID NOT NULL,
    position_id          VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, position_id, endpoint_id),
    FOREIGN KEY (host_id, position_id) REFERENCES position_t(host_id, position_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE position_row_filter_t (
    host_id                  UUID NOT NULL,
    position_id              VARCHAR(128) NOT NULL,
    endpoint_id              UUID NOT NULL,
    col_name                 VARCHAR(128) NOT NULL,
    operator                 VARCHAR(32) NOT NULL,
    col_value                VARCHAR(1024) NOT NULL,
    aggregate_version        BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user              VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts                TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, position_id, endpoint_id, col_name),
    FOREIGN KEY (host_id, position_id) REFERENCES position_t(host_id, position_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE position_col_filter_t (
    host_id              UUID NOT NULL,
    position_id          VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    columns              VARCHAR(1024) NOT NULL, -- list of columns to keep for the position in json string array format.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, position_id, endpoint_id),
    FOREIGN KEY (host_id, position_id) REFERENCES position_t(host_id, position_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE role_t (
    host_id              UUID NOT NULL,
    role_id              VARCHAR(128) NOT NULL,
    role_desc            VARCHAR(1024),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, role_id),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE TABLE role_permission_t (
    host_id              UUID NOT NULL,
    role_id              VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, role_id, endpoint_id),
    FOREIGN KEY (host_id, role_id) REFERENCES role_t(host_id, role_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE role_row_filter_t (
    host_id              UUID NOT NULL,
    role_id              VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    col_name             VARCHAR(128) NOT NULL,
    operator             VARCHAR(32) NOT NULL,
    col_value            VARCHAR(1024) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, role_id, endpoint_id, col_name),
    FOREIGN KEY (host_id, role_id) REFERENCES role_t(host_id, role_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE role_col_filter_t (
    host_id              UUID NOT NULL,
    role_id              VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    columns              VARCHAR(1024) NOT NULL, -- list of columns to keep for the role in json string array format.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, role_id, endpoint_id),
    FOREIGN KEY (host_id, role_id) REFERENCES role_t(host_id, role_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);


CREATE TABLE role_user_t (
    host_id              UUID NOT NULL,
    role_id              VARCHAR(128) NOT NULL,
    user_id              UUID NOT NULL,
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, role_id, user_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, role_id) REFERENCES role_t(host_id, role_id) ON DELETE CASCADE
);

CREATE TABLE user_permission_t (
    host_id              UUID NOT NULL,
    user_id              UUID NOT NULL,
    endpoint_id          UUID NOT NULL,
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, host_id, endpoint_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);


CREATE TABLE user_row_filter_t (
    host_id              UUID NOT NULL,
    user_id              UUID NOT NULL,
    endpoint_id          UUID NOT NULL,
    col_name             VARCHAR(128) NOT NULL,
    operator             VARCHAR(32) NOT NULL,
    col_value            VARCHAR(1024) NOT NULL,
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, host_id, endpoint_id, col_name),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE user_col_filter_t (
    host_id              UUID NOT NULL,
    user_id              UUID NOT NULL,
    endpoint_id          UUID NOT NULL,
    columns              VARCHAR(1024) NOT NULL, -- list of columns to keep for the user in json string array format.
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, host_id, endpoint_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);


CREATE TABLE group_t (
    host_id              UUID NOT NULL,
    group_id             VARCHAR(128) NOT NULL,
    group_desc           VARCHAR(2048),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, group_id)
);

CREATE TABLE group_permission_t (
    host_id              UUID NOT NULL,
    group_id             VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, group_id, endpoint_id),
    FOREIGN KEY (host_id, group_id) REFERENCES group_t(host_id, group_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE group_row_filter_t (
    host_id              UUID NOT NULL,
    group_id             VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    col_name             VARCHAR(128) NOT NULL,
    operator             VARCHAR(32) NOT NULL,
    col_value            VARCHAR(1024) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, group_id, endpoint_id, col_name),
    FOREIGN KEY (host_id, group_id) REFERENCES group_t(host_id, group_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

CREATE TABLE group_col_filter_t (
    host_id              UUID NOT NULL,
    group_id             VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    columns              VARCHAR(1024) NOT NULL, -- list of columns to keep for the group in json string array format.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, group_id, endpoint_id),
    FOREIGN KEY (host_id, group_id) REFERENCES group_t(host_id, group_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);


CREATE TABLE group_user_t (
    host_id              UUID NOT NULL,
    group_id             VARCHAR(128) NOT NULL,
    user_id              UUID NOT NULL,
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, group_id, user_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, group_id) REFERENCES group_t(host_id, group_id) ON DELETE CASCADE
);

-- attribute
CREATE TABLE attribute_t (
    host_id              UUID NOT NULL,
    attribute_id         VARCHAR(128) NOT NULL,
    attribute_type       VARCHAR(50) CHECK (attribute_type IN ('string', 'integer', 'boolean', 'date', 'float', 'list')), -- Define allowed data types
    attribute_desc       VARCHAR(2048),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, attribute_id)
);

CREATE TABLE attribute_user_t (
    host_id              UUID NOT NULL,
    attribute_id         VARCHAR(128) NOT NULL,
    user_id              UUID NOT NULL, -- References users_t
    attribute_value      VARCHAR(1024) NOT NULL, -- Store values as strings; you can cast later
    start_ts             TIMESTAMP WITH TIME ZONE,
    end_ts               TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, attribute_id, user_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, attribute_id) REFERENCES attribute_t(host_id, attribute_id) ON DELETE CASCADE
);


CREATE TABLE attribute_permission_t (
    host_id              UUID NOT NULL,
    attribute_id         VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    attribute_value      VARCHAR(1024) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, attribute_id, endpoint_id),
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, attribute_id) REFERENCES attribute_t(host_id, attribute_id) ON DELETE CASCADE
);

CREATE TABLE attribute_row_filter_t (
    host_id              UUID NOT NULL,
    attribute_id         VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    attribute_value      VARCHAR(1024) NOT NULL,
    col_name             VARCHAR(128) NOT NULL,
    operator             VARCHAR(32) NOT NULL,
    col_value            VARCHAR(1024) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, attribute_id, endpoint_id, col_name),
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, attribute_id) REFERENCES attribute_t(host_id, attribute_id) ON DELETE CASCADE
);

CREATE TABLE attribute_col_filter_t (
    host_id              UUID NOT NULL,
    attribute_id         VARCHAR(128) NOT NULL,
    endpoint_id          UUID NOT NULL,
    attribute_value      VARCHAR(1024) NOT NULL,
    columns              VARCHAR(1024) NOT NULL, -- list of columns to keep for the attribute in json string array format.
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, attribute_id, endpoint_id),
    FOREIGN KEY (host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, attribute_id) REFERENCES attribute_t(host_id, attribute_id) ON DELETE CASCADE
);


CREATE TABLE auth_provider_t (
    provider_id          VARCHAR(22) NOT NULL,
    host_id              UUID NOT NULL,  -- host that the provider belong to.
    provider_name        VARCHAR(126) NOT NULL,
    provider_desc        VARCHAR(4096),
    operation_owner      UUID,
    delivery_owner       UUID,
    jwk                  VARCHAR(65535) NOT NULL, -- json web key that contains current and previous public keys
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, provider_id),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

ALTER TABLE auth_provider_t
    ADD CONSTRAINT auth_provider_uk UNIQUE (host_id, provider_name);

    
CREATE TABLE auth_provider_key_t (
    host_id              UUID NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    kid                  VARCHAR(22) NOT NULL,
    public_key           VARCHAR(65535) NOT NULL,
    private_key          VARCHAR(65535) NOT NULL,
    key_type             CHAR(2) NOT NULL, -- LC long live current LP long live previous TC token current, TP token previous
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, provider_id, kid),
    FOREIGN KEY(host_id, provider_id) REFERENCES auth_provider_t (host_id, provider_id) ON DELETE CASCADE
);

-- multiple apis can share the same auth provider.
CREATE TABLE auth_provider_api_t(
    host_id              UUID NOT NULL,
    api_id               VARCHAR(16) NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, api_id, provider_id),
    FOREIGN KEY(host_id, provider_id) REFERENCES auth_provider_t (host_id, provider_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, api_id) REFERENCES api_t(host_id, api_id) ON DELETE CASCADE
);


-- OAuth client owner/principal. Most clients belong to an app, API version, or
-- deployed product instance. Free-form service accounts are for admin-only
-- exceptions and system integrations.
CREATE TABLE auth_client_owner_t (
    host_id              UUID NOT NULL,
    owner_id             UUID NOT NULL,
    owner_type           VARCHAR(32) NOT NULL, -- app, api_version, instance, service_account
    app_id               VARCHAR(512),
    api_version_id       UUID,
    instance_id          UUID,
    owner_name           VARCHAR(126) NOT NULL,
    description          VARCHAR(1024),
    contact_email        VARCHAR(255),
    review_ts            TIMESTAMP WITH TIME ZONE,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, owner_id),
    FOREIGN KEY(host_id, app_id) REFERENCES app_t(host_id, app_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, api_version_id) REFERENCES api_version_t(host_id, api_version_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    CHECK (
        (owner_type = 'app' AND app_id IS NOT NULL AND api_version_id IS NULL AND instance_id IS NULL)
        OR (owner_type = 'api_version' AND app_id IS NULL AND api_version_id IS NOT NULL AND instance_id IS NULL)
        OR (owner_type = 'instance' AND app_id IS NULL AND api_version_id IS NULL AND instance_id IS NOT NULL)
        OR (owner_type = 'service_account' AND app_id IS NULL AND api_version_id IS NULL AND instance_id IS NULL AND contact_email IS NOT NULL)
    )
);

CREATE UNIQUE INDEX idx_auth_client_owner_app
    ON auth_client_owner_t(host_id, app_id)
    WHERE app_id IS NOT NULL;

CREATE UNIQUE INDEX idx_auth_client_owner_api_version
    ON auth_client_owner_t(host_id, api_version_id)
    WHERE api_version_id IS NOT NULL;

CREATE UNIQUE INDEX idx_auth_client_owner_instance
    ON auth_client_owner_t(host_id, instance_id)
    WHERE instance_id IS NOT NULL;

-- a client can associate with an owner/principal.
CREATE TABLE auth_client_t (
    host_id              UUID NOT NULL,
    client_id            UUID NOT NULL,
    client_name          VARCHAR(126) NOT NULL,
    owner_id             UUID NOT NULL,
    app_id               VARCHAR(512), -- this client is owned by an app
    api_version_id       UUID,         -- this client is owned by an api
    client_type          VARCHAR(12) NOT NULL, -- public, confidential, trusted, external
    client_profile       VARCHAR(10) NOT NULL, -- webserver, mobile, browser, service, batch
    client_secret        VARCHAR(1024) NOT NULL,
    client_scope         VARCHAR(4000),
    custom_claim         VARCHAR(4000), -- custom claim in json format that will be included in the jwt token
    redirect_uri         VARCHAR(1024),
    authenticate_class   VARCHAR(256),
    token_ex_type        VARCHAR(64),   -- does this client support token exchange request? If yes, what is the exchagne type.
    deref_client_id      UUID, -- only this client calls AS to deref token to JWT for external client type
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, client_id),
    FOREIGN KEY(host_id, owner_id) REFERENCES auth_client_owner_t(host_id, owner_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, app_id) REFERENCES app_t(host_id, app_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, api_version_id) REFERENCES api_version_t(host_id, api_version_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    CHECK (app_id IS NULL OR api_version_id IS NULL)
);

-- Supporting indexes for cascading foreign keys from auth_client_t
CREATE INDEX idx_auth_client_t_host_owner
    ON auth_client_t (host_id, owner_id);

CREATE INDEX idx_auth_client_t_host_app
    ON auth_client_t (host_id, app_id);

CREATE INDEX idx_auth_client_t_host_api_version
    ON auth_client_t (host_id, api_version_id);

-- long-lived portal token for client to access the light-portal for config server and controller.
-- the real token is not persisted and it can only be captured by the client when it is generated.
CREATE TABLE auth_client_token_t (
    host_id              UUID NOT NULL,
    client_id            UUID NOT NULL,
    token_id             VARCHAR(22) NOT NULL, -- the jti of the portal token
    expiration_ts        TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_used_ts         TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    owner_user_id        UUID,
    owner_position_id    VARCHAR(128),
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, client_id, token_id),   -- All three should be part the portal token
    FOREIGN KEY(host_id, client_id) REFERENCES auth_client_t(host_id, client_id) ON DELETE CASCADE
);


CREATE TABLE auth_provider_client_t (
    host_id              UUID NOT NULL,
    client_id            UUID NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, client_id, provider_id),
    FOREIGN KEY(host_id, provider_id) REFERENCES auth_provider_t (host_id, provider_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, client_id) REFERENCES auth_client_t(host_id, client_id) ON DELETE CASCADE
);

CREATE TABLE auth_code_t (
    auth_code            VARCHAR(22) NOT NULL,
    host_id              UUID NOT NULL,
    auth_host_id         UUID NOT NULL,
    client_id            UUID NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    user_id              UUID NOT NULL,
    entity_id            VARCHAR(50) NOT NULL,
    user_type            CHAR(1) NOT NULL,
    email                VARCHAR(126) NOT NULL,
    roles                VARCHAR(4096),
    groups               VARCHAR(4096),
    positions            VARCHAR(4096),
    attributes           VARCHAR(4096),
    redirect_uri         VARCHAR(2048),
    scope                VARCHAR(1024),
    remember             CHAR(1),
    code_challenge       VARCHAR(126),
    challenge_method     VARCHAR(64),
    session_id           UUID,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, auth_code),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (auth_host_id, client_id, provider_id) REFERENCES auth_provider_client_t(host_id, client_id, provider_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE TABLE auth_refresh_token_t (
    refresh_token        UUID NOT NULL,
    host_id              UUID NOT NULL,
    auth_host_id         UUID NOT NULL,
    client_id            UUID NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    user_id              UUID NOT NULL,
    entity_id            VARCHAR(50) NOT NULL,
    user_type            CHAR(1) NOT NULL,
    email                VARCHAR(126) NOT NULL,
    roles                VARCHAR(4096),
    groups               VARCHAR(4096),
    positions            VARCHAR(4096),
    attributes           VARCHAR(4096),
    scope                VARCHAR(1024),
    csrf                 VARCHAR(36),
    custom_claim         VARCHAR(2000),
    session_id           UUID,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, refresh_token),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (auth_host_id, client_id, provider_id) REFERENCES auth_provider_client_t(host_id, client_id, provider_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE INDEX idx_auth_code_t_host_client_provider ON auth_code_t(host_id, client_id, provider_id);
CREATE INDEX idx_auth_code_t_auth_host_client_provider ON auth_code_t(auth_host_id, client_id, provider_id);
CREATE UNIQUE INDEX idx_auth_code_t_auth_code ON auth_code_t(auth_code);
CREATE INDEX idx_auth_refresh_token_t_host_client_provider ON auth_refresh_token_t(host_id, client_id, provider_id);
CREATE INDEX idx_auth_refresh_token_t_auth_host_client_provider ON auth_refresh_token_t(auth_host_id, client_id, provider_id);
CREATE UNIQUE INDEX idx_auth_refresh_token_t_refresh_token ON auth_refresh_token_t(refresh_token);

CREATE TABLE auth_session_t (
    host_id              UUID NOT NULL,
    auth_host_id         UUID NOT NULL,
    session_id           UUID NOT NULL,
    user_id              UUID NOT NULL,
    client_id            UUID NOT NULL,
    provider_id          VARCHAR(22) NOT NULL,
    user_type            CHAR(1),
    entity_id            VARCHAR(50),
    email                VARCHAR(126),
    roles                VARCHAR(4096),
    scope                VARCHAR(1024),
    login_ts             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_refresh_ts      TIMESTAMP WITH TIME ZONE,
    logout_ts            TIMESTAMP WITH TIME ZONE,
    expires_ts           TIMESTAMP WITH TIME ZONE,
    status               VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    end_reason           VARCHAR(40),
    ip_address           INET,
    user_agent           TEXT,
    device_id            VARCHAR(128),
    refresh_count        BIGINT NOT NULL DEFAULT 0,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, session_id),
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE,
    FOREIGN KEY (auth_host_id, client_id, provider_id) REFERENCES auth_provider_client_t(host_id, client_id, provider_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE INDEX idx_auth_session_t_user_status ON auth_session_t(host_id, user_id, status, login_ts DESC);
CREATE INDEX idx_auth_session_t_client_status ON auth_session_t(host_id, client_id, status, login_ts DESC);
CREATE INDEX idx_auth_session_t_status_refresh ON auth_session_t(host_id, status, last_refresh_ts DESC);
CREATE INDEX idx_auth_session_t_auth_host_client_provider ON auth_session_t(auth_host_id, client_id, provider_id);

ALTER TABLE auth_refresh_token_t
    ADD CONSTRAINT auth_refresh_token_session_fk
    FOREIGN KEY (host_id, session_id)
    REFERENCES auth_session_t(host_id, session_id) ON DELETE CASCADE;

ALTER TABLE auth_code_t
    ADD CONSTRAINT auth_code_session_fk
    FOREIGN KEY (host_id, session_id)
    REFERENCES auth_session_t(host_id, session_id) ON DELETE CASCADE;

CREATE TABLE auth_session_audit_t (
    audit_id             UUID NOT NULL,
    host_id              UUID NOT NULL,
    auth_host_id         UUID NOT NULL,
    session_id           UUID,
    user_id              UUID,
    client_id            UUID,
    provider_id          VARCHAR(22),
    event_type           VARCHAR(40) NOT NULL,
    event_ts             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_address           INET,
    user_agent           TEXT,
    old_refresh_token_id UUID,
    new_refresh_token_id UUID,
    result               VARCHAR(20) NOT NULL,
    failure_reason       TEXT,
    metadata             JSONB,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, audit_id),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY (auth_host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE INDEX idx_auth_session_audit_t_session ON auth_session_audit_t(host_id, session_id, event_ts DESC);
CREATE INDEX idx_auth_session_audit_t_user ON auth_session_audit_t(host_id, user_id, event_ts DESC);
CREATE INDEX idx_auth_session_audit_t_event ON auth_session_audit_t(host_id, event_type, event_ts DESC);
CREATE INDEX idx_auth_session_audit_t_refresh_rotation ON auth_session_audit_t(host_id, old_refresh_token_id, client_id, provider_id, event_type, event_ts DESC);
CREATE INDEX idx_auth_session_audit_t_auth_refresh_rotation ON auth_session_audit_t(auth_host_id, old_refresh_token_id, client_id, provider_id, event_type, event_ts DESC);


CREATE TABLE auth_ref_token_t (
    host_id              UUID NOT NULL,
    ref_token            VARCHAR(22) NOT NULL,
    jwt_token            VARCHAR(40960) NOT NULL,
    client_id            UUID NOT NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (host_id, ref_token),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, client_id) REFERENCES auth_client_t(host_id, client_id) ON DELETE CASCADE
);

CREATE TABLE notification_t (
    id                  UUID NOT NULL,
    host_id             UUID NOT NULL,
    user_id             UUID NOT NULL,
    nonce               BIGINT NOT NULL,
    event_class         VARCHAR(255) NOT NULL,
    event_json          TEXT NOT NULL,
    event_ts            TIMESTAMP WITH TIME ZONE NULL,
    process_ts          TIMESTAMP WITH TIME ZONE NOT NULL,
    status              VARCHAR(16) NOT NULL,
    error               VARCHAR(2048) NULL,
    aggregate_id        VARCHAR(255) NULL,
    aggregate_type      VARCHAR(255) NULL,
    aggregate_version   BIGINT NULL,
    event_partition     INTEGER NULL,
    event_offset        BIGINT NULL,
    transaction_id      UUID NULL,
    read_ts             TIMESTAMP WITH TIME ZONE NULL,
    PRIMARY KEY (host_id, id),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE INDEX idx_notification_user_process_ts ON notification_t (host_id, user_id, process_ts DESC);
CREATE INDEX idx_notification_status_process_ts ON notification_t (host_id, status, process_ts DESC);
CREATE INDEX idx_notification_transaction ON notification_t (host_id, transaction_id);
CREATE INDEX idx_notification_event_position ON notification_t (host_id, event_partition, event_offset);
CREATE INDEX idx_notification_unread_failure ON notification_t (host_id, user_id, process_ts DESC)
    WHERE read_ts IS NULL AND status IN ('FAILED', 'DLQ');


CREATE TABLE private_conversation_t (
    host_id              UUID NOT NULL,
    conversation_id      UUID NOT NULL,
    participant_low_id   UUID NOT NULL,
    participant_high_id  UUID NOT NULL,
    created_ts           TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_message_id      UUID NULL,
    last_message_ts      TIMESTAMP WITH TIME ZONE NULL,
    PRIMARY KEY (host_id, conversation_id),
    UNIQUE (host_id, participant_low_id, participant_high_id),
    FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE TABLE private_message_t (
    host_id          UUID NOT NULL,
    message_id       UUID NOT NULL,
    conversation_id  UUID NOT NULL,
    from_user_id     UUID NOT NULL,
    to_user_id       UUID NOT NULL,
    subject          VARCHAR(256) NULL,
    content          TEXT NOT NULL,
    send_ts          TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY (host_id, message_id),
    FOREIGN KEY (host_id, conversation_id)
        REFERENCES private_conversation_t(host_id, conversation_id)
        ON DELETE CASCADE
);

CREATE TABLE private_message_state_t (
    host_id      UUID NOT NULL,
    message_id   UUID NOT NULL,
    user_id      UUID NOT NULL,
    read_ts      TIMESTAMP WITH TIME ZONE NULL,
    deleted_ts   TIMESTAMP WITH TIME ZONE NULL,
    PRIMARY KEY (host_id, message_id, user_id),
    FOREIGN KEY (host_id, message_id)
        REFERENCES private_message_t(host_id, message_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_private_conversation_last_message
    ON private_conversation_t (host_id, participant_low_id, participant_high_id, last_message_ts DESC);

CREATE INDEX idx_private_message_conversation_ts
    ON private_message_t (host_id, conversation_id, send_ts DESC);

CREATE INDEX idx_private_message_to_user_ts
    ON private_message_t (host_id, to_user_id, send_ts DESC);

CREATE INDEX idx_private_message_state_unread
    ON private_message_state_t (host_id, user_id)
    WHERE read_ts IS NULL AND deleted_ts IS NULL;


CREATE TABLE message_t (
    host_id    UUID NOT NULL,
    from_id    VARCHAR(64) NOT NULL,
    nonce      BIGINT NOT NULL,
    to_email   VARCHAR(64) NOT NULL,
    subject    VARCHAR(256) NOT NULL,
    content    VARCHAR(65536) NOT NULL,
    send_time  TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE message_t ADD CONSTRAINT message_pk PRIMARY KEY (host_id, from_id, nonce );
ALTER TABLE message_t ADD CONSTRAINT message_host_fk FOREIGN KEY (host_id) REFERENCES host_t(host_id) ON DELETE CASCADE;

CREATE INDEX message_idx ON message_t (to_email, send_time);


CREATE TABLE config_snapshot_t (
    snapshot_id                 UUID NOT NULL, -- Primary Key, maybe UUIDv7 for time ordering
    snapshot_ts                 TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    snapshot_type               VARCHAR(32) NOT NULL, -- e.g., 'DEPLOYMENT', 'USER_SAVE', 'SCHEDULED_BACKUP'
    host_id                     UUID NOT NULL,        -- The hostId of the instance.
    instance_id                 UUID NOT NULL,        -- The instance id for the configuration.
    description                 TEXT,                 -- User-provided description or system-generated info
    current                     BOOLEAN NOT NULL DEFAULT FALSE,     -- Current config snapshot for the hostId and instanceId
    user_id                     UUID,                 -- User who triggered it (if applicable)
    deployment_id               UUID,                 -- FK to deployment_t if snapshot_type is 'DEPLOYMENT'
    -- Scope columns define WHAT this snapshot represents:
    environment           VARCHAR(16),        -- Environment context (if snapshot is env-specific)
    product_id            VARCHAR(8),         -- Product id context
    product_version       VARCHAR(12),        -- Product version context
    service_id            VARCHAR(512),       -- Service id context
    api_id                VARCHAR(16),        -- Api id context
    api_version           VARCHAR(16),        -- Api version context
    -- tag,
    PRIMARY KEY(snapshot_id),
    FOREIGN KEY(host_id, deployment_id) REFERENCES deployment_t(host_id, deployment_id) ON DELETE SET NULL,
    FOREIGN KEY(user_id) REFERENCES user_t(user_id) ON DELETE SET NULL,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE
);

-- Index for finding snapshots by type or scope
CREATE INDEX idx_config_snapshot_scope ON config_snapshot_t (host_id, environment, product_id,
    product_version, service_id, api_id, api_version, snapshot_type, snapshot_ts);
CREATE INDEX idx_config_snapshot_deployment ON config_snapshot_t (deployment_id);
CREATE UNIQUE INDEX uq_config_snapshot_current_instance
    ON config_snapshot_t (host_id, instance_id)
    WHERE current IS TRUE;


CREATE TABLE config_snapshot_property_t (
    snapshot_property_id        UUID NOT NULL,         -- Surrogate primary key for easier referencing/updates if needed
    snapshot_id                 UUID NOT NULL,         -- FK to config_snapshot_t
    config_phase                CHAR(1) NOT NULL,      -- Move config phase to this table so that one snapshot can cover all phases
    config_id                   UUID NOT NULL,         -- The config id
    property_id                 UUID NOT NULL,         -- The final property id
    property_name               VARCHAR(64) NOT NULL,  -- The final property name
    property_type               VARCHAR(32) NOT NULL,  -- The property type
    property_value              TEXT,                  -- The effective property value at snapshot time
    value_type                  VARCHAR(32),           -- Optional: Store the type (string, int, bool...) for easier parsing later
    source_level                VARCHAR(32),           -- e.g., 'instance', 'product_version', 'environment', 'default'
    PRIMARY KEY(snapshot_property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);

-- Unique constraint to ensure one value per key within a snapshot
ALTER TABLE config_snapshot_property_t
    ADD CONSTRAINT config_snapshot_property_uk UNIQUE (snapshot_id, config_phase, config_id, property_id);

-- Index for quickly retrieving all properties for a snapshot
CREATE INDEX idx_config_snapshot_property_snap_phase ON config_snapshot_property_t (snapshot_id, config_phase);


CREATE TABLE snapshot_instance_file_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    instance_file_id     UUID NOT NULL,
    instance_id          UUID NOT NULL,
    config_phase         CHAR(1) DEFAULT 'R' NOT NULL,
    file_type            VARCHAR(32) DEFAULT 'File',
    file_name            VARCHAR (126) NOT NULL,
    file_value           TEXT NOT NULL,
    file_desc            VARCHAR(1024) NOT NULL,
    expiration_ts        TIMESTAMP WITH TIME ZONE,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, instance_file_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
ALTER TABLE snapshot_instance_file_t
    ADD CONSTRAINT snapshot_instance_file_config_phase_check
        CHECK ( config_phase IN ( 'G', 'D', 'R' ) );
CREATE INDEX idx_snap_inst_file ON snapshot_instance_file_t (snapshot_id);
CREATE INDEX idx_snap_inst_file_phase ON snapshot_instance_file_t (snapshot_id, config_phase, file_type, active);


CREATE TABLE snapshot_deployment_instance_property_t (
    snapshot_id             UUID NOT NULL,
    host_id                 UUID NOT NULL,
    deployment_instance_id  UUID NOT NULL,
    property_id             UUID NOT NULL,
    property_value          TEXT,
    aggregate_version       BIGINT DEFAULT 1 NOT NULL,
    active                  BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user             VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
    update_ts               TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, deployment_instance_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_idep_prop ON snapshot_deployment_instance_property_t (snapshot_id);


-- Snapshot of Instance API Overrides
CREATE TABLE snapshot_instance_api_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, instance_api_id, property_id), -- Composite PK matches original structure + snapshot_id
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_iapi_prop ON snapshot_instance_api_property_t (snapshot_id);


-- Snapshot of Instance App Overrides
CREATE TABLE snapshot_instance_app_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, instance_app_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_iapp_prop ON snapshot_instance_app_property_t (snapshot_id);

-- Snapshot of Instance App API Overrides
CREATE TABLE snapshot_instance_app_api_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    instance_app_id      UUID NOT NULL,
    instance_api_id      UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, instance_app_id, instance_api_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_iaappi_prop ON snapshot_instance_app_api_property_t (snapshot_id);


-- Snapshot of Instance Overrides
CREATE TABLE snapshot_instance_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    instance_id          UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, instance_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_inst_prop ON snapshot_instance_property_t (snapshot_id);


-- Snapshot of Environment Overrides (If needed for rollback)
CREATE TABLE snapshot_environment_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    environment          VARCHAR(16) NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, environment, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_env_prop ON snapshot_environment_property_t (snapshot_id);

CREATE TABLE snapshot_product_property_t (
    snapshot_id          UUID NOT NULL,
    product_id           VARCHAR(8) NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, product_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_prd_prop ON snapshot_product_property_t (snapshot_id);

CREATE TABLE snapshot_product_version_property_t (
    snapshot_id          UUID NOT NULL,
    host_id              UUID NOT NULL,
    product_version_id   UUID NOT NULL,
    property_id          UUID NOT NULL,
    property_value       TEXT,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    delete_user          VARCHAR (255),
    delete_ts            TIMESTAMP WITH TIME ZONE,
    update_user          VARCHAR (255) NOT NULL,
    update_ts            TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(snapshot_id, host_id, product_version_id, property_id),
    FOREIGN KEY(snapshot_id) REFERENCES config_snapshot_t(snapshot_id) ON DELETE CASCADE
);
CREATE INDEX idx_snap_pv_prop ON snapshot_product_version_property_t (snapshot_id);



-- Workflow Definitions: Stores the Agentic Workflow JSON
CREATE TABLE wf_definition_t (
    host_id             UUID NOT NULL,
    wf_def_id           UUID NOT NULL,
    namespace           VARCHAR(126) NOT NULL,
    name                VARCHAR(126) NOT NULL,
    version             VARCHAR(20) NOT NULL,
    definition          TEXT NOT NULL, -- The Agentic Workflow DSL in YAML
    lifecycle_status    VARCHAR(16) DEFAULT 'DRAFT' NOT NULL CHECK(lifecycle_status IN ('DRAFT','PUBLISHED','DEPRECATED')),
    catalog_visible     BOOLEAN,
    owner_user_id       UUID,
    owner_position_id   VARCHAR(128),
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT TRUE,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, wf_def_id),
    UNIQUE(host_id, namespace, name, version)
);

CREATE TABLE wf_definition_version_t (
    host_id UUID NOT NULL,
    wf_def_id UUID NOT NULL,
    namespace VARCHAR(126) NOT NULL,
    name VARCHAR(126) NOT NULL,
    version VARCHAR(20) NOT NULL,
    definition TEXT NOT NULL,
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT' CHECK(lifecycle_status IN ('DRAFT','PUBLISHED','DEPRECATED')),
    published_by VARCHAR(126),
    published_ts TIMESTAMPTZ,
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,wf_def_id,version),
    UNIQUE(host_id,namespace,name,version),
    FOREIGN KEY(host_id,wf_def_id) REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT,
    CHECK((lifecycle_status='PUBLISHED')=(published_ts IS NOT NULL)),
    CHECK((lifecycle_status='PUBLISHED')=(published_by IS NOT NULL))
);
CREATE INDEX wf_definition_version_status_idx
    ON wf_definition_version_t(host_id,wf_def_id,lifecycle_status,version);

CREATE TABLE worklist_t (
  host_id              UUID NOT NULL,
  assignee_id          VARCHAR(126) NOT NULL,
  category_id          VARCHAR(126) DEFAULT '(all)' NOT NULL,
  status_code          VARCHAR(10) DEFAULT 'Active' NOT NULL,
  app_id               VARCHAR(512) DEFAULT 'global' NOT NULL,
  aggregate_version    BIGINT DEFAULT 1 NOT NULL,
  active               BOOLEAN NOT NULL DEFAULT TRUE,
  update_user          VARCHAR (255) DEFAULT SESSION_USER NOT NULL,
  update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(host_id, assignee_id, category_id)
);

CREATE TABLE worklist_column_t (
  host_id               UUID NOT NULL,
  assignee_id           VARCHAR(126) NOT NULL,
  category_id           VARCHAR(126) DEFAULT '(all)' NOT NULL,
  sequence_id           INTEGER NOT NULL,
  column_id             VARCHAR(126) NOT NULL,
  aggregate_version     BIGINT DEFAULT 1 NOT NULL,
  active                BOOLEAN DEFAULT TRUE,
  update_ts             TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  update_user           VARCHAR(126) DEFAULT SESSION_USER,
  PRIMARY KEY(host_id, assignee_id, category_id, sequence_id),
  FOREIGN KEY(host_id, assignee_id, category_id) REFERENCES worklist_t(host_id, assignee_id, category_id) ON DELETE CASCADE
);

CREATE TABLE process_info_t (
  host_id                    UUID NOT NULL,
  process_id                 UUID NOT NULL, -- generated uuid
  wf_def_id                  UUID NOT NULL, -- workflow definition id
  wf_instance_id             VARCHAR(126)       NOT NULL, -- workflow intance id
  app_id                     VARCHAR(512)       NOT NULL, -- application id
  process_type               VARCHAR(126)      NOT NULL,
  status_code                CHAR(1)            NOT NULL, -- process status code 'A', 'C'
  started_ts                 TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  ex_trigger_ts              TIMESTAMP WITH TIME ZONE          NOT NULL,
  custom_status_code         VARCHAR(126),
  completed_ts               TIMESTAMP WITH TIME ZONE,
  result_code                VARCHAR(126),
  source_id                  VARCHAR(126),
  branch_code                VARCHAR(126),
  rr_code                    VARCHAR(126),
  party_id                   VARCHAR(126),
  party_name                 VARCHAR(126),
  counter_party_id           VARCHAR(126),
  counter_party_name         VARCHAR(126),
  txn_id                     VARCHAR(126),
  txn_name                   VARCHAR(126),
  product_id                 VARCHAR(126),
  product_name               VARCHAR(126),
  product_type               VARCHAR(126),
  group_name                 VARCHAR(126),
  subgroup_name              VARCHAR(126),
  event_start_ts             TIMESTAMP WITH TIME ZONE,
  event_end_ts               TIMESTAMP WITH TIME ZONE,
  event_other_ts             TIMESTAMP WITH TIME ZONE,
  event_other                VARCHAR(126),
  risk                       NUMERIC,
  risk_scale                 INTEGER,
  price                      NUMERIC,
  price_scale                INTEGER, -- Scale (number of digits to the right of the decimal) of the risk column. NULL implies zero
  product_qy                 NUMERIC,
  currency_code              CHAR(3),
  ex_ref_id                  VARCHAR(126),
  ex_ref_code                VARCHAR(126),
  product_qy_scale           INTEGER,
  parent_process_id          VARCHAR(22),
  deadline_ts                TIMESTAMP WITH TIME ZONE,
  parent_group_id            NUMERIC,
  process_subtype_code       VARCHAR(126),
  owning_group_name          VARCHAR(126), -- Name of the group that owns the process
  input_data                 JSONB,        -- The initial data that triggered the workflow
  context_data               JSONB,        -- The runtime "scratchpad" for intermediate variables
  error_info                 TEXT,         -- Detailed error or stack trace if the process fails
  aggregate_version   BIGINT DEFAULT 1 NOT NULL,
  active              BOOLEAN DEFAULT TRUE,
  update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  update_user         VARCHAR(126) DEFAULT SESSION_USER,
  PRIMARY KEY(host_id, process_id),
  FOREIGN KEY(host_id, wf_def_id) REFERENCES wf_definition_t(host_id, wf_def_id) ON DELETE CASCADE
);

CREATE TABLE task_info_t
(
    host_id             UUID NOT NULL,
    task_id             UUID NOT NULL,
    task_type           VARCHAR(126) NOT NULL,
    process_id          UUID NOT NULL,
    wf_instance_id      VARCHAR(126) NOT NULL,
    wf_task_id          VARCHAR(126) NOT NULL,
    status_code         CHAR(1)       NOT NULL, -- U, A, C
    started_ts          TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    locked              CHAR(1)       NOT NULL,
    priority            INTEGER        NOT NULL,
    completed_ts        TIMESTAMP WITH TIME ZONE      NULL,
    completed_user      VARCHAR(126)     NULL,
    result_code         VARCHAR(126)     NULL,
    locking_user        VARCHAR(126)     NULL,
    locking_role        VARCHAR(126)     NULL,
    deadline_ts         TIMESTAMP WITH TIME ZONE      NULL,
    lock_group          VARCHAR(126)     NULL,
    task_input          JSONB,           -- Specific data passed to the task
    task_output         JSONB,           -- Result returned by the task action
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT TRUE,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, task_id),
    FOREIGN KEY (host_id, process_id) REFERENCES process_info_t(host_id, process_id) ON DELETE CASCADE
);

CREATE TABLE task_asst_t
(
    host_id             UUID NOT NULL,
    task_asst_id         UUID NOT NULL,
    task_id              UUID NOT NULL,
    assigned_ts          TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    assignee_id          VARCHAR(126) NOT NULL,
    assignment_type      VARCHAR(16) DEFAULT 'USER' NOT NULL,
    assignment_id        VARCHAR(126) NOT NULL,
    reason_code          VARCHAR(126) NOT NULL,
    unassigned_ts        TIMESTAMP WITH TIME ZONE      NULL,
    unassigned_reason    VARCHAR(126)     NULL,
    category_code        VARCHAR(126)     NULL,
    status_code          VARCHAR(16) DEFAULT 'ASSIGNED' NOT NULL,
    claimed_by           VARCHAR(126)     NULL,
    claimed_ts           TIMESTAMP WITH TIME ZONE      NULL,
    claim_expires_ts     TIMESTAMP WITH TIME ZONE      NULL,
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active               BOOLEAN DEFAULT TRUE,
    update_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user          VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, task_asst_id),
    CONSTRAINT chk_task_asst_assignment_type CHECK (assignment_type IN ('USER', 'ROLE')),
    FOREIGN KEY(host_id, task_id) REFERENCES task_info_t(host_id, task_id) ON DELETE CASCADE
);
CREATE INDEX idx_task_asst_actionable
ON task_asst_t (host_id, assignee_id, status_code, active, assigned_ts DESC);
CREATE INDEX idx_task_asst_target_actionable
ON task_asst_t (host_id, assignment_type, assignment_id, status_code, active, assigned_ts DESC);
CREATE INDEX idx_task_asst_claimed_by
ON task_asst_t (host_id, claimed_by, status_code, active, assigned_ts DESC);
CREATE INDEX idx_task_asst_task
ON task_asst_t (host_id, task_id, active);

CREATE TABLE audit_log_t
(
    host_id             UUID NOT NULL,
    audit_log_id        UUID NOT NULL,
    source_type_id      VARCHAR(126)      NULL,
    correlation_id      VARCHAR(126)      NULL,
    user_id             VARCHAR(126)     NULL,
    event_ts            TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    success             CHAR(1)           NULL,
    message0            VARCHAR(126)     NULL,
    message1            VARCHAR(126)     NULL,
    message2            VARCHAR(126)     NULL,
    message3            VARCHAR(126)     NULL,
    message             VARCHAR(500)     NULL,
    user_comment        VARCHAR(500)     NULL,
    PRIMARY KEY(host_id, audit_log_id)
);

CREATE INDEX audit_log_idx1 ON audit_log_t (source_type_id, correlation_id, event_ts, user_id);

-- Agent Definitions: Stores the "Brain" configuration
CREATE TABLE agent_definition_t (
    host_id             UUID NOT NULL,
    agent_def_id        UUID NOT NULL,         -- Same value as api_version_t.api_version_id
    model_provider      VARCHAR(64) NOT NULL,  -- 'openai', 'anthropic', etc.
    model_name          VARCHAR(126) NOT NULL, -- 'gpt-4o', 'claude-3-5-sonnet'
    api_key_ref         VARCHAR(126),          -- Reference to Secret Manager key
    temperature         NUMERIC(3,2) DEFAULT 0.7,
    max_tokens          INTEGER,               -- max number of tokens can be used
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT TRUE,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, agent_def_id),
    CONSTRAINT agent_definition_api_version_fk FOREIGN KEY(host_id, agent_def_id) REFERENCES api_version_t(host_id, api_version_id) ON DELETE CASCADE
);


-- Skills: Stores Instructions and Domain Knowledge (The "Expertise")
-- Note: Use entity_tag_t and entity_category_t with entity_type = 'skill' 
-- for flat tagging and hierarchical folder structure of skills.
CREATE TABLE skill_t (
    host_id             UUID NOT NULL,
    skill_id            UUID NOT NULL,
    parent_skill_id     UUID,                  -- Self-reference for Hierarchy
    name                VARCHAR(126) NOT NULL,
    description         VARCHAR(500),          -- High-level description for the initial LLM prompt
    content_markdown    TEXT NOT NULL,         -- The actual instructions/prompts

    description_embedding VECTOR(384),          -- For semantic lookup/discovery
    version             VARCHAR(20) DEFAULT '1.0.0',
    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, skill_id),
    FOREIGN KEY(host_id, parent_skill_id) REFERENCES skill_t(host_id, skill_id)
);

CREATE INDEX idx_skill_active ON skill_t(active);
CREATE INDEX idx_skill_name ON skill_t(name);

-- Tools: Stores Executable Functions (The "Hands")
CREATE TABLE tool_t (
    host_id             UUID NOT NULL,
    tool_id             UUID NOT NULL,
    name                VARCHAR(126) NOT NULL,
    description         TEXT NOT NULL,         -- Instructions for LLM on when/how to use this tool
    description_source  VARCHAR(32),           -- endpoint_sync, manual, or another source label
    description_manual_override BOOLEAN DEFAULT FALSE NOT NULL,
    description_override_ts TIMESTAMP WITH TIME ZONE,
    description_override_user VARCHAR(126),

    -- Implementation specifics
    implementation_type VARCHAR(50),           -- 'java', 'mcp_server', 'rest', 'python', 'javascript'
    implementation_class VARCHAR(500),         -- FQCN if 'java'
    mcp_server_name      VARCHAR(126),         -- MCP server name if 'mcp_server'
    api_endpoint        VARCHAR(1024),         -- URL if 'rest'
    api_method          VARCHAR(10),           -- HTTP Method if 'rest'
    endpoint_id         UUID,                  -- Reference to fine-grained auth endpoint
    capability_ref      VARCHAR(512),          -- Stable LightAPI endpointId used by workflows
    lightapi_document   JSONB,                 -- Validated LightAPI profile:endpoint document
    lightapi_digest     VARCHAR(71),            -- Digest pinned by workflow grants
    lightapi_validation_status VARCHAR(16),     -- VALID or INVALID
    lightapi_validation_errors JSONB DEFAULT '[]'::JSONB,
    lightapi_validated_ts TIMESTAMPTZ,
    script_content      TEXT,                  -- Source code if 'python'/'javascript'
    response_schema     JSONB,                 -- Strict output schema for tool results
    tool_metadata       JSONB,                 -- Canonical MCP/catalog metadata for manually authored tools
    routing_domain      VARCHAR(128),          -- Macro-filtering domain for semantic routing
    semantic_namespace  VARCHAR(128),          -- Semantic namespace/owner of the tool
    sensitivity_tier    VARCHAR(64),           -- Safety/routing sensitivity tier
    semantic_weight     REAL DEFAULT 1.0,      -- Search/routing weight
    source_protocol     VARCHAR(50),           -- Source protocol such as openapi, mcp, lightapi, or http
    lifecycle_status    VARCHAR(32) DEFAULT 'active',
    cost_tier           VARCHAR(32),
    target_personas     TEXT,                  -- JSON array or comma-separated persona hints

    description_embedding VECTOR(384),          -- For semantic lookup/discovery
    description_embedding_model VARCHAR(128),
    description_embedding_dimension INTEGER,
    description_embedding_source_hash VARCHAR(64),
    description_embedding_ts TIMESTAMP WITH TIME ZONE,
    description_embedding_status VARCHAR(32),
    description_embedding_error TEXT,
    version             VARCHAR(20) DEFAULT '1.0.0',
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, tool_id),
    FOREIGN KEY(host_id, endpoint_id) REFERENCES api_endpoint_t(host_id, endpoint_id) ON DELETE CASCADE
);

ALTER TABLE tool_t
    ADD CONSTRAINT chk_tool_source_protocol CHECK (source_protocol IN ('openapi', 'mcp', 'lightapi', 'http') OR source_protocol IS NULL),
    ADD CONSTRAINT chk_tool_lifecycle CHECK (lifecycle_status IS NOT NULL AND lifecycle_status IN ('active', 'deprecated', 'retired')),
    ADD CONSTRAINT chk_tool_cost CHECK (cost_tier IN ('low', 'medium', 'high') OR cost_tier IS NULL),
    ADD CONSTRAINT chk_tool_lightapi_digest CHECK (lightapi_digest IS NULL OR lightapi_digest ~ '^sha256:[0-9a-f]{64}$'),
    ADD CONSTRAINT chk_tool_lightapi_status CHECK (lightapi_validation_status IS NULL OR lightapi_validation_status IN ('VALID', 'INVALID')),
    ADD CONSTRAINT chk_tool_lightapi_errors CHECK (lightapi_validation_errors IS NULL OR jsonb_typeof(lightapi_validation_errors) = 'array');

CREATE INDEX idx_tool_host_endpoint ON tool_t(host_id, endpoint_id);
CREATE UNIQUE INDEX tool_endpoint_uq ON tool_t(host_id, endpoint_id) WHERE endpoint_id IS NOT NULL AND active;
CREATE UNIQUE INDEX tool_capability_version_uq ON tool_t(host_id, capability_ref, version) WHERE capability_ref IS NOT NULL AND active;
CREATE INDEX idx_tool_active ON tool_t(active);
CREATE INDEX idx_tool_name ON tool_t(name);
CREATE INDEX idx_tool_routing ON tool_t(host_id, active, routing_domain, semantic_namespace, sensitivity_tier);
CREATE INDEX idx_tool_source_protocol ON tool_t(host_id, source_protocol);
CREATE INDEX idx_tool_lifecycle_cost ON tool_t(host_id, active, lifecycle_status, cost_tier);
CREATE INDEX idx_tool_description_embedding_status ON tool_t(host_id, active, description_embedding_status);
CREATE INDEX idx_tool_description_embedding_source_hash ON tool_t(host_id, description_embedding_source_hash);
CREATE INDEX idx_tool_description_embedding ON tool_t USING hnsw (description_embedding vector_cosine_ops)
    WHERE active = TRUE
      AND description_embedding IS NOT NULL
      AND description_embedding_status = 'ready';

CREATE TABLE embedding_task_t (
    host_id             UUID NOT NULL,
    task_id             UUID NOT NULL,
    entity_type         VARCHAR(64) NOT NULL,
    entity_id           UUID NOT NULL,
    source_table        VARCHAR(128),
    source_hash         VARCHAR(64) NOT NULL,
    source_version      BIGINT,
    status              VARCHAR(32) DEFAULT 'pending' NOT NULL,
    attempt_count       INTEGER DEFAULT 0 NOT NULL,
    next_attempt_ts     TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_error          TEXT,
    active              BOOLEAN DEFAULT TRUE,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, task_id),
    UNIQUE(host_id, entity_type, entity_id, source_hash)
);

CREATE INDEX idx_embedding_task_due ON embedding_task_t(status, active, next_attempt_ts);
CREATE INDEX idx_embedding_task_entity ON embedding_task_t(host_id, entity_type, entity_id);

-- Tool Parameters: Defines the arguments for each tool
CREATE TABLE tool_param_t (
    host_id             UUID NOT NULL,
    param_id            UUID NOT NULL,
    tool_id             UUID NOT NULL,
    name                VARCHAR(255) NOT NULL,
    param_type          VARCHAR(50) NOT NULL,      -- 'string', 'number', 'boolean', 'object', 'array'
    required            BOOLEAN DEFAULT true,
    default_value       JSONB,
    description         TEXT,                      -- Helps LLM understand what value to extract
    validation_schema   JSONB,                     -- JSON Schema for complex validation
    order_index         INTEGER DEFAULT 0,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, param_id),
    FOREIGN KEY(host_id, tool_id) REFERENCES tool_t(host_id, tool_id) ON DELETE CASCADE
);

-- Skill Dependencies: Manages hierarchies where one skill requires another
CREATE TABLE skill_dependency_t (
    host_id             UUID NOT NULL,
    skill_id            UUID NOT NULL,
    depends_on_skill_id UUID NOT NULL,
    required            BOOLEAN DEFAULT true,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY (host_id, skill_id, depends_on_skill_id),
    FOREIGN KEY(host_id, skill_id) REFERENCES skill_t(host_id, skill_id),
    FOREIGN KEY(host_id, depends_on_skill_id) REFERENCES skill_t(host_id, skill_id)
);

-- Agent-Skill Mapping: Links Agents to their Skills
CREATE TABLE agent_skill_t (
    host_id             UUID NOT NULL,
    agent_def_id        UUID NOT NULL,
    skill_id            UUID NOT NULL,

    config              JSONB DEFAULT '{}',
    priority            INTEGER DEFAULT 0,
    sequence_id         INTEGER DEFAULT 0,     -- Order in which skills are concatenated

    aggregate_version    BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, agent_def_id, skill_id),
    FOREIGN KEY(host_id, agent_def_id) REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, skill_id) REFERENCES skill_t(host_id, skill_id) ON DELETE CASCADE
);
CREATE INDEX idx_agent_skill_agent ON agent_skill_t(agent_def_id);

-- Skill-Tool Mapping: Implements Progressive Disclosure
CREATE TABLE skill_tool_t (
    host_id             UUID NOT NULL,
    skill_id            UUID NOT NULL,
    tool_id             UUID NOT NULL,

    config              JSONB DEFAULT '{}',
    access_level        VARCHAR(20) DEFAULT 'read', -- e.g., 'read', 'write', 'execute'

    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, skill_id, tool_id),
    FOREIGN KEY(host_id, skill_id) REFERENCES skill_t(host_id, skill_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, tool_id) REFERENCES tool_t(host_id, tool_id) ON DELETE CASCADE
);
CREATE INDEX idx_skill_tool_skill ON skill_tool_t(skill_id);

-- Skill-Workflow Mapping: Links skills to durable workflow definitions
CREATE TABLE skill_workflow_t (
    host_id             UUID NOT NULL,
    skill_id            UUID NOT NULL,
    wf_def_id           UUID NOT NULL,
    workflow_role       VARCHAR(32) DEFAULT 'primary',
    start_mode          VARCHAR(32) DEFAULT 'manual',
    config              JSONB DEFAULT '{}',

    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, skill_id, wf_def_id, workflow_role),
    FOREIGN KEY(host_id, skill_id) REFERENCES skill_t(host_id, skill_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, wf_def_id) REFERENCES wf_definition_t(host_id, wf_def_id) ON DELETE CASCADE
);
CREATE INDEX idx_skill_workflow_skill ON skill_workflow_t(host_id, skill_id);
CREATE INDEX idx_skill_workflow_wf_def ON skill_workflow_t(host_id, wf_def_id);

-- -- Hindsight Advanced Memory System
-- Transitioned from flat logs to biomimetic memory banks (World, Experiences, Mental Models)

-- Memory bank profiles (Personality & Disposition)
CREATE TABLE agent_memory_bank_t (
    host_id             UUID NOT NULL,
    bank_id             UUID NOT NULL,
    agent_def_id        UUID,                  -- NULL if bank is shared across agents
    user_id             UUID,                  -- NULL if bank is global for the host/agent
    bank_name           VARCHAR(126) NOT NULL,
    disposition         JSONB NOT NULL DEFAULT '{"skepticism": 3, "literalism": 3, "empathy": 3}'::jsonb,
    background          TEXT,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, bank_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, agent_def_id) REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES user_t(user_id) ON DELETE CASCADE
);

-- Source documents for memory units
CREATE TABLE agent_memory_doc_t (
    host_id             UUID NOT NULL,
    doc_id              UUID NOT NULL,
    bank_id             UUID NOT NULL,
    original_text       TEXT,
    content_hash        TEXT,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY (host_id, bank_id, doc_id),
    FOREIGN KEY (host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE
);

-- Individual sentence-level memories (The "Atoms" of thought)
CREATE TABLE agent_memory_unit_t (
    host_id             UUID NOT NULL,
    unit_id             UUID NOT NULL,
    bank_id             UUID NOT NULL,
    doc_id              UUID,
    content             TEXT NOT NULL,
    embedding           vector(384),
    context             TEXT,
    event_date          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    occurred_start      TIMESTAMP WITH TIME ZONE,
    occurred_end        TIMESTAMP WITH TIME ZONE,
    mentioned_at        TIMESTAMP WITH TIME ZONE,
    fact_type           VARCHAR(32) NOT NULL DEFAULT 'world' CHECK (fact_type IN ('world', 'experience', 'opinion', 'observation', 'mental_model')),
    metadata            JSONB DEFAULT '{}'::jsonb,
    proof_count         INT DEFAULT 1,
    source_memory_ids   UUID[] DEFAULT ARRAY[]::UUID[],
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, bank_id, unit_id),
    FOREIGN KEY(host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, bank_id, doc_id) REFERENCES agent_memory_doc_t(host_id, bank_id, doc_id) ON DELETE CASCADE
);

CREATE INDEX idx_mem_unit_bank ON agent_memory_unit_t(bank_id);
CREATE INDEX idx_mem_unit_embedding ON agent_memory_unit_t USING hnsw (embedding vector_cosine_ops);

-- Resolved entities (Knowledge Graph Nodes)
CREATE TABLE agent_memory_entity_t (
    host_id             UUID NOT NULL,
    entity_id           UUID NOT NULL,
    bank_id             UUID NOT NULL,
    user_id             UUID,                  -- Link to user_t if this entity is a platform user
    canonical_name      TEXT NOT NULL,
    mention_count       INT DEFAULT 1,
    metadata            JSONB DEFAULT '{}'::jsonb,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY (host_id, bank_id, entity_id),
    FOREIGN KEY (host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE
);

-- Association between memory units and entities
CREATE TABLE agent_memory_unit_entity_t (
    host_id             UUID NOT NULL,
    bank_id             UUID NOT NULL,
    unit_id             UUID NOT NULL,
    entity_id           UUID NOT NULL,
    PRIMARY KEY (host_id, bank_id, unit_id, entity_id),
    FOREIGN KEY (host_id, bank_id, unit_id) REFERENCES agent_memory_unit_t(host_id, bank_id, unit_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, bank_id, entity_id) REFERENCES agent_memory_entity_t(host_id, bank_id, entity_id) ON DELETE CASCADE
);

-- Cache of entity co-occurrences (Concept Relationship Graph)
CREATE TABLE agent_memory_entity_cooccur_t (
    host_id             UUID NOT NULL,
    bank_id             UUID NOT NULL,
    entity_id_1         UUID NOT NULL,
    entity_id_2         UUID NOT NULL,
    cooccur_count       INT DEFAULT 1,
    last_cooccurred     TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY (host_id, bank_id, entity_id_1, entity_id_2),
    CONSTRAINT entity_cooccur_order_check CHECK (entity_id_1 < entity_id_2),
    FOREIGN KEY (host_id, bank_id, entity_id_1) REFERENCES agent_memory_entity_t(host_id, bank_id, entity_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, bank_id, entity_id_2) REFERENCES agent_memory_entity_t(host_id, bank_id, entity_id) ON DELETE CASCADE
);

CREATE INDEX idx_mem_cooccur_e1 ON agent_memory_entity_cooccur_t(host_id, entity_id_1);
CREATE INDEX idx_mem_cooccur_e2 ON agent_memory_entity_cooccur_t(host_id, entity_id_2);

-- Links between memory units (Semantic & Causal relationships)
CREATE TABLE agent_memory_link_t (
    host_id             UUID NOT NULL,
    bank_id             UUID NOT NULL,
    from_unit_id        UUID NOT NULL,
    to_unit_id          UUID NOT NULL,
    link_type           VARCHAR(32) NOT NULL,
    weight              FLOAT NOT NULL DEFAULT 1.0,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY (host_id, bank_id, from_unit_id, to_unit_id, link_type),
    CONSTRAINT memory_links_type_check CHECK (link_type IN ('temporal', 'semantic', 'entity', 'causes', 'caused_by', 'enables', 'prevents')),
    FOREIGN KEY (host_id, bank_id, from_unit_id) REFERENCES agent_memory_unit_t(host_id, bank_id, unit_id) ON DELETE CASCADE,
    FOREIGN KEY (host_id, bank_id, to_unit_id) REFERENCES agent_memory_unit_t(host_id, bank_id, unit_id) ON DELETE CASCADE
);

-- Directives (Hard rules that override probabilistic learning)
CREATE TABLE agent_memory_directive_t (
    host_id             UUID NOT NULL,
    directive_id        UUID NOT NULL,
    bank_id             UUID NOT NULL,
    name                VARCHAR(256) NOT NULL,
    content             TEXT NOT NULL,
    priority            INT NOT NULL DEFAULT 0,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, bank_id, directive_id),
    FOREIGN KEY(host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE
);

-- Reflections (Synthesized knowledge and high-level observations)
CREATE TABLE agent_memory_reflection_t (
    host_id             UUID NOT NULL,
    reflection_id       UUID NOT NULL,
    bank_id             UUID NOT NULL,
    content             TEXT NOT NULL,
    embedding           vector(384),
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, bank_id, reflection_id),
    FOREIGN KEY(host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE
);

CREATE INDEX idx_mem_reflection_embedding ON agent_memory_reflection_t USING hnsw (embedding vector_cosine_ops);

-- Raw Session History (The source of Truth for active conversations)
CREATE TABLE agent_session_history_t (
    host_id             UUID NOT NULL,
    session_id          UUID NOT NULL,
    bank_id             UUID NOT NULL,         -- Links the session to a Hindsight bank
    messages            JSONB NOT NULL DEFAULT '[]'::jsonb,
    metadata            JSONB DEFAULT '{}'::jsonb,
    aggregate_version   BIGINT DEFAULT 1 NOT NULL,
    active              BOOLEAN DEFAULT true,
    update_ts           TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    update_user         VARCHAR(126) DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, bank_id, session_id),
    FOREIGN KEY(host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE CASCADE
);

CREATE INDEX idx_session_bank ON agent_session_history_t(host_id, bank_id);

CREATE OR REPLACE FUNCTION set_owner_user_id_from_update_user()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.owner_user_id IS NULL
       AND NEW.update_user IS NOT NULL
       AND NEW.update_user ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' THEN
        NEW.owner_user_id := NEW.update_user::UUID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE INDEX idx_schedule_owner_user ON schedule_t(host_id, owner_user_id);
CREATE INDEX idx_schedule_owner_position ON schedule_t(host_id, owner_position_id);
CREATE TRIGGER trg_schedule_owner_user
    BEFORE INSERT ON schedule_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_api_owner_user ON api_t(host_id, owner_user_id);
CREATE INDEX idx_api_owner_position ON api_t(host_id, owner_position_id);
CREATE TRIGGER trg_api_owner_user
    BEFORE INSERT ON api_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_api_version_owner_user ON api_version_t(host_id, owner_user_id);
CREATE INDEX idx_api_version_owner_position ON api_version_t(host_id, owner_position_id);
CREATE TRIGGER trg_api_version_owner_user
    BEFORE INSERT ON api_version_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_app_api_owner_user ON app_api_t(host_id, owner_user_id);
CREATE INDEX idx_app_api_owner_position ON app_api_t(host_id, owner_position_id);
CREATE TRIGGER trg_app_api_owner_user
    BEFORE INSERT ON app_api_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_app_owner_user ON app_t(host_id, owner_user_id);
CREATE INDEX idx_app_owner_position ON app_t(host_id, owner_position_id);
CREATE TRIGGER trg_app_owner_user
    BEFORE INSERT ON app_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_instance_owner_user ON instance_t(host_id, owner_user_id);
CREATE INDEX idx_instance_owner_position ON instance_t(host_id, owner_position_id);
CREATE TRIGGER trg_instance_owner_user
    BEFORE INSERT ON instance_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_deployment_instance_owner_user ON deployment_instance_t(host_id, owner_user_id);
CREATE INDEX idx_deployment_instance_owner_position ON deployment_instance_t(host_id, owner_position_id);
CREATE TRIGGER trg_deployment_instance_owner_user
    BEFORE INSERT ON deployment_instance_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_instance_api_owner_user ON instance_api_t(host_id, owner_user_id);
CREATE INDEX idx_instance_api_owner_position ON instance_api_t(host_id, owner_position_id);
CREATE TRIGGER trg_instance_api_owner_user
    BEFORE INSERT ON instance_api_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_instance_api_path_prefix_owner_user ON instance_api_path_prefix_t(host_id, owner_user_id);
CREATE INDEX idx_instance_api_path_prefix_owner_position ON instance_api_path_prefix_t(host_id, owner_position_id);
CREATE TRIGGER trg_instance_api_path_prefix_owner_user
    BEFORE INSERT ON instance_api_path_prefix_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_instance_app_owner_user ON instance_app_t(host_id, owner_user_id);
CREATE INDEX idx_instance_app_owner_position ON instance_app_t(host_id, owner_position_id);
CREATE TRIGGER trg_instance_app_owner_user
    BEFORE INSERT ON instance_app_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_instance_app_api_owner_user ON instance_app_api_t(host_id, owner_user_id);
CREATE INDEX idx_instance_app_api_owner_position ON instance_app_api_t(host_id, owner_position_id);
CREATE TRIGGER trg_instance_app_api_owner_user
    BEFORE INSERT ON instance_app_api_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_runtime_instance_owner_user ON runtime_instance_t(host_id, owner_user_id);
CREATE INDEX idx_runtime_instance_owner_position ON runtime_instance_t(host_id, owner_position_id);
CREATE TRIGGER trg_runtime_instance_owner_user
    BEFORE INSERT ON runtime_instance_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_auth_client_owner_user ON auth_client_t(host_id, owner_user_id);
CREATE INDEX idx_auth_client_owner_position ON auth_client_t(host_id, owner_position_id);
CREATE TRIGGER trg_auth_client_owner_user
    BEFORE INSERT ON auth_client_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_auth_client_token_owner_user ON auth_client_token_t(host_id, owner_user_id);
CREATE INDEX idx_auth_client_token_owner_position ON auth_client_token_t(host_id, owner_position_id);
CREATE TRIGGER trg_auth_client_token_owner_user
    BEFORE INSERT ON auth_client_token_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();

CREATE INDEX idx_wf_definition_owner_user ON wf_definition_t(host_id, owner_user_id);
CREATE INDEX idx_wf_definition_owner_position ON wf_definition_t(host_id, owner_position_id);
CREATE INDEX idx_wf_definition_catalog_visible ON wf_definition_t(host_id, catalog_visible) WHERE catalog_visible = TRUE;
CREATE TRIGGER trg_wf_definition_owner_user
    BEFORE INSERT ON wf_definition_t
    FOR EACH ROW EXECUTE FUNCTION set_owner_user_id_from_update_user();






ALTER TABLE product_version_t
    ADD CONSTRAINT host_id_fk FOREIGN KEY (host_id)
        REFERENCES host_t (host_id)
            ON DELETE CASCADE;


ALTER TABLE api_endpoint_scope_t
    ADD CONSTRAINT api_ver_fk FOREIGN KEY (host_id, endpoint_id)
        REFERENCES api_endpoint_t (host_id, endpoint_id)
            ON DELETE CASCADE;

ALTER TABLE api_endpoint_rule_t
    ADD CONSTRAINT rule_fk FOREIGN KEY ( rule_id )
        REFERENCES rule_t ( rule_id )
            ON DELETE CASCADE;

ALTER TABLE instance_property_t
    ADD CONSTRAINT instance_fkv2 FOREIGN KEY (host_id, instance_id )
        REFERENCES instance_t (host_id, instance_id )
            ON DELETE CASCADE;


ALTER TABLE api_endpoint_rule_t
    ADD CONSTRAINT endpoint_fk FOREIGN KEY (host_id, endpoint_id)
        REFERENCES api_endpoint_t (host_id, endpoint_id)
            ON DELETE CASCADE;

ALTER TABLE app_api_t
    ADD CONSTRAINT app_fk FOREIGN KEY ( host_id, app_id )
        REFERENCES app_t ( host_id, app_id )
            ON DELETE CASCADE;


ALTER TABLE chain_handler_t
    ADD CONSTRAINT configuration_fk FOREIGN KEY ( configuration_id )
        REFERENCES config_t ( config_id )
            ON DELETE CASCADE;

ALTER TABLE config_property_t
    ADD CONSTRAINT config_fkv2 FOREIGN KEY ( config_id )
        REFERENCES config_t ( config_id )
            ON DELETE CASCADE;


ALTER TABLE environment_property_t
    ADD CONSTRAINT host_fk FOREIGN KEY (host_id)
        REFERENCES host_t (host_id)
            ON DELETE CASCADE;

ALTER TABLE instance_property_t
    ADD CONSTRAINT config_property_fkv1 FOREIGN KEY (property_id)
        REFERENCES config_property_t (property_id)
            ON DELETE CASCADE;

ALTER TABLE product_property_t
    ADD CONSTRAINT config_property_fkv2 FOREIGN KEY (property_id)
        REFERENCES config_property_t (property_id)
            ON DELETE CASCADE;

ALTER TABLE instance_t
    ADD CONSTRAINT product_version_fk FOREIGN KEY (host_id, product_version_id)
        REFERENCES product_version_t (host_id, product_version_id)
            ON DELETE CASCADE;


CREATE TABLE pii_token_scheme_t (
    scheme_id        SMALLINT PRIMARY KEY,
    scheme_code      VARCHAR(16) NOT NULL UNIQUE,
    description      TEXT NOT NULL,
    active           BOOLEAN DEFAULT TRUE NOT NULL,
    update_ts        TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_user      VARCHAR(126) DEFAULT SESSION_USER NOT NULL
);

INSERT INTO pii_token_scheme_t (scheme_id, scheme_code, description)
VALUES
    (0, 'UUID', 'UUID Version 4 token.'),
    (1, 'GUID', 'URL-safe base64 UUID token.'),
    (2, 'LN', 'Luhn-compliant numeric token.'),
    (3, 'N', 'Random numeric token, length preserving.'),
    (4, 'LN4', 'Luhn-compliant numeric token retaining the original last four digits.'),
    (5, 'AN', 'Alpha-numeric token, length preserving.'),
    (6, 'AN4', 'Alpha-numeric token retaining the original last four characters.'),
    (7, 'CC', 'Credit-card-shaped Luhn token retaining the original first digit.'),
    (8, 'CC4', 'Credit-card-shaped Luhn token retaining the original first and last four digits.');

CREATE TABLE pii_token_vault_t (
    host_id           UUID NOT NULL,
    token             TEXT NOT NULL,
    scheme_id         SMALLINT NOT NULL,
    value_hash        BYTEA NOT NULL,
    value_ciphertext  BYTEA NOT NULL,
    value_nonce       BYTEA NOT NULL,
    key_id            VARCHAR(128) NOT NULL,
    created_ts        TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_ts        TIMESTAMP WITH TIME ZONE,
    active            BOOLEAN DEFAULT TRUE NOT NULL,
    update_ts         TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_user       VARCHAR(126) DEFAULT SESSION_USER NOT NULL,
    PRIMARY KEY(host_id, token),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(scheme_id) REFERENCES pii_token_scheme_t(scheme_id)
);

CREATE UNIQUE INDEX pii_token_vault_value_uk
ON pii_token_vault_t(host_id, scheme_id, value_hash)
WHERE active = TRUE;

CREATE INDEX pii_token_vault_expiry_idx
ON pii_token_vault_t(expires_ts)
WHERE expires_ts IS NOT NULL;


ALTER TABLE process_info_t
    ADD COLUMN IF NOT EXISTS definition_snapshot JSONB,
    ADD COLUMN IF NOT EXISTS definition_digest VARCHAR(64),
    ADD COLUMN IF NOT EXISTS policy_snapshot_id UUID,
    ADD COLUMN IF NOT EXISTS policy_digest VARCHAR(64),
    ADD COLUMN IF NOT EXISTS source_event_id VARCHAR(126),
    ADD COLUMN IF NOT EXISTS execution_profile_id VARCHAR(126);

CREATE UNIQUE INDEX IF NOT EXISTS process_info_source_event_uk
    ON process_info_t(host_id, wf_def_id, source_event_id)
    WHERE source_event_id IS NOT NULL;

ALTER TABLE task_info_t
    ADD COLUMN IF NOT EXISTS execution_placement VARCHAR(16) NOT NULL DEFAULT 'host',
    ADD COLUMN IF NOT EXISTS task_policy_digest VARCHAR(64),
    ADD COLUMN IF NOT EXISTS scheduling_request_id UUID,
    ADD COLUMN IF NOT EXISTS accepted_attempt INTEGER;

ALTER TABLE task_info_t DROP CONSTRAINT IF EXISTS task_info_execution_placement_ck;
ALTER TABLE task_info_t ADD CONSTRAINT task_info_execution_placement_ck
    CHECK (execution_placement IN ('host', 'runner'));

CREATE INDEX IF NOT EXISTS task_info_active_host_idx
    ON task_info_t(host_id, priority DESC, started_ts, task_id)
    WHERE active = TRUE AND status_code = 'A' AND execution_placement = 'host';
CREATE INDEX IF NOT EXISTS task_info_active_runner_idx
    ON task_info_t(host_id, priority DESC, started_ts, task_id)
    WHERE active = TRUE AND status_code = 'A' AND execution_placement = 'runner';

CREATE TABLE IF NOT EXISTS workflow_execution_policy_t (
    policy_snapshot_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES host_t(host_id) ON DELETE RESTRICT,
    tenant_id UUID,
    definition_digest VARCHAR(64) NOT NULL,
    profile_id VARCHAR(126) NOT NULL,
    profile_version INTEGER NOT NULL,
    resolved_policy JSONB NOT NULL,
    policy_digest VARCHAR(64) NOT NULL,
    source VARCHAR(126) NOT NULL,
    created_by VARCHAR(126) NOT NULL,
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(host_id, policy_snapshot_id),
    UNIQUE(host_id, policy_digest)
);

ALTER TABLE process_info_t DROP CONSTRAINT IF EXISTS process_info_policy_snapshot_fk;
ALTER TABLE process_info_t ADD CONSTRAINT process_info_policy_snapshot_fk
    FOREIGN KEY(host_id, policy_snapshot_id)
    REFERENCES workflow_execution_policy_t(host_id, policy_snapshot_id) ON DELETE RESTRICT;

CREATE TABLE IF NOT EXISTS runner_session_t (
    host_id UUID NOT NULL REFERENCES host_t(host_id) ON DELETE RESTRICT,
    session_id UUID NOT NULL,
    runner_id VARCHAR(126) NOT NULL,
    authenticated_subject VARCHAR(255) NOT NULL,
    enrollment_id VARCHAR(126) NOT NULL,
    runner_version VARCHAR(64) NOT NULL,
    protocol_version VARCHAR(32) NOT NULL,
    connection_generation BIGINT NOT NULL CHECK (connection_generation > 0),
    status VARCHAR(32) NOT NULL,
    drain_state VARCHAR(32) NOT NULL DEFAULT 'ACCEPTING',
    binary_digest VARCHAR(128) NOT NULL,
    effective_config_digest VARCHAR(128) NOT NULL,
    command_allowlist_digest VARCHAR(128) NOT NULL,
    capability_document JSONB NOT NULL,
    compatibility_digest VARCHAR(128) NOT NULL,
    maximum_concurrency INTEGER NOT NULL CHECK (maximum_concurrency > 0),
    reported_available_capacity INTEGER NOT NULL DEFAULT 0 CHECK (reported_available_capacity >= 0),
    watchdog_healthy BOOLEAN NOT NULL,
    journal_healthy BOOLEAN NOT NULL,
    cleanup_backlog INTEGER NOT NULL DEFAULT 0 CHECK (cleanup_backlog >= 0),
    registered_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    heartbeat_ts TIMESTAMP WITH TIME ZONE,
    disconnected_ts TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY(host_id, session_id),
    UNIQUE(host_id, runner_id, connection_generation)
);

CREATE INDEX IF NOT EXISTS runner_session_live_idx
    ON runner_session_t(host_id, status, drain_state, heartbeat_ts DESC);

CREATE TABLE IF NOT EXISTS runner_backend_t (
    host_id UUID NOT NULL,
    session_id UUID NOT NULL,
    backend_id VARCHAR(126) NOT NULL,
    backend_version VARCHAR(64) NOT NULL,
    boundary_class VARCHAR(32) NOT NULL,
    host_exposure_class VARCHAR(32) NOT NULL,
    supported_actions JSONB NOT NULL DEFAULT '[]'::jsonb,
    supported_features JSONB NOT NULL DEFAULT '[]'::jsonb,
    capability_limits JSONB NOT NULL DEFAULT '{}'::jsonb,
    compatibility_digest VARCHAR(128) NOT NULL,
    health VARCHAR(32) NOT NULL,
    available_slots INTEGER NOT NULL DEFAULT 0 CHECK (available_slots >= 0),
    observed_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, session_id, backend_id),
    FOREIGN KEY(host_id, session_id) REFERENCES runner_session_t(host_id, session_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS runner_backend_capacity_idx
    ON runner_backend_t(host_id, health, boundary_class, available_slots DESC)
    WHERE available_slots > 0;

CREATE TABLE IF NOT EXISTS runner_scheduling_request_t (
    host_id UUID NOT NULL,
    request_id UUID NOT NULL,
    idempotency_key VARCHAR(255) NOT NULL,
    origin_kind VARCHAR(32) NOT NULL CHECK (origin_kind IN ('workflow', 'agent')),
    origin_service_id VARCHAR(255) NOT NULL,
    origin_instance_id VARCHAR(255) NOT NULL,
    subject_kind VARCHAR(32) NOT NULL CHECK (subject_kind IN ('workflow-task', 'agent-turn', 'agent-action')),
    subject_id UUID NOT NULL,
    process_id UUID,
    task_id UUID,
    agent_session_id UUID,
    agent_turn_id UUID,
    agent_action_id UUID,
    policy_snapshot_id UUID NOT NULL,
    policy_digest VARCHAR(64) NOT NULL,
    normalized_requirements JSONB NOT NULL,
    execution_spec JSONB NOT NULL DEFAULT '{}'::jsonb,
    fairness_key VARCHAR(255) NOT NULL,
    priority INTEGER NOT NULL DEFAULT 0,
    queue_sequence BIGINT GENERATED BY DEFAULT AS IDENTITY,
    not_before_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    state VARCHAR(32) NOT NULL CHECK (state IN ('PENDING_CAPACITY', 'RESERVED', 'ATTEMPT_CREATED', 'LEASED', 'SATISFIED', 'CANCELLED', 'EXPIRED')),
    selected_runner_session_id UUID,
    selected_backend_id VARCHAR(126),
    reservation_token_hash VARCHAR(128),
    reservation_expires_ts TIMESTAMP WITH TIME ZONE,
    retry_count INTEGER NOT NULL DEFAULT 0 CHECK (retry_count >= 0),
    next_retry_ts TIMESTAMP WITH TIME ZONE,
    diagnostic_reason VARCHAR(255),
    approval_id UUID,
    pinned_runner_id VARCHAR(126),
    pinned_backend_id VARCHAR(126),
    edge_binding_id UUID,
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, request_id),
    UNIQUE(host_id, origin_service_id, origin_instance_id, idempotency_key),
    FOREIGN KEY(host_id, policy_snapshot_id)
        REFERENCES workflow_execution_policy_t(host_id, policy_snapshot_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, process_id) REFERENCES process_info_t(host_id, process_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, task_id) REFERENCES task_info_t(host_id, task_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, selected_runner_session_id, selected_backend_id)
        REFERENCES runner_backend_t(host_id, session_id, backend_id) ON DELETE RESTRICT,
    CHECK (
        (subject_kind = 'workflow-task' AND process_id IS NOT NULL AND task_id IS NOT NULL
            AND agent_session_id IS NULL AND agent_turn_id IS NULL AND agent_action_id IS NULL)
        OR (subject_kind = 'agent-turn' AND process_id IS NULL AND task_id IS NULL
            AND agent_session_id IS NOT NULL AND agent_turn_id IS NOT NULL AND agent_action_id IS NULL)
        OR (subject_kind = 'agent-action' AND process_id IS NULL AND task_id IS NULL
            AND agent_session_id IS NOT NULL AND agent_turn_id IS NOT NULL AND agent_action_id IS NOT NULL)
    )
);


CREATE UNIQUE INDEX IF NOT EXISTS runner_request_active_subject_uk
    ON runner_scheduling_request_t(host_id, origin_service_id, origin_instance_id, subject_kind, subject_id)
    WHERE state IN ('PENDING_CAPACITY', 'RESERVED', 'ATTEMPT_CREATED', 'LEASED');
CREATE INDEX IF NOT EXISTS runner_request_fair_queue_idx
    ON runner_scheduling_request_t(state, not_before_ts, priority DESC, queue_sequence)
    WHERE state = 'PENDING_CAPACITY';
CREATE INDEX IF NOT EXISTS runner_request_reservation_expiry_idx
    ON runner_scheduling_request_t(reservation_expires_ts) WHERE state = 'RESERVED';

ALTER TABLE task_info_t DROP CONSTRAINT IF EXISTS task_info_scheduling_request_fk;
ALTER TABLE task_info_t ADD CONSTRAINT task_info_scheduling_request_fk
    FOREIGN KEY(host_id, scheduling_request_id)
    REFERENCES runner_scheduling_request_t(host_id, request_id) ON DELETE RESTRICT;

CREATE TABLE IF NOT EXISTS execution_attempt_t (
    host_id UUID NOT NULL,
    execution_id UUID NOT NULL,
    request_id UUID NOT NULL,
    origin_kind VARCHAR(32) NOT NULL CHECK (origin_kind IN ('workflow', 'agent')),
    origin_service_id VARCHAR(255) NOT NULL,
    origin_instance_id VARCHAR(255) NOT NULL,
    subject_kind VARCHAR(32) NOT NULL CHECK (subject_kind IN ('workflow-task', 'agent-turn', 'agent-action')),
    subject_id UUID NOT NULL,
    attempt_number INTEGER NOT NULL CHECK (attempt_number > 0),
    process_id UUID,
    task_id UUID,
    agent_session_id UUID,
    agent_turn_id UUID,
    agent_action_id UUID,
    lease_id UUID NOT NULL UNIQUE,
    fencing_token BIGINT NOT NULL CHECK (fencing_token > 0),
    runner_session_id UUID NOT NULL,
    connection_generation BIGINT NOT NULL CHECK (connection_generation > 0),
    backend_id VARCHAR(126) NOT NULL,
    backend_operation_id VARCHAR(255),
    state VARCHAR(32) NOT NULL CHECK (state IN ('CREATED', 'LEASED', 'STARTED', 'SUCCEEDED', 'FAILED', 'CANCELLED', 'TIMED_OUT', 'UNKNOWN', 'CLEANED')),
    lease_issued_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    lease_started_ts TIMESTAMP WITH TIME ZONE,
    lease_renewed_ts TIMESTAMP WITH TIME ZONE,
    lease_deadline_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    terminal_ts TIMESTAMP WITH TIME ZONE,
    normalized_result JSONB,
    normalized_error JSONB,
    retry_classification VARCHAR(32) CHECK (retry_classification IS NULL OR retry_classification IN ('safe', 'unsafe', 'inspect-required')),
    cleanup_state VARCHAR(32) NOT NULL DEFAULT 'REQUIRED'
        CHECK (cleanup_state IN ('NOT_REQUIRED', 'REQUIRED', 'IN_PROGRESS', 'CONFIRMED', 'FAILED')),
    cleanup_evidence JSONB,
    accepted_by_origin_ts TIMESTAMP WITH TIME ZONE,
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, execution_id),
    UNIQUE(host_id, origin_service_id, origin_instance_id, subject_kind, subject_id, attempt_number),
    UNIQUE(host_id, origin_service_id, origin_instance_id, subject_kind, subject_id, fencing_token),
    FOREIGN KEY(host_id, request_id)
        REFERENCES runner_scheduling_request_t(host_id, request_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, runner_session_id, backend_id)
        REFERENCES runner_backend_t(host_id, session_id, backend_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, process_id) REFERENCES process_info_t(host_id, process_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, task_id) REFERENCES task_info_t(host_id, task_id) ON DELETE CASCADE,
    CHECK ((state IN ('SUCCEEDED', 'FAILED', 'CANCELLED', 'TIMED_OUT', 'UNKNOWN', 'CLEANED')) = (terminal_ts IS NOT NULL))
);

CREATE INDEX IF NOT EXISTS execution_attempt_active_lease_idx
    ON execution_attempt_t(lease_deadline_ts) WHERE state IN ('CREATED', 'LEASED', 'STARTED');
CREATE INDEX IF NOT EXISTS execution_attempt_origin_result_idx
    ON execution_attempt_t(origin_service_id, origin_instance_id, terminal_ts, execution_id)
    WHERE terminal_ts IS NOT NULL AND accepted_by_origin_ts IS NULL;
CREATE INDEX IF NOT EXISTS execution_attempt_cleanup_idx
    ON execution_attempt_t(cleanup_state, updated_ts)
    WHERE cleanup_state IN ('REQUIRED', 'IN_PROGRESS', 'FAILED');

CREATE TABLE IF NOT EXISTS execution_session_t (
    host_id UUID NOT NULL,
    execution_session_id UUID NOT NULL,
    origin_kind VARCHAR(32) NOT NULL,
    origin_service_id VARCHAR(255) NOT NULL,
    origin_instance_id VARCHAR(255) NOT NULL,
    subject_kind VARCHAR(32) NOT NULL,
    subject_id UUID NOT NULL,
    origin_session_id UUID,
    policy_digest VARCHAR(64) NOT NULL,
    compatibility_digest VARCHAR(128) NOT NULL,
    runner_session_id UUID NOT NULL,
    backend_id VARCHAR(126) NOT NULL,
    backend_session_handle VARCHAR(255),
    checkpoint_handle VARCHAR(255),
    idle_expires_ts TIMESTAMP WITH TIME ZONE,
    maximum_expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    effective_expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    state VARCHAR(32) NOT NULL CHECK (state IN ('READY', 'ACTIVE_ACTION', 'IDLE', 'IDLE_APPROVAL_HOLD', 'CLEANUP_REQUESTED', 'CLEANING', 'CLEANED', 'FAILED')),
    session_version BIGINT NOT NULL CHECK (session_version > 0),
    session_fence BIGINT NOT NULL CHECK (session_fence > 0),
    hold_id UUID,
    hold_reason VARCHAR(126),
    hold_until_ts TIMESTAMP WITH TIME ZONE,
    hold_policy_digest VARCHAR(64),
    retained_resource_evidence JSONB,
    cleanup_status VARCHAR(32) NOT NULL DEFAULT 'NOT_REQUESTED'
        CHECK (cleanup_status IN ('NOT_REQUESTED', 'PENDING', 'CLEANING', 'CLEANED', 'FAILED')),
    cleanup_evidence JSONB,
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, execution_session_id),
    FOREIGN KEY(host_id, runner_session_id, backend_id)
        REFERENCES runner_backend_t(host_id, session_id, backend_id) ON DELETE RESTRICT,
    CHECK ((state = 'IDLE_APPROVAL_HOLD' AND hold_id IS NOT NULL AND hold_until_ts IS NOT NULL)
        OR state <> 'IDLE_APPROVAL_HOLD')
);

CREATE INDEX IF NOT EXISTS execution_session_expiry_idx
    ON execution_session_t(effective_expires_ts, state) WHERE state NOT IN ('CLEANED', 'FAILED');
CREATE INDEX IF NOT EXISTS execution_session_hold_expiry_idx
    ON execution_session_t(hold_until_ts) WHERE state = 'IDLE_APPROVAL_HOLD';

CREATE TABLE IF NOT EXISTS execution_session_cleanup_request_t (
    host_id UUID NOT NULL,
    cleanup_request_id UUID NOT NULL,
    execution_session_id UUID NOT NULL,
    origin_kind VARCHAR(32) NOT NULL,
    origin_service_id VARCHAR(255) NOT NULL,
    origin_instance_id VARCHAR(255) NOT NULL,
    origin_session_id UUID,
    subject_kind VARCHAR(32) NOT NULL,
    subject_id UUID NOT NULL,
    idempotency_key VARCHAR(255) NOT NULL,
    reason VARCHAR(64) NOT NULL,
    requested_by VARCHAR(255) NOT NULL,
    requested_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cleanup_deadline_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    state VARCHAR(32) NOT NULL CHECK (state IN ('PENDING', 'FENCED', 'DELIVERED', 'CLEANED', 'FAILED', 'EXPIRED')),
    runner_ack_ts TIMESTAMP WITH TIME ZONE,
    cleanup_evidence JSONB,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, cleanup_request_id),
    UNIQUE(host_id, origin_service_id, origin_instance_id, idempotency_key),
    FOREIGN KEY(host_id, execution_session_id)
        REFERENCES execution_session_t(host_id, execution_session_id) ON DELETE RESTRICT
);

CREATE UNIQUE INDEX IF NOT EXISTS execution_session_cleanup_active_uk
    ON execution_session_cleanup_request_t(host_id, execution_session_id)
    WHERE state IN ('PENDING', 'FENCED', 'DELIVERED');
CREATE INDEX IF NOT EXISTS execution_session_cleanup_due_idx
    ON execution_session_cleanup_request_t(state, cleanup_deadline_ts)
    WHERE state IN ('PENDING', 'FENCED', 'DELIVERED');

CREATE TABLE IF NOT EXISTS execution_input_t (
    host_id UUID NOT NULL,
    input_id UUID NOT NULL,
    request_id UUID NOT NULL,
    execution_id UUID,
    execution_session_id UUID,
    kind VARCHAR(32) NOT NULL,
    artifact_uri TEXT NOT NULL,
    content_digest VARCHAR(128) NOT NULL,
    size_bytes BIGINT NOT NULL CHECK (size_bytes >= 0),
    media_type VARCHAR(255) NOT NULL,
    signer_binding JSONB,
    provenance_binding JSONB,
    scanner_binding JSONB,
    revocation_binding JSONB,
    staging_root TEXT NOT NULL,
    mount_target TEXT NOT NULL,
    read_only BOOLEAN NOT NULL DEFAULT TRUE,
    executable BOOLEAN NOT NULL DEFAULT FALSE,
    staging_state VARCHAR(32) NOT NULL DEFAULT 'PENDING'
        CHECK (staging_state IN ('PENDING', 'STAGED', 'VERIFIED', 'REJECTED', 'REVOKED')),
    verification_error VARCHAR(255),
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, input_id),
    FOREIGN KEY(host_id, request_id)
        REFERENCES runner_scheduling_request_t(host_id, request_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, execution_id)
        REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, execution_session_id)
        REFERENCES execution_session_t(host_id, execution_session_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS workflow_artifact_t (
    host_id UUID NOT NULL,
    artifact_id UUID NOT NULL,
    execution_id UUID NOT NULL,
    execution_session_id UUID,
    process_id UUID,
    task_id UUID,
    logical_name VARCHAR(255) NOT NULL,
    media_type VARCHAR(255) NOT NULL,
    size_bytes BIGINT NOT NULL CHECK (size_bytes >= 0),
    content_digest VARCHAR(128) NOT NULL,
    storage_reference TEXT NOT NULL,
    producer VARCHAR(255) NOT NULL,
    policy_digest VARCHAR(64) NOT NULL,
    provenance_reference TEXT,
    signature_reference TEXT,
    retain_until_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    legal_hold BOOLEAN NOT NULL DEFAULT FALSE,
    verification_state VARCHAR(32) NOT NULL CHECK (verification_state IN ('PENDING', 'VERIFIED', 'REJECTED')),
    deletion_state VARCHAR(32) NOT NULL DEFAULT 'RETAINED'
        CHECK (deletion_state IN ('RETAINED', 'DELETE_PENDING', 'DELETING', 'DELETED', 'DELETE_FAILED')),
    deletion_attempt INTEGER NOT NULL DEFAULT 0 CHECK (deletion_attempt >= 0),
    deletion_next_retry_ts TIMESTAMP WITH TIME ZONE,
    deletion_evidence JSONB,
    deleted_ts TIMESTAMP WITH TIME ZONE,
    created_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(host_id, artifact_id),
    FOREIGN KEY(host_id, execution_id)
        REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, execution_session_id)
        REFERENCES execution_session_t(host_id, execution_session_id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS workflow_artifact_retention_idx
    ON workflow_artifact_t(deletion_state, legal_hold, retain_until_ts, deletion_next_retry_ts)
    WHERE deletion_state IN ('RETAINED', 'DELETE_PENDING', 'DELETE_FAILED');

CREATE TABLE IF NOT EXISTS workflow_approval_t (
    host_id UUID NOT NULL,
    approval_id UUID NOT NULL,
    process_id UUID NOT NULL,
    task_id UUID NOT NULL,
    preceding_execution_id UUID,
    consuming_execution_id UUID,
    artifact_digest_set JSONB NOT NULL DEFAULT '[]'::jsonb,
    provenance_digest VARCHAR(128),
    target VARCHAR(255) NOT NULL,
    operation VARCHAR(126) NOT NULL,
    policy_digest VARCHAR(64) NOT NULL,
    state VARCHAR(32) NOT NULL CHECK (state IN ('REQUESTED', 'APPROVED', 'REJECTED', 'EXPIRED', 'CONSUMED')),
    actor VARCHAR(255),
    reason TEXT,
    requested_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    decided_ts TIMESTAMP WITH TIME ZONE,
    expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    PRIMARY KEY(host_id, approval_id),
    FOREIGN KEY(host_id, process_id) REFERENCES process_info_t(host_id, process_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, task_id) REFERENCES task_info_t(host_id, task_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, preceding_execution_id)
        REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, consuming_execution_id)
        REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    CHECK (consuming_execution_id IS NULL OR state = 'CONSUMED')
);

CREATE UNIQUE INDEX IF NOT EXISTS workflow_approval_active_uk
    ON workflow_approval_t(host_id, process_id, task_id, policy_digest, target, operation)
    WHERE state IN ('REQUESTED', 'APPROVED');

ALTER TABLE runner_scheduling_request_t ADD CONSTRAINT runner_scheduling_request_approval_fk
    FOREIGN KEY(host_id, approval_id) REFERENCES workflow_approval_t(host_id, approval_id) ON DELETE RESTRICT;
CREATE UNIQUE INDEX IF NOT EXISTS runner_request_approval_uk
    ON runner_scheduling_request_t(host_id, approval_id) WHERE approval_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS execution_runtime_audit_t (
    audit_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    host_id UUID NOT NULL,
    origin_kind VARCHAR(32) NOT NULL,
    origin_service_id VARCHAR(255) NOT NULL,
    origin_instance_id VARCHAR(255) NOT NULL,
    subject_kind VARCHAR(32) NOT NULL,
    subject_id UUID NOT NULL,
    execution_id UUID,
    execution_session_id UUID,
    process_id UUID,
    task_id UUID,
    agent_session_id UUID,
    agent_turn_id UUID,
    agent_action_id UUID,
    actor VARCHAR(255) NOT NULL,
    event_type VARCHAR(126) NOT NULL,
    message_id UUID,
    lease_id UUID,
    fencing_token BIGINT,
    policy_digest VARCHAR(64),
    redacted_payload JSONB NOT NULL DEFAULT '{}'::jsonb,
    event_ts TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS execution_runtime_audit_subject_idx
    ON execution_runtime_audit_t(host_id, subject_kind, subject_id, audit_id);
CREATE INDEX IF NOT EXISTS execution_runtime_audit_execution_idx
    ON execution_runtime_audit_t(host_id, execution_id, audit_id) WHERE execution_id IS NOT NULL;

CREATE OR REPLACE FUNCTION execution_runtime_audit_append_only()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'execution_runtime_audit_t is append-only';
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS execution_runtime_audit_no_update ON execution_runtime_audit_t;
CREATE TRIGGER execution_runtime_audit_no_update
    BEFORE UPDATE OR DELETE ON execution_runtime_audit_t
    FOR EACH ROW EXECUTE FUNCTION execution_runtime_audit_append_only();

CREATE OR REPLACE FUNCTION notify_execution_result_ready_v1()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.terminal_ts IS NOT NULL
       AND NEW.state IN ('SUCCEEDED', 'FAILED', 'CANCELLED', 'TIMED_OUT', 'UNKNOWN')
       AND (TG_OP = 'INSERT' OR OLD.terminal_ts IS NULL) THEN
        PERFORM pg_notify('execution_result_ready_v1', json_build_object(
            'version', 1,
            'originServiceId', NEW.origin_service_id,
            'originInstanceId', NEW.origin_instance_id,
            'subjectKind', NEW.subject_kind,
            'subjectId', NEW.subject_id,
            'subjectAttempt', NEW.attempt_number,
            'executionId', NEW.execution_id
        )::text);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS execution_attempt_result_notify ON execution_attempt_t;
CREATE TRIGGER execution_attempt_result_notify
    AFTER INSERT OR UPDATE OF state, terminal_ts ON execution_attempt_t
    FOR EACH ROW EXECUTE FUNCTION notify_execution_result_ready_v1();

-- Light-Agent durable runtime (canonical fresh-install schema).

ALTER TABLE agent_definition_t
    ADD COLUMN IF NOT EXISTS product_profile VARCHAR(32) NOT NULL DEFAULT 'enterprise',
    ADD COLUMN IF NOT EXISTS default_execution_profile_id VARCHAR(126),
    ADD COLUMN IF NOT EXISTS policy_snapshot JSONB,
    ADD COLUMN IF NOT EXISTS policy_digest VARCHAR(71),
    ADD COLUMN IF NOT EXISTS maximum_session_seconds BIGINT,
    ADD COLUMN IF NOT EXISTS maximum_turn_seconds BIGINT;

ALTER TABLE tool_t
    ADD COLUMN IF NOT EXISTS stable_tool_ref UUID,
    ADD COLUMN IF NOT EXISTS execution_placement VARCHAR(16),
    ADD COLUMN IF NOT EXISTS model_alias VARCHAR(126),
    ADD COLUMN IF NOT EXISTS schema_digest VARCHAR(71),
    ADD COLUMN IF NOT EXISTS dispatch_policy_ref VARCHAR(255);

ALTER TABLE tool_t DROP CONSTRAINT IF EXISTS tool_execution_placement_ck;
ALTER TABLE tool_t ADD CONSTRAINT tool_execution_placement_ck
    CHECK (execution_placement IS NULL OR execution_placement IN ('gateway', 'runner', 'workflow', 'fixed'));
CREATE UNIQUE INDEX IF NOT EXISTS tool_stable_ref_uk ON tool_t(host_id, stable_tool_ref)
    WHERE stable_tool_ref IS NOT NULL;
UPDATE tool_t
SET stable_tool_ref = COALESCE(stable_tool_ref, tool_id),
    model_alias = COALESCE(model_alias, name),
    execution_placement = COALESCE(execution_placement, 'gateway')
WHERE execution_placement IS NULL
  AND (endpoint_id IS NOT NULL OR mcp_server_name IS NOT NULL OR implementation_type IN ('mcp_server','rest'));

ALTER TABLE agent_session_history_t
    ADD COLUMN IF NOT EXISTS durable_session_id UUID,
    ADD COLUMN IF NOT EXISTS projection_sequence BIGINT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS projection_state VARCHAR(16) NOT NULL DEFAULT 'CURRENT';

CREATE TABLE IF NOT EXISTS agent_policy_snapshot_t (
    host_id UUID NOT NULL REFERENCES host_t(host_id) ON DELETE RESTRICT,
    policy_snapshot_id UUID NOT NULL,
    agent_def_id UUID NOT NULL,
    definition_digest VARCHAR(71) NOT NULL,
    product_profile_digest VARCHAR(71) NOT NULL,
    model_digest VARCHAR(71) NOT NULL,
    catalog_digest VARCHAR(71) NOT NULL,
    memory_digest VARCHAR(71) NOT NULL,
    execution_digest VARCHAR(71) NOT NULL,
    channel_digest VARCHAR(71) NOT NULL,
    data_boundary_digest VARCHAR(71) NOT NULL,
    resolved_snapshot JSONB NOT NULL,
    policy_digest VARCHAR(71) NOT NULL,
    revoked_ts TIMESTAMP WITH TIME ZONE,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, policy_snapshot_id),
    UNIQUE(host_id, policy_digest),
    FOREIGN KEY(host_id, agent_def_id) REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS agent_session_t (
    host_id UUID NOT NULL REFERENCES host_t(host_id) ON DELETE RESTRICT,
    session_id UUID NOT NULL,
    principal_id VARCHAR(255) NOT NULL,
    user_id UUID,
    agent_def_id UUID NOT NULL,
    agent_definition_version BIGINT NOT NULL,
    bank_id UUID,
    execution_session_id UUID,
    policy_snapshot_id UUID NOT NULL,
    state VARCHAR(16) NOT NULL DEFAULT 'ACTIVE' CHECK (state IN ('ACTIVE','CLOSING','CLOSED','REVOKED','EXPIRED')),
    session_version BIGINT NOT NULL DEFAULT 1 CHECK (session_version > 0),
    active_turn_id UUID,
    next_turn_sequence BIGINT NOT NULL DEFAULT 1 CHECK (next_turn_sequence > 0),
    next_queue_sequence BIGINT NOT NULL DEFAULT 1 CHECK (next_queue_sequence > 0),
    idle_expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    maximum_expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    resume_handle_digest VARCHAR(71) NOT NULL,
    resume_revoked_ts TIMESTAMP WITH TIME ZONE,
    approval_hold_id UUID,
    approval_hold_state VARCHAR(32),
    approval_hold_expires_ts TIMESTAMP WITH TIME ZONE,
    preserved_workspace_ref VARCHAR(1024),
    cleanup_state VARCHAR(32) NOT NULL DEFAULT 'NOT_REQUIRED' CHECK (cleanup_state IN ('NOT_REQUIRED','CLEANUP_REQUESTED','CLEANUP_PENDING','CLEANED','CLEANUP_FAILED')),
    cleanup_request_id UUID,
    cleanup_evidence JSONB,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, session_id),
    FOREIGN KEY(host_id, agent_def_id) REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, bank_id) REFERENCES agent_memory_bank_t(host_id, bank_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, policy_snapshot_id) REFERENCES agent_policy_snapshot_t(host_id, policy_snapshot_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, execution_session_id) REFERENCES execution_session_t(host_id, execution_session_id) ON DELETE RESTRICT,
    CHECK (idle_expires_ts <= maximum_expires_ts),
    CHECK ((approval_hold_id IS NULL AND approval_hold_state IS NULL AND approval_hold_expires_ts IS NULL)
        OR (approval_hold_id IS NOT NULL AND approval_hold_state IS NOT NULL AND approval_hold_expires_ts IS NOT NULL))
);

CREATE UNIQUE INDEX IF NOT EXISTS agent_session_resume_uk ON agent_session_t(host_id, resume_handle_digest);
CREATE INDEX IF NOT EXISTS agent_session_expiry_idx ON agent_session_t(idle_expires_ts, maximum_expires_ts)
    WHERE state = 'ACTIVE';
CREATE INDEX IF NOT EXISTS agent_session_cleanup_idx ON agent_session_t(cleanup_state, updated_ts)
    WHERE cleanup_state IN ('CLEANUP_REQUESTED','CLEANUP_PENDING','CLEANUP_FAILED');

CREATE TABLE IF NOT EXISTS agent_turn_t (
    host_id UUID NOT NULL,
    turn_id UUID NOT NULL,
    session_id UUID NOT NULL,
    turn_sequence BIGINT NOT NULL CHECK (turn_sequence > 0),
    queue_sequence BIGINT NOT NULL CHECK (queue_sequence > 0),
    origin_kind VARCHAR(16) NOT NULL CHECK (origin_kind IN ('user','channel','workflow','scheduler','connector','service')),
    origin_ref VARCHAR(255),
    client_message_id VARCHAR(255) NOT NULL,
    idempotency_key VARCHAR(255) NOT NULL,
    state VARCHAR(32) NOT NULL DEFAULT 'QUEUED' CHECK (state IN ('QUEUED','RECEIVED','RUNNING_MODEL','WAITING_ACTION','RUNNING_ACTION','WAITING_RECONCILIATION','WAITING_APPROVAL','COMPLETED','FAILED','CANCELLED','UNKNOWN')),
    policy_snapshot_id UUID NOT NULL,
    policy_digest VARCHAR(71) NOT NULL,
    data_boundary_digest VARCHAR(71) NOT NULL,
    model_provider VARCHAR(64) NOT NULL,
    model_name VARCHAR(126) NOT NULL,
    model_action_budget INTEGER NOT NULL CHECK (model_action_budget > 0),
    token_budget BIGINT NOT NULL CHECK (token_budget > 0),
    cost_budget_micros BIGINT NOT NULL CHECK (cost_budget_micros >= 0),
    deadline_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    delegation_depth INTEGER NOT NULL DEFAULT 0 CHECK (delegation_depth >= 0),
    terminal_result JSONB,
    terminal_error JSONB,
    event_sequence BIGINT NOT NULL DEFAULT 0,
    projection_sequence BIGINT NOT NULL DEFAULT 0,
    activated_ts TIMESTAMP WITH TIME ZONE,
    terminal_ts TIMESTAMP WITH TIME ZONE,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, turn_id),
    UNIQUE(host_id, session_id, turn_sequence),
    UNIQUE(host_id, session_id, queue_sequence),
    UNIQUE(host_id, session_id, client_message_id),
    UNIQUE(host_id, session_id, idempotency_key),
    FOREIGN KEY(host_id, session_id) REFERENCES agent_session_t(host_id, session_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, policy_snapshot_id) REFERENCES agent_policy_snapshot_t(host_id, policy_snapshot_id) ON DELETE RESTRICT
);

ALTER TABLE agent_session_t DROP CONSTRAINT IF EXISTS agent_session_active_turn_fk;
ALTER TABLE agent_session_t ADD CONSTRAINT agent_session_active_turn_fk
    FOREIGN KEY(host_id, active_turn_id) REFERENCES agent_turn_t(host_id, turn_id) DEFERRABLE INITIALLY DEFERRED;
CREATE UNIQUE INDEX IF NOT EXISTS agent_turn_one_active_uk ON agent_turn_t(host_id, session_id)
    WHERE state IN ('RECEIVED','RUNNING_MODEL','WAITING_ACTION','RUNNING_ACTION','WAITING_RECONCILIATION','WAITING_APPROVAL');
CREATE INDEX IF NOT EXISTS agent_turn_fifo_idx ON agent_turn_t(host_id, session_id, queue_sequence)
    WHERE state = 'QUEUED';
CREATE INDEX IF NOT EXISTS agent_turn_reconcile_idx ON agent_turn_t(host_id, updated_ts)
    WHERE state IN ('WAITING_RECONCILIATION','RUNNING_ACTION');

CREATE TABLE IF NOT EXISTS agent_action_attempt_t (
    host_id UUID NOT NULL,
    action_attempt_id UUID NOT NULL,
    turn_id UUID NOT NULL,
    logical_action_id UUID NOT NULL,
    attempt_number INTEGER NOT NULL CHECK (attempt_number > 0),
    stable_tool_ref UUID NOT NULL,
    model_alias VARCHAR(126) NOT NULL,
    placement VARCHAR(16) NOT NULL CHECK (placement IN ('gateway','runner','workflow','fixed')),
    schema_digest VARCHAR(71) NOT NULL,
    policy_digest VARCHAR(71) NOT NULL,
    argument_digest VARCHAR(71) NOT NULL,
    effect_class VARCHAR(32) NOT NULL,
    state VARCHAR(32) NOT NULL CHECK (state IN ('PROPOSED','WAITING_APPROVAL','READY','DISPATCHED','RUNNING','APPROVAL_REQUIRED','SUCCEEDED','FAILED','CANCELLED','UNKNOWN','OPERATOR_REQUIRED','ACCEPTED')),
    approval_id UUID,
    execution_attempt_id UUID,
    superseded_action_attempt_id UUID,
    gateway_request_id UUID,
    gateway_token_id UUID,
    runtime_adapter_id VARCHAR(126),
    runtime_adapter_version VARCHAR(64),
    runtime_capability_digest VARCHAR(71),
    result JSONB,
    result_digest VARCHAR(71),
    origin_accepted_ts TIMESTAMP WITH TIME ZONE,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, action_attempt_id),
    UNIQUE(host_id, turn_id, logical_action_id, attempt_number),
    UNIQUE(host_id, execution_attempt_id),
    UNIQUE(host_id, gateway_request_id),
    FOREIGN KEY(host_id, turn_id) REFERENCES agent_turn_t(host_id, turn_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, execution_attempt_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, superseded_action_attempt_id) REFERENCES agent_action_attempt_t(host_id, action_attempt_id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS agent_action_pending_result_idx ON agent_action_attempt_t(host_id, execution_attempt_id)
    WHERE execution_attempt_id IS NOT NULL AND origin_accepted_ts IS NULL;

CREATE TABLE IF NOT EXISTS agent_approval_t (
    host_id UUID NOT NULL,
    approval_id UUID NOT NULL,
    turn_id UUID NOT NULL,
    logical_action_id UUID NOT NULL,
    subject_digest VARCHAR(71) NOT NULL,
    input_digest VARCHAR(71) NOT NULL,
    policy_digest VARCHAR(71) NOT NULL,
    approver_scope JSONB NOT NULL,
    state VARCHAR(16) NOT NULL DEFAULT 'REQUESTED' CHECK (state IN ('REQUESTED','APPROVED','REJECTED','EXPIRED','REVOKED')),
    nonce_digest VARCHAR(71) NOT NULL,
    expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    decision_actor VARCHAR(255),
    decision_ts TIMESTAMP WITH TIME ZONE,
    decision_reason TEXT,
    consumed_action_attempt_id UUID,
    consumed_execution_attempt_id UUID,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, approval_id),
    UNIQUE(host_id, nonce_digest),
    FOREIGN KEY(host_id, turn_id) REFERENCES agent_turn_t(host_id, turn_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, consumed_action_attempt_id) REFERENCES agent_action_attempt_t(host_id, action_attempt_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, consumed_execution_attempt_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    CHECK ((state = 'REQUESTED' AND decision_ts IS NULL) OR (state <> 'REQUESTED' AND decision_ts IS NOT NULL))
);

ALTER TABLE agent_action_attempt_t DROP CONSTRAINT IF EXISTS agent_action_approval_fk;
ALTER TABLE agent_action_attempt_t ADD CONSTRAINT agent_action_approval_fk
    FOREIGN KEY(host_id, approval_id) REFERENCES agent_approval_t(host_id, approval_id) ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX IF NOT EXISTS agent_approval_expiry_idx ON agent_approval_t(expires_ts) WHERE state = 'REQUESTED';

CREATE TABLE IF NOT EXISTS agent_session_event_t (
    host_id UUID NOT NULL,
    event_id UUID NOT NULL,
    session_id UUID NOT NULL,
    event_sequence BIGINT NOT NULL CHECK (event_sequence > 0),
    turn_id UUID,
    action_attempt_id UUID,
    actor_class VARCHAR(32) NOT NULL,
    event_type VARCHAR(64) NOT NULL,
    content JSONB NOT NULL,
    content_digest VARCHAR(71) NOT NULL,
    policy_digest VARCHAR(71) NOT NULL,
    visibility VARCHAR(16) NOT NULL DEFAULT 'USER',
    retention_class VARCHAR(32) NOT NULL DEFAULT 'STANDARD',
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, event_id),
    UNIQUE(host_id, session_id, event_sequence),
    FOREIGN KEY(host_id, session_id) REFERENCES agent_session_t(host_id, session_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, turn_id) REFERENCES agent_turn_t(host_id, turn_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, action_attempt_id) REFERENCES agent_action_attempt_t(host_id, action_attempt_id) ON DELETE RESTRICT
);

CREATE UNIQUE INDEX IF NOT EXISTS agent_action_result_event_uk
    ON agent_session_event_t(host_id, action_attempt_id)
    WHERE action_attempt_id IS NOT NULL AND event_type = 'ACTION_RESULT';
CREATE INDEX IF NOT EXISTS agent_event_projection_idx ON agent_session_event_t(host_id, session_id, event_sequence);

-- Workflow execution Phases 7-10 foundations (canonical schema).

ALTER TABLE workflow_artifact_t
    ADD COLUMN IF NOT EXISTS staging_reference TEXT,
    ADD COLUMN IF NOT EXISTS promotion_state VARCHAR(32) NOT NULL DEFAULT 'BOUND',
    ADD COLUMN IF NOT EXISTS provenance_digest VARCHAR(128);
ALTER TABLE workflow_artifact_t DROP CONSTRAINT IF EXISTS workflow_artifact_promotion_state_ck;
ALTER TABLE workflow_artifact_t ADD CONSTRAINT workflow_artifact_promotion_state_ck
    CHECK (promotion_state IN ('STAGED','METADATA_COMMITTED','BOUND','QUARANTINED'));

ALTER TABLE execution_input_t
    ADD COLUMN IF NOT EXISTS trust_bundle_id VARCHAR(126),
    ADD COLUMN IF NOT EXISTS trust_bundle_version INTEGER,
    ADD COLUMN IF NOT EXISTS package_manifest_digest VARCHAR(128),
    ADD COLUMN IF NOT EXISTS mount_options JSONB NOT NULL DEFAULT '["ro","nodev","nosuid","noexec"]'::jsonb;

CREATE TABLE IF NOT EXISTS execution_provenance_t (
    host_id UUID NOT NULL,
    provenance_id UUID NOT NULL,
    execution_id UUID NOT NULL,
    statement JSONB NOT NULL,
    statement_digest VARCHAR(128) NOT NULL,
    predicate_type VARCHAR(255) NOT NULL,
    trusted_generator VARCHAR(255) NOT NULL,
    signature_reference TEXT,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, provenance_id),
    UNIQUE(host_id, execution_id, statement_digest),
    FOREIGN KEY(host_id, execution_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS execution_credential_grant_audit_t (
    host_id UUID NOT NULL,
    grant_id UUID NOT NULL,
    execution_id UUID NOT NULL,
    fencing_token BIGINT NOT NULL,
    policy_digest VARCHAR(128) NOT NULL,
    operation VARCHAR(126) NOT NULL,
    destination_digest VARCHAR(128) NOT NULL,
    maximum_uses INTEGER NOT NULL CHECK (maximum_uses > 0),
    use_count INTEGER NOT NULL DEFAULT 0 CHECK (use_count >= 0),
    expires_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    revoked_ts TIMESTAMP WITH TIME ZONE,
    revocation_reason VARCHAR(255),
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, grant_id),
    FOREIGN KEY(host_id, execution_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    CHECK (use_count <= maximum_uses)
);
CREATE INDEX IF NOT EXISTS execution_credential_grant_expiry_idx
    ON execution_credential_grant_audit_t(expires_ts) WHERE revoked_ts IS NULL;

CREATE TABLE IF NOT EXISTS execution_runtime_tool_manifest_t (
    host_id UUID NOT NULL,
    manifest_id UUID NOT NULL,
    execution_id UUID NOT NULL,
    manifest JSONB NOT NULL,
    manifest_digest VARCHAR(128) NOT NULL,
    signer_reference VARCHAR(255) NOT NULL,
    verified_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, manifest_id),
    UNIQUE(host_id, execution_id, manifest_digest),
    FOREIGN KEY(host_id, execution_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS execution_fixed_action_t (
    host_id UUID NOT NULL,
    fixed_action_id UUID NOT NULL,
    action_kind VARCHAR(64) NOT NULL CHECK (action_kind IN ('apply-patch','create-branch','push-commit','open-pr','publish','sign')),
    execution_id UUID NOT NULL,
    approval_id UUID NOT NULL,
    repository_digest VARCHAR(128) NOT NULL,
    base_commit VARCHAR(64),
    repository_object_format VARCHAR(16) NOT NULL DEFAULT 'sha1',
    target_ref VARCHAR(255) NOT NULL,
    artifact_digest VARCHAR(128) NOT NULL,
    policy_digest VARCHAR(128) NOT NULL,
    repository_reference TEXT,
    patch_artifact_reference TEXT,
    changed_paths JSONB NOT NULL DEFAULT '[]'::jsonb,
    action_spec JSONB NOT NULL DEFAULT '{}'::jsonb,
    provenance_digest VARCHAR(128),
    idempotency_key VARCHAR(255),
    provider_receipt JSONB,
    state VARCHAR(32) NOT NULL CHECK (state IN ('REQUESTED','VALIDATED','RUNNING','SUCCEEDED','FAILED','REJECTED','UNKNOWN')),
    result_evidence JSONB,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id, fixed_action_id),
    FOREIGN KEY(host_id, execution_id) REFERENCES execution_attempt_t(host_id, execution_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, approval_id) REFERENCES workflow_approval_t(host_id, approval_id) ON DELETE RESTRICT
);
ALTER TABLE execution_fixed_action_t ADD CONSTRAINT execution_fixed_action_object_format_ck CHECK (repository_object_format IN ('sha1','sha256'));
ALTER TABLE execution_fixed_action_t ADD CONSTRAINT execution_fixed_action_base_commit_ck CHECK (action_kind NOT IN ('apply-patch','create-branch','open-pr','push-commit') OR ((repository_object_format='sha1' AND base_commit ~ '^[0-9A-Fa-f]{40}$') OR (repository_object_format='sha256' AND base_commit ~ '^[0-9A-Fa-f]{64}$')));
ALTER TABLE execution_fixed_action_t ADD CONSTRAINT execution_fixed_action_apply_patch_input_ck CHECK (action_kind <> 'apply-patch' OR (repository_reference IS NOT NULL AND patch_artifact_reference IS NOT NULL AND jsonb_typeof(changed_paths) = 'array'));
ALTER TABLE execution_fixed_action_t ADD CONSTRAINT execution_fixed_action_provider_input_ck CHECK (action_kind NOT IN ('create-branch','open-pr','publish','sign') OR (jsonb_typeof(action_spec)='object' AND idempotency_key IS NOT NULL AND length(idempotency_key) BETWEEN 16 AND 255));
CREATE UNIQUE INDEX IF NOT EXISTS execution_fixed_action_idempotency_uk ON execution_fixed_action_t(host_id,action_kind,idempotency_key) WHERE idempotency_key IS NOT NULL;
ALTER TABLE execution_fixed_action_t ADD COLUMN IF NOT EXISTS unknown_since_ts TIMESTAMPTZ,ADD COLUMN IF NOT EXISTS next_reconcile_ts TIMESTAMPTZ,ADD COLUMN IF NOT EXISTS reconciliation_attempt_count INTEGER NOT NULL DEFAULT 0,ADD COLUMN IF NOT EXISTS reconciliation_claim_token UUID,ADD COLUMN IF NOT EXISTS reconciliation_lease_expires_ts TIMESTAMPTZ;
ALTER TABLE execution_fixed_action_t ADD CONSTRAINT execution_fixed_action_reconciliation_ck CHECK(reconciliation_attempt_count>=0 AND ((reconciliation_claim_token IS NULL AND reconciliation_lease_expires_ts IS NULL) OR (state='UNKNOWN' AND reconciliation_claim_token IS NOT NULL AND reconciliation_lease_expires_ts IS NOT NULL)) AND (state<>'UNKNOWN' OR unknown_since_ts IS NOT NULL));
CREATE INDEX IF NOT EXISTS execution_fixed_action_reconcile_due_idx ON execution_fixed_action_t(next_reconcile_ts,updated_ts) WHERE state IN('RUNNING','UNKNOWN');

-- Light-Agent Phases 4-5: immutable packages, materialization, and origin-neutral scheduling.
ALTER TABLE runner_scheduling_request_t ALTER COLUMN policy_digest TYPE VARCHAR(71);
ALTER TABLE agent_definition_t ADD COLUMN IF NOT EXISTS materializer_id VARCHAR(126) NOT NULL DEFAULT 'enterprise', ADD COLUMN IF NOT EXISTS materializer_version INTEGER NOT NULL DEFAULT 1, ADD COLUMN IF NOT EXISTS skill_selection_policy JSONB NOT NULL DEFAULT '{}'::jsonb;
ALTER TABLE tool_t ADD COLUMN IF NOT EXISTS script_execution_policy VARCHAR(32) NOT NULL DEFAULT 'AUTHORING_ONLY';
ALTER TABLE tool_t DROP CONSTRAINT IF EXISTS tool_script_execution_policy_ck;
ALTER TABLE tool_t ADD CONSTRAINT tool_script_execution_policy_ck CHECK (script_execution_policy IN ('AUTHORING_ONLY','LEGACY_LOCAL_DISABLED'));
CREATE TABLE IF NOT EXISTS skill_package_t (
 host_id UUID NOT NULL, package_id UUID NOT NULL, package_name VARCHAR(255) NOT NULL, package_version VARCHAR(64) NOT NULL,
 product_profile VARCHAR(64) NOT NULL CHECK (product_profile IN ('enterprise','native-workflow','coding','personal-assistant','external-adapter')),
 object_reference TEXT NOT NULL, content_digest VARCHAR(71) NOT NULL, media_type VARCHAR(126) NOT NULL, size_bytes BIGINT NOT NULL CHECK(size_bytes>=0),
 signer_reference VARCHAR(255) NOT NULL, signature_reference TEXT NOT NULL, scanner_reference VARCHAR(255) NOT NULL, scan_digest VARCHAR(71) NOT NULL,
 provenance_reference TEXT NOT NULL, entrypoint VARCHAR(1024) NOT NULL, compatibility JSONB NOT NULL,
 instruction_authority VARCHAR(32) NOT NULL CHECK(instruction_authority IN ('platform','product','administrator','repository','generated')),
 state VARCHAR(32) NOT NULL CHECK(state IN ('PUBLISHED','REVOKED','RETIRED')), reviewed_by VARCHAR(255) NOT NULL, reviewed_ts TIMESTAMPTZ NOT NULL,
 revoked_ts TIMESTAMPTZ, revocation_reason TEXT, retain_until_ts TIMESTAMPTZ NOT NULL,
 deletion_state VARCHAR(32) NOT NULL DEFAULT 'RETAINED' CHECK(deletion_state IN ('RETAINED','DELETE_PENDING','DELETING','DELETED','DELETE_FAILED')),
 deletion_evidence JSONB, created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY(host_id,package_id), UNIQUE(host_id,package_name,package_version), UNIQUE(host_id,content_digest), FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT);
CREATE INDEX IF NOT EXISTS skill_package_select_idx ON skill_package_t(host_id,product_profile,state,package_name,package_version);
CREATE INDEX IF NOT EXISTS skill_package_retention_idx ON skill_package_t(deletion_state,retain_until_ts) WHERE state <> 'PUBLISHED';
CREATE TABLE IF NOT EXISTS skill_package_proposal_t (
 host_id UUID NOT NULL, proposal_id UUID NOT NULL, source_kind VARCHAR(32) NOT NULL CHECK(source_kind IN ('repository','agent-generated','import')),
 source_reference TEXT NOT NULL, proposed_manifest JSONB NOT NULL, proposed_digest VARCHAR(71) NOT NULL,
 state VARCHAR(32) NOT NULL DEFAULT 'INACTIVE' CHECK(state IN ('INACTIVE','REVIEWING','APPROVED','REJECTED','WITHDRAWN')),
 approved_package_id UUID, decision_actor VARCHAR(255), decision_reason TEXT, decision_ts TIMESTAMPTZ, created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(host_id,proposal_id),
 FOREIGN KEY(host_id,approved_package_id) REFERENCES skill_package_t(host_id,package_id) ON DELETE RESTRICT, CHECK((state='APPROVED')=(approved_package_id IS NOT NULL)));
CREATE TABLE IF NOT EXISTS agent_turn_materialization_t (
 host_id UUID NOT NULL, turn_id UUID NOT NULL, materializer_id VARCHAR(126) NOT NULL, materializer_version INTEGER NOT NULL,
 product_profile VARCHAR(64) NOT NULL, manifest JSONB NOT NULL, manifest_digest VARCHAR(71) NOT NULL, created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY(host_id,turn_id), UNIQUE(host_id,turn_id,manifest_digest), FOREIGN KEY(host_id,turn_id) REFERENCES agent_turn_t(host_id,turn_id) ON DELETE CASCADE);
ALTER TABLE agent_turn_t ADD COLUMN IF NOT EXISTS scheduling_request_id UUID, ADD COLUMN IF NOT EXISTS execution_attempt_id UUID, ADD COLUMN IF NOT EXISTS materialization_manifest_digest VARCHAR(71), ADD COLUMN IF NOT EXISTS coding_base_revision VARCHAR(64), ADD COLUMN IF NOT EXISTS coding_patch_digest VARCHAR(71);
CREATE UNIQUE INDEX IF NOT EXISTS agent_turn_scheduling_request_uk ON agent_turn_t(host_id,scheduling_request_id) WHERE scheduling_request_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS agent_turn_execution_attempt_uk ON agent_turn_t(host_id,execution_attempt_id) WHERE execution_attempt_id IS NOT NULL;
ALTER TABLE runner_scheduling_request_t DROP CONSTRAINT IF EXISTS runner_scheduling_request_t_host_id_policy_snapshot_id_fkey;
CREATE OR REPLACE FUNCTION validate_runner_request_policy_snapshot_v1()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.origin_kind = 'workflow' THEN
        IF NOT EXISTS (SELECT 1 FROM workflow_execution_policy_t p WHERE p.host_id=NEW.host_id AND p.policy_snapshot_id=NEW.policy_snapshot_id AND p.policy_digest=NEW.policy_digest) THEN
            RAISE EXCEPTION 'workflow runner request policy snapshot is invalid';
        END IF;
    ELSIF NEW.origin_kind = 'agent' THEN
        IF NOT EXISTS (SELECT 1 FROM agent_policy_snapshot_t p WHERE p.host_id=NEW.host_id AND p.policy_snapshot_id=NEW.policy_snapshot_id AND p.policy_digest=NEW.policy_digest AND p.revoked_ts IS NULL) THEN
            RAISE EXCEPTION 'agent runner request policy snapshot is invalid or revoked';
        END IF;
    ELSE
        RAISE EXCEPTION 'unsupported runner request origin %', NEW.origin_kind;
    END IF;
    RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS runner_request_policy_snapshot_v1 ON runner_scheduling_request_t;
CREATE CONSTRAINT TRIGGER runner_request_policy_snapshot_v1 AFTER INSERT OR UPDATE OF origin_kind,host_id,policy_snapshot_id,policy_digest ON runner_scheduling_request_t DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION validate_runner_request_policy_snapshot_v1();
ALTER TABLE agent_turn_t DROP CONSTRAINT IF EXISTS agent_turn_scheduling_request_fk;
ALTER TABLE agent_turn_t ADD CONSTRAINT agent_turn_scheduling_request_fk FOREIGN KEY(host_id,scheduling_request_id) REFERENCES runner_scheduling_request_t(host_id,request_id) ON DELETE RESTRICT;
ALTER TABLE agent_turn_t DROP CONSTRAINT IF EXISTS agent_turn_execution_attempt_fk;
ALTER TABLE agent_turn_t ADD CONSTRAINT agent_turn_execution_attempt_fk FOREIGN KEY(host_id,execution_attempt_id) REFERENCES execution_attempt_t(host_id,execution_id) ON DELETE RESTRICT;

-- Light-Agent later profiles: session reuse, channels, workflow jobs, fixed actions.
ALTER TABLE agent_session_t ADD COLUMN IF NOT EXISTS workspace_compatibility JSONB, ADD COLUMN IF NOT EXISTS workspace_compatibility_digest VARCHAR(71), ADD COLUMN IF NOT EXISTS workspace_checkpoint_digest VARCHAR(71), ADD COLUMN IF NOT EXISTS workspace_effective_expires_ts TIMESTAMPTZ;
CREATE TABLE IF NOT EXISTS agent_channel_binding_t(host_id UUID NOT NULL,binding_id UUID NOT NULL,principal_id VARCHAR(255) NOT NULL,agent_def_id UUID NOT NULL,adapter_id VARCHAR(64) NOT NULL,external_identity VARCHAR(512) NOT NULL,allowed_destinations JSONB NOT NULL,group_allowed BOOLEAN NOT NULL DEFAULT FALSE,maximum_attachment_bytes BIGINT NOT NULL,quiet_hours JSONB NOT NULL,notification_policy JSONB NOT NULL,revoked_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,binding_id),UNIQUE(host_id,adapter_id,external_identity),FOREIGN KEY(host_id,agent_def_id) REFERENCES agent_definition_t(host_id,agent_def_id));
ALTER TABLE agent_channel_binding_t ADD CONSTRAINT agent_channel_binding_attachment_limit_ck CHECK(maximum_attachment_bytes>=0);
CREATE TABLE IF NOT EXISTS agent_channel_message_t(host_id UUID NOT NULL,message_id UUID NOT NULL,binding_id UUID NOT NULL,external_event_id VARCHAR(255) NOT NULL,response_destination VARCHAR(512) NOT NULL,direction VARCHAR(16) NOT NULL CHECK(direction IN('INBOUND','OUTBOUND')),payload_digest VARCHAR(71) NOT NULL,state VARCHAR(32) NOT NULL CHECK(state IN('RECEIVED','TURN_CREATED','PENDING_DELIVERY','DELIVERED','FAILED','REJECTED')),turn_id UUID,attempt_count INTEGER NOT NULL DEFAULT 0,next_attempt_ts TIMESTAMPTZ,receipt JSONB,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,message_id),UNIQUE(host_id,binding_id,external_event_id,direction),FOREIGN KEY(host_id,binding_id) REFERENCES agent_channel_binding_t(host_id,binding_id),FOREIGN KEY(host_id,turn_id) REFERENCES agent_turn_t(host_id,turn_id));
CREATE INDEX IF NOT EXISTS agent_channel_delivery_idx ON agent_channel_message_t(state,next_attempt_ts) WHERE state IN('PENDING_DELIVERY','FAILED');
ALTER TABLE agent_channel_message_t ADD COLUMN IF NOT EXISTS payload JSONB NOT NULL DEFAULT '{}'::jsonb, ADD COLUMN IF NOT EXISTS provider_receipt_id VARCHAR(255), ADD COLUMN IF NOT EXISTS last_error JSONB;
ALTER TABLE agent_channel_message_t DROP CONSTRAINT agent_channel_message_t_state_check;
ALTER TABLE agent_channel_message_t ADD CONSTRAINT agent_channel_message_t_state_check CHECK(state IN('RECEIVED','TURN_CREATED','PENDING_DELIVERY','SENDING','DELIVERED','FAILED','REJECTED'));
CREATE INDEX IF NOT EXISTS agent_channel_turn_result_idx ON agent_channel_message_t(host_id,turn_id,state) WHERE direction='INBOUND' AND state='TURN_CREATED';
ALTER TABLE agent_channel_message_t ADD COLUMN IF NOT EXISTS attachment_scan_state VARCHAR(16) NOT NULL DEFAULT 'NOT_REQUIRED',ADD COLUMN IF NOT EXISTS scan_claim_token UUID,ADD COLUMN IF NOT EXISTS scan_lease_expires_ts TIMESTAMPTZ,ADD COLUMN IF NOT EXISTS scan_attempt_count INTEGER NOT NULL DEFAULT 0,ADD COLUMN IF NOT EXISTS next_scan_attempt_ts TIMESTAMPTZ;
ALTER TABLE agent_channel_message_t ADD CONSTRAINT agent_channel_attachment_scan_state_ck CHECK(attachment_scan_state IN('NOT_REQUIRED','PENDING','CLAIMED','CLEAN','REJECTED') AND scan_attempt_count>=0 AND ((attachment_scan_state='CLAIMED' AND scan_claim_token IS NOT NULL AND scan_lease_expires_ts IS NOT NULL) OR (attachment_scan_state<>'CLAIMED' AND scan_claim_token IS NULL AND scan_lease_expires_ts IS NULL)));
CREATE INDEX IF NOT EXISTS agent_channel_attachment_scan_due_idx ON agent_channel_message_t(host_id,next_scan_attempt_ts,created_ts) WHERE direction='INBOUND' AND state='RECEIVED' AND attachment_scan_state IN('PENDING','CLAIMED');
CREATE TABLE IF NOT EXISTS agent_trigger_t(host_id UUID NOT NULL,trigger_id UUID NOT NULL,binding_id UUID NOT NULL,trigger_kind VARCHAR(32) NOT NULL CHECK(trigger_kind IN('SCHEDULE','CONNECTOR')),schedule_or_cursor JSONB NOT NULL,budget JSONB NOT NULL,maximum_delay_seconds INTEGER NOT NULL,state VARCHAR(16) NOT NULL CHECK(state IN('ACTIVE','PAUSED','REVOKED')),next_fire_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,trigger_id),FOREIGN KEY(host_id,binding_id) REFERENCES agent_channel_binding_t(host_id,binding_id));
CREATE TABLE IF NOT EXISTS agent_connector_grant_t(host_id UUID NOT NULL,grant_id UUID NOT NULL,binding_id UUID NOT NULL,connector_alias VARCHAR(126) NOT NULL,allowed_operations JSONB NOT NULL,data_boundary_digest VARCHAR(128) NOT NULL,credential_reference VARCHAR(255) NOT NULL,maximum_uses INTEGER NOT NULL CHECK(maximum_uses>0),use_count INTEGER NOT NULL DEFAULT 0 CHECK(use_count>=0),expires_ts TIMESTAMPTZ NOT NULL,revoked_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,grant_id),FOREIGN KEY(host_id,binding_id) REFERENCES agent_channel_binding_t(host_id,binding_id) ON DELETE CASCADE,CHECK(use_count<=maximum_uses));
CREATE INDEX IF NOT EXISTS agent_connector_grant_live_idx ON agent_connector_grant_t(host_id,binding_id,connector_alias,expires_ts) WHERE revoked_ts IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS agent_connector_grant_live_uk ON agent_connector_grant_t(host_id,binding_id,connector_alias) WHERE revoked_ts IS NULL;
ALTER TABLE agent_channel_message_t ADD COLUMN IF NOT EXISTS connector_grant_id UUID,ADD COLUMN IF NOT EXISTS connector_data_boundary_digest VARCHAR(128);
ALTER TABLE agent_channel_message_t ADD CONSTRAINT agent_channel_message_connector_grant_fk FOREIGN KEY(host_id,connector_grant_id) REFERENCES agent_connector_grant_t(host_id,grant_id) ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS agent_channel_connector_delivery_idx ON agent_channel_message_t(host_id,connector_grant_id,next_attempt_ts) WHERE direction='OUTBOUND' AND state IN('PENDING_DELIVERY','FAILED');
CREATE TABLE IF NOT EXISTS agent_channel_attachment_t(host_id UUID NOT NULL,attachment_id UUID NOT NULL,message_id UUID NOT NULL,external_file_id VARCHAR(255) NOT NULL,media_type VARCHAR(255) NOT NULL,size_bytes BIGINT NOT NULL CHECK(size_bytes>=0),content_digest VARCHAR(128) NOT NULL,immutable_reference TEXT NOT NULL,scanner_id VARCHAR(126) NOT NULL,scanner_receipt_digest VARCHAR(128) NOT NULL,scan_state VARCHAR(16) NOT NULL CHECK(scan_state IN('CLEAN','REJECTED','ERROR')),created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,attachment_id),UNIQUE(host_id,message_id,external_file_id),FOREIGN KEY(host_id,message_id) REFERENCES agent_channel_message_t(host_id,message_id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS agent_edge_runner_binding_t(host_id UUID NOT NULL,edge_binding_id UUID NOT NULL,principal_id VARCHAR(255) NOT NULL,runner_id VARCHAR(126) NOT NULL,backend_id VARCHAR(126) NOT NULL,execution_profile_id VARCHAR(126) NOT NULL,allowed_actions JSONB NOT NULL,required_capabilities JSONB NOT NULL,compatibility_digest VARCHAR(128) NOT NULL,expires_ts TIMESTAMPTZ NOT NULL,revoked_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,edge_binding_id),UNIQUE(host_id,principal_id,runner_id,backend_id));
ALTER TABLE agent_edge_runner_binding_t ADD COLUMN IF NOT EXISTS action_policies JSONB NOT NULL DEFAULT '{}'::jsonb;
ALTER TABLE agent_edge_runner_binding_t ADD CONSTRAINT agent_edge_runner_action_policies_ck CHECK(jsonb_typeof(action_policies)='object' AND NOT jsonb_path_exists(action_policies,'$.* ? (!exists(@.stableToolRef) || !exists(@.schemaDigest) || !exists(@.schema) || !exists(@.effectClass) || !exists(@.approvalRequired))'));
CREATE INDEX IF NOT EXISTS agent_edge_runner_action_policy_idx ON agent_edge_runner_binding_t USING GIN(action_policies jsonb_path_ops);
ALTER TABLE agent_trigger_t ADD COLUMN IF NOT EXISTS connector_grant_id UUID,ADD COLUMN IF NOT EXISTS last_fire_ts TIMESTAMPTZ,ADD COLUMN IF NOT EXISTS last_idempotency_key VARCHAR(255),ADD COLUMN IF NOT EXISTS timezone VARCHAR(64) NOT NULL DEFAULT 'UTC',ADD COLUMN IF NOT EXISTS fire_count BIGINT NOT NULL DEFAULT 0;
ALTER TABLE agent_trigger_t ADD CONSTRAINT agent_trigger_connector_grant_fk FOREIGN KEY(host_id,connector_grant_id) REFERENCES agent_connector_grant_t(host_id,grant_id) ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS agent_trigger_due_idx ON agent_trigger_t(host_id,next_fire_ts) WHERE state='ACTIVE';
ALTER TABLE agent_trigger_t ADD COLUMN IF NOT EXISTS misfire_policy VARCHAR(16) NOT NULL DEFAULT 'SKIP',ADD COLUMN IF NOT EXISTS maximum_catch_up_fires INTEGER NOT NULL DEFAULT 1,ADD COLUMN IF NOT EXISTS last_misfire_ts TIMESTAMPTZ,ADD COLUMN IF NOT EXISTS misfire_count BIGINT NOT NULL DEFAULT 0,ADD COLUMN IF NOT EXISTS skipped_fire_count BIGINT NOT NULL DEFAULT 0,ADD COLUMN IF NOT EXISTS last_error JSONB,ADD COLUMN IF NOT EXISTS updated_ts TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE agent_trigger_t ADD CONSTRAINT agent_trigger_runtime_policy_ck CHECK(misfire_policy IN('SKIP','FIRE_ONCE','CATCH_UP') AND maximum_catch_up_fires BETWEEN 1 AND 10 AND maximum_delay_seconds>=0 AND misfire_count>=0 AND skipped_fire_count>=0 AND jsonb_typeof(budget)='object');
CREATE TABLE IF NOT EXISTS agent_trigger_budget_usage_t(host_id UUID NOT NULL,trigger_id UUID NOT NULL,window_start_ts TIMESTAMPTZ NOT NULL,fire_count BIGINT NOT NULL DEFAULT 0,turn_count BIGINT NOT NULL DEFAULT 0,reserved_tokens BIGINT NOT NULL DEFAULT 0,reserved_cost_micros BIGINT NOT NULL DEFAULT 0,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,trigger_id,window_start_ts),CHECK(fire_count>=0 AND turn_count>=0 AND reserved_tokens>=0 AND reserved_cost_micros>=0));
ALTER TABLE agent_trigger_budget_usage_t ADD CONSTRAINT agent_trigger_budget_usage_trigger_fk FOREIGN KEY(host_id,trigger_id) REFERENCES agent_trigger_t(host_id,trigger_id) ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS agent_trigger_budget_retention_idx ON agent_trigger_budget_usage_t(host_id,window_start_ts);
ALTER TABLE runner_scheduling_request_t ADD CONSTRAINT runner_request_edge_binding_fk FOREIGN KEY(host_id,edge_binding_id) REFERENCES agent_edge_runner_binding_t(host_id,edge_binding_id) ON DELETE RESTRICT;
CREATE TABLE IF NOT EXISTS agent_job_t(host_id UUID NOT NULL,job_id UUID NOT NULL,workflow_process_id UUID NOT NULL,workflow_task_id UUID NOT NULL,agent_def_id UUID NOT NULL,turn_id UUID,idempotency_key VARCHAR(255) NOT NULL,input JSONB NOT NULL,input_schema_digest VARCHAR(71) NOT NULL,output_schema JSONB NOT NULL,policy_digest VARCHAR(71) NOT NULL,data_boundary_digest VARCHAR(71) NOT NULL,deadline_ts TIMESTAMPTZ NOT NULL,token_budget BIGINT NOT NULL,cost_budget_micros BIGINT NOT NULL,delegation_depth INTEGER NOT NULL,state VARCHAR(32) NOT NULL CHECK(state IN('PENDING','TURN_CREATED','RUNNING','SUCCEEDED','FAILED','CANCELLED','UNKNOWN')),public_output JSONB,error JSONB,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,job_id),UNIQUE(host_id,idempotency_key),FOREIGN KEY(host_id,turn_id) REFERENCES agent_turn_t(host_id,turn_id));
ALTER TABLE agent_job_t ADD COLUMN IF NOT EXISTS maximum_delegation_depth INTEGER NOT NULL DEFAULT 4, ADD COLUMN IF NOT EXISTS memory_mode VARCHAR(16) NOT NULL DEFAULT 'ISOLATED', ADD COLUMN IF NOT EXISTS cancellation_requested_ts TIMESTAMPTZ, ADD COLUMN IF NOT EXISTS terminal_ts TIMESTAMPTZ;
ALTER TABLE agent_job_t ADD CONSTRAINT agent_job_delegation_depth_ck CHECK(delegation_depth >= 0 AND maximum_delegation_depth >= 0 AND delegation_depth <= maximum_delegation_depth);
ALTER TABLE agent_job_t ADD CONSTRAINT agent_job_memory_mode_ck CHECK(memory_mode IN('ISOLATED','SESSION'));
CREATE UNIQUE INDEX IF NOT EXISTS agent_job_workflow_task_uk ON agent_job_t(host_id,workflow_process_id,workflow_task_id);
CREATE INDEX IF NOT EXISTS agent_job_pending_idx ON agent_job_t(state,deadline_ts) WHERE state IN('PENDING','TURN_CREATED','RUNNING');
CREATE TABLE IF NOT EXISTS agent_service_pool_t(host_id UUID NOT NULL,pool_id UUID NOT NULL,pool_name VARCHAR(126) NOT NULL,compatibility_dimensions JSONB NOT NULL,compatibility_digest VARCHAR(71) NOT NULL,enabled BOOLEAN NOT NULL DEFAULT TRUE,maximum_concurrency INTEGER NOT NULL CHECK(maximum_concurrency>0),created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,pool_id),UNIQUE(host_id,pool_name),UNIQUE(host_id,compatibility_digest));
CREATE TABLE IF NOT EXISTS agent_pool_assignment_t(host_id UUID NOT NULL,agent_def_id UUID NOT NULL,agent_definition_version BIGINT NOT NULL,policy_digest VARCHAR(71) NOT NULL,pool_id UUID NOT NULL,compatibility_digest VARCHAR(71) NOT NULL,revoked_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,agent_def_id,agent_definition_version,policy_digest),FOREIGN KEY(host_id,pool_id) REFERENCES agent_service_pool_t(host_id,pool_id) ON DELETE RESTRICT,FOREIGN KEY(host_id,agent_def_id) REFERENCES agent_definition_t(host_id,agent_def_id) ON DELETE RESTRICT);
CREATE INDEX IF NOT EXISTS agent_pool_assignment_live_idx ON agent_pool_assignment_t(host_id,pool_id) WHERE revoked_ts IS NULL;
CREATE TABLE IF NOT EXISTS agent_quota_policy_t(host_id UUID NOT NULL,quota_id UUID NOT NULL,scope_kind VARCHAR(16) NOT NULL CHECK(scope_kind IN('HOST','PRINCIPAL','AGENT','PROFILE','PROVIDER','POOL')),scope_key VARCHAR(255) NOT NULL,maximum_active_sessions INTEGER,maximum_queued_turns INTEGER,maximum_running_turns INTEGER,token_budget_per_window BIGINT,cost_budget_micros_per_window BIGINT,window_seconds INTEGER NOT NULL DEFAULT 60 CHECK(window_seconds BETWEEN 1 AND 86400),enabled BOOLEAN NOT NULL DEFAULT TRUE,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,quota_id),UNIQUE(host_id,scope_kind,scope_key));
ALTER TABLE agent_quota_policy_t ADD CONSTRAINT agent_quota_nonnegative_ck CHECK((maximum_active_sessions IS NULL OR maximum_active_sessions>=0) AND (maximum_queued_turns IS NULL OR maximum_queued_turns>=0) AND (maximum_running_turns IS NULL OR maximum_running_turns>=0) AND (token_budget_per_window IS NULL OR token_budget_per_window>=0) AND (cost_budget_micros_per_window IS NULL OR cost_budget_micros_per_window>=0));
CREATE TABLE IF NOT EXISTS agent_model_rate_t(host_id UUID NOT NULL,rate_id UUID NOT NULL,provider VARCHAR(64) NOT NULL,model VARCHAR(126) NOT NULL,input_cost_micros_per_million BIGINT NOT NULL CHECK(input_cost_micros_per_million>=0),output_cost_micros_per_million BIGINT NOT NULL CHECK(output_cost_micros_per_million>=0),effective_ts TIMESTAMPTZ NOT NULL,expires_ts TIMESTAMPTZ,enabled BOOLEAN NOT NULL DEFAULT TRUE,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,rate_id),FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,CHECK(expires_ts IS NULL OR expires_ts>effective_ts));
CREATE UNIQUE INDEX IF NOT EXISTS agent_model_rate_effective_uk ON agent_model_rate_t(host_id,provider,model,effective_ts);
CREATE INDEX IF NOT EXISTS agent_model_rate_lookup_idx ON agent_model_rate_t(host_id,provider,model,effective_ts DESC) WHERE enabled=TRUE;
ALTER TABLE agent_turn_t ADD COLUMN IF NOT EXISTS quota_input_cost_micros_per_million BIGINT NOT NULL DEFAULT 0,ADD COLUMN IF NOT EXISTS quota_output_cost_micros_per_million BIGINT NOT NULL DEFAULT 0;
ALTER TABLE agent_turn_t ADD CONSTRAINT agent_turn_quota_rates_nonnegative_ck CHECK(quota_input_cost_micros_per_million>=0 AND quota_output_cost_micros_per_million>=0);
CREATE TABLE IF NOT EXISTS agent_quota_usage_t(host_id UUID NOT NULL,quota_id UUID NOT NULL,window_start_ts TIMESTAMPTZ NOT NULL,reserved_tokens BIGINT NOT NULL DEFAULT 0,reserved_cost_micros BIGINT NOT NULL DEFAULT 0,consumed_tokens BIGINT NOT NULL DEFAULT 0,consumed_cost_micros BIGINT NOT NULL DEFAULT 0,updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,quota_id,window_start_ts),FOREIGN KEY(host_id,quota_id) REFERENCES agent_quota_policy_t(host_id,quota_id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS agent_quota_reservation_t(host_id UUID NOT NULL,quota_id UUID NOT NULL,turn_id UUID NOT NULL,window_start_ts TIMESTAMPTZ NOT NULL,reserved_tokens BIGINT NOT NULL DEFAULT 0,reserved_cost_micros BIGINT NOT NULL DEFAULT 0,actual_tokens BIGINT,actual_cost_micros BIGINT,accounting_source VARCHAR(32),usage_evidence_digest VARCHAR(71),reconciled_ts TIMESTAMPTZ,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,quota_id,turn_id),FOREIGN KEY(host_id,quota_id,window_start_ts) REFERENCES agent_quota_usage_t(host_id,quota_id,window_start_ts) ON DELETE CASCADE,FOREIGN KEY(host_id,turn_id) REFERENCES agent_turn_t(host_id,turn_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED);
ALTER TABLE agent_quota_reservation_t ADD CONSTRAINT agent_quota_reservation_accounting_source_ck CHECK(accounting_source IS NULL OR accounting_source IN('trusted-provider','runner-broker','reservation-ceiling','released-no-effect','legacy-unverified'));
ALTER TABLE agent_quota_reservation_t ADD CONSTRAINT agent_quota_reservation_reconciliation_evidence_ck CHECK((reconciled_ts IS NULL AND accounting_source IS NULL AND usage_evidence_digest IS NULL) OR (reconciled_ts IS NOT NULL AND accounting_source IS NOT NULL));
CREATE INDEX IF NOT EXISTS agent_quota_reservation_pending_idx ON agent_quota_reservation_t(host_id,turn_id) WHERE reconciled_ts IS NULL;
CREATE TABLE IF NOT EXISTS agent_delegation_replay_t(host_id UUID NOT NULL,audience VARCHAR(255) NOT NULL,replay_id UUID NOT NULL,token_id UUID NOT NULL,action_attempt_id UUID,issuer VARCHAR(255) NOT NULL,gateway_instance VARCHAR(255) NOT NULL,consumed_ts TIMESTAMPTZ NOT NULL DEFAULT now(),expires_ts TIMESTAMPTZ NOT NULL,PRIMARY KEY(audience,replay_id),CHECK(expires_ts > consumed_ts - interval '30 seconds'));
CREATE INDEX IF NOT EXISTS agent_delegation_replay_expiry_idx ON agent_delegation_replay_t(expires_ts);
ALTER TABLE agent_session_t ADD COLUMN IF NOT EXISTS service_pool_id UUID,ADD COLUMN IF NOT EXISTS service_pool_compatibility_digest VARCHAR(71);
ALTER TABLE agent_session_t ADD CONSTRAINT agent_session_service_pool_fk FOREIGN KEY(host_id,service_pool_id) REFERENCES agent_service_pool_t(host_id,pool_id) ON DELETE RESTRICT;
ALTER TABLE agent_turn_t ADD COLUMN IF NOT EXISTS service_pool_id UUID;
CREATE INDEX IF NOT EXISTS agent_session_pool_active_idx ON agent_session_t(host_id,service_pool_id,state) WHERE state='ACTIVE';
CREATE INDEX IF NOT EXISTS agent_turn_pool_queue_idx ON agent_turn_t(host_id,service_pool_id,state,queue_sequence) WHERE state IN('QUEUED','RECEIVED','RUNNING_MODEL','WAITING_ACTION','RUNNING_ACTION','WAITING_RECONCILIATION','WAITING_APPROVAL');
CREATE TABLE IF NOT EXISTS agent_fixed_action_t(host_id UUID NOT NULL,fixed_action_id UUID NOT NULL,action_kind VARCHAR(32) NOT NULL CHECK(action_kind IN('CREATE_BRANCH','OPEN_PR','PUSH_COMMIT','PUBLISH','SIGN','DEPLOY','SEND_EMAIL','CREATE_EVENT','PAYMENT')),subject_kind VARCHAR(32) NOT NULL,subject_id UUID NOT NULL,input_digest VARCHAR(71) NOT NULL,target_digest VARCHAR(71) NOT NULL,policy_digest VARCHAR(71) NOT NULL,provenance_digest VARCHAR(71) NOT NULL,approval_reference UUID NOT NULL,approval_nonce_digest VARCHAR(71) NOT NULL,approval_expires_ts TIMESTAMPTZ NOT NULL,state VARCHAR(32) NOT NULL CHECK(state IN('REQUESTED','VALIDATED','RUNNING','SUCCEEDED','FAILED','REJECTED','REVOKED')),credential_grant_id UUID,result_evidence JSONB,created_ts TIMESTAMPTZ NOT NULL DEFAULT now(),updated_ts TIMESTAMPTZ NOT NULL DEFAULT now(),PRIMARY KEY(host_id,fixed_action_id),UNIQUE(host_id,approval_nonce_digest));

BEGIN;

-- Event replay persistence is active by default. The reloadable enabled flag
-- pauses execution only; capture, planning, approval, and audit remain active.
-- Existing DLQ, notification, outbox, and consumer offset tables are retained.

CREATE TABLE IF NOT EXISTS event_failure_transaction_t (
    host_id                  UUID NOT NULL,
    failure_id               UUID NOT NULL,
    projection_name          VARCHAR(128) NOT NULL,
    consumer_group           VARCHAR(255) NOT NULL,
    first_source_processor   VARCHAR(16) NOT NULL,
    original_transaction_id  VARCHAR(255) NOT NULL,
    content_fingerprint      VARCHAR(64) NOT NULL,
    event_count              INTEGER NOT NULL,
    encrypted_payload_bytes  BIGINT NOT NULL DEFAULT 0,
    decrypted_payload_bytes  BIGINT NOT NULL DEFAULT 0,
    dependency_scopes        JSONB NOT NULL DEFAULT '[]'::jsonb,
    status                   VARCHAR(16) NOT NULL DEFAULT 'OPEN',
    error_type               VARCHAR(255),
    error_code               VARCHAR(128),
    error_message            VARCHAR(2048),
    failure_count            INTEGER NOT NULL DEFAULT 1,
    first_failed_ts          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_failed_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_ts              TIMESTAMPTZ,
    resolved_by_request_id   UUID,
    legal_hold               BOOLEAN NOT NULL DEFAULT FALSE,
    created_ts               TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts               TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_failure_transaction_pk PRIMARY KEY(host_id, failure_id),
    CONSTRAINT event_failure_transaction_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_failure_transaction_content_uk UNIQUE(
        host_id, projection_name, consumer_group, content_fingerprint
    ),
    CONSTRAINT event_failure_transaction_processor_ck CHECK(
        first_source_processor IN ('DATABASE', 'KAFKA')
    ),
    CONSTRAINT event_failure_transaction_fingerprint_ck CHECK(
        content_fingerprint ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_failure_transaction_counts_ck CHECK(
        event_count > 0 AND failure_count > 0
        AND encrypted_payload_bytes >= 0 AND decrypted_payload_bytes >= 0
    ),
    CONSTRAINT event_failure_transaction_scopes_ck CHECK(
        jsonb_typeof(dependency_scopes) = 'array'
    ),
    CONSTRAINT event_failure_transaction_status_ck CHECK(
        status IN ('OPEN', 'RESOLVED', 'WAIVED')
    ),
    CONSTRAINT event_failure_transaction_terminal_ck CHECK(
        (status = 'OPEN' AND resolved_ts IS NULL AND resolved_by_request_id IS NULL)
        OR (status = 'RESOLVED' AND resolved_ts IS NOT NULL AND resolved_by_request_id IS NOT NULL)
        OR (status = 'WAIVED' AND resolved_ts IS NOT NULL AND resolved_by_request_id IS NULL)
    ),
    CONSTRAINT event_failure_transaction_time_ck CHECK(
        last_failed_ts >= first_failed_ts
    )
);

CREATE TABLE IF NOT EXISTS event_failure_delivery_t (
    host_id                 UUID NOT NULL,
    delivery_id             UUID NOT NULL,
    failure_id              UUID NOT NULL,
    delivery_fingerprint    VARCHAR(64) NOT NULL,
    source_processor        VARCHAR(16) NOT NULL,
    source_coordinates      JSONB NOT NULL,
    observation_count       INTEGER NOT NULL DEFAULT 1,
    first_observed_ts       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_observed_ts        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_failure_delivery_pk PRIMARY KEY(host_id, delivery_id),
    CONSTRAINT event_failure_delivery_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_failure_delivery_fingerprint_uk UNIQUE(
        host_id, failure_id, delivery_fingerprint
    ),
    CONSTRAINT event_failure_delivery_fingerprint_ck CHECK(
        delivery_fingerprint ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_failure_delivery_processor_ck CHECK(
        source_processor IN ('DATABASE', 'KAFKA')
    ),
    CONSTRAINT event_failure_delivery_coordinates_ck CHECK(
        jsonb_typeof(source_coordinates) = 'object'
    ),
    CONSTRAINT event_failure_delivery_count_ck CHECK(observation_count > 0),
    CONSTRAINT event_failure_delivery_time_ck CHECK(last_observed_ts >= first_observed_ts)
);

CREATE TABLE IF NOT EXISTS event_failure_event_t (
    host_id                UUID NOT NULL,
    failure_id             UUID NOT NULL,
    event_ordinal          INTEGER NOT NULL,
    event_id               VARCHAR(255) NOT NULL,
    event_type             VARCHAR(255) NOT NULL,
    aggregate_id           VARCHAR(255),
    aggregate_type         VARCHAR(255),
    aggregate_version      BIGINT,
    root_instance_id       UUID,
    graph_revision         BIGINT,
    clone_request_id       UUID,
    source_processor       VARCHAR(16) NOT NULL,
    source_topic           VARCHAR(255),
    source_partition       INTEGER,
    source_offset          BIGINT NOT NULL,
    source_key             BYTEA,
    source_headers         JSONB NOT NULL DEFAULT '[]'::jsonb,
    payload_format         VARCHAR(32) NOT NULL,
    payload_digest         VARCHAR(64) NOT NULL,
    payload_storage        VARCHAR(16) NOT NULL,
    payload_ciphertext     BYTEA,
    payload_object_uri     VARCHAR(2048),
    payload_object_version VARCHAR(255),
    payload_key_id         VARCHAR(255),
    payload_wrapped_key    BYTEA,
    payload_iv             BYTEA,
    encrypted_payload_bytes BIGINT NOT NULL,
    decrypted_payload_bytes BIGINT NOT NULL,
    sensitive_payload      BOOLEAN NOT NULL DEFAULT FALSE,
    payload_deleted_ts     TIMESTAMPTZ,
    payload_deleted_reason VARCHAR(1024),
    created_ts             TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_failure_event_pk PRIMARY KEY(host_id, failure_id, event_ordinal),
    CONSTRAINT event_failure_event_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_failure_event_ordinal_ck CHECK(event_ordinal >= 0),
    CONSTRAINT event_failure_event_versions_ck CHECK(
        (aggregate_version IS NULL OR aggregate_version >= 0)
        AND (graph_revision IS NULL OR graph_revision >= 0)
    ),
    CONSTRAINT event_failure_event_processor_ck CHECK(
        source_processor IN ('DATABASE', 'KAFKA')
    ),
    CONSTRAINT event_failure_event_source_ck CHECK(
        source_offset >= 0 AND (source_partition IS NULL OR source_partition >= 0)
    ),
    CONSTRAINT event_failure_event_coordinates_ck CHECK(
        (source_processor = 'DATABASE' AND source_topic IS NULL AND source_partition IS NOT NULL)
        OR (source_processor = 'KAFKA' AND source_topic IS NOT NULL AND source_partition IS NOT NULL)
    ),
    CONSTRAINT event_failure_event_headers_ck CHECK(
        jsonb_typeof(source_headers) = 'array'
    ),
    CONSTRAINT event_failure_event_digest_ck CHECK(
        payload_digest ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_failure_event_payload_storage_ck CHECK(
        (payload_storage = 'DATABASE'
            AND payload_ciphertext IS NOT NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NOT NULL
            AND payload_wrapped_key IS NOT NULL
            AND payload_iv IS NOT NULL
            AND payload_deleted_ts IS NULL
            AND payload_deleted_reason IS NULL)
        OR (payload_storage = 'OBJECT'
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NOT NULL
            AND payload_object_version IS NOT NULL
            AND payload_key_id IS NOT NULL
            AND payload_wrapped_key IS NOT NULL
            AND payload_iv IS NOT NULL
            AND payload_deleted_ts IS NULL
            AND payload_deleted_reason IS NULL)
        OR (payload_storage = 'DELETED'
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NULL
            AND payload_wrapped_key IS NULL
            AND payload_iv IS NULL
            AND payload_deleted_ts IS NOT NULL
            AND length(btrim(payload_deleted_reason)) > 0)
    ),
    CONSTRAINT event_failure_event_crypto_ck CHECK(
        payload_storage = 'DELETED'
        OR (octet_length(payload_iv) = 12 AND octet_length(payload_wrapped_key) > 0)
    ),
    CONSTRAINT event_failure_event_bytes_ck CHECK(
        encrypted_payload_bytes >= 0 AND decrypted_payload_bytes >= 0
    )
);

CREATE TABLE IF NOT EXISTS event_replay_request_t (
    host_id                    UUID NOT NULL,
    replay_request_id          UUID NOT NULL,
    projection_name            VARCHAR(128) NOT NULL,
    consumer_group             VARCHAR(255) NOT NULL,
    selection_strategy         VARCHAR(32) NOT NULL,
    validation_mode            VARCHAR(32) NOT NULL,
    reason                     VARCHAR(2048) NOT NULL,
    plan_hash                  VARCHAR(64),
    policy_registry_version    VARCHAR(64) NOT NULL,
    plan_metadata              JSONB NOT NULL DEFAULT '{}'::jsonb,
    status                     VARCHAR(32) NOT NULL DEFAULT 'PLANNING',
    transaction_count          INTEGER NOT NULL DEFAULT 0,
    event_count                INTEGER NOT NULL DEFAULT 0,
    encrypted_payload_bytes    BIGINT NOT NULL DEFAULT 0,
    decrypted_payload_bytes    BIGINT NOT NULL DEFAULT 0,
    requested_by               VARCHAR(255) NOT NULL,
    requested_ts               TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_by                VARCHAR(255),
    approved_ts                TIMESTAMPTZ,
    started_by                 VARCHAR(255),
    started_ts                 TIMESTAMPTZ,
    completed_ts               TIMESTAMPTZ,
    expires_ts                 TIMESTAMPTZ NOT NULL,
    failure_code               VARCHAR(128),
    failure_message            VARCHAR(2048),
    fencing_token              BIGINT NOT NULL DEFAULT 0,
    isolation_mode             VARCHAR(32),
    installed_barrier_epoch    BIGINT,
    created_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_request_pk PRIMARY KEY(host_id, replay_request_id),
    CONSTRAINT event_replay_request_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_request_strategy_ck CHECK(
        selection_strategy IN ('EXACT', 'DEPENDENCY_CLOSURE')
    ),
    CONSTRAINT event_replay_request_mode_ck CHECK(
        validation_mode IN ('VALIDATE_ONLY', 'ROLLBACK_DRY_RUN', 'EXECUTE')
    ),
    CONSTRAINT event_replay_request_reason_ck CHECK(length(btrim(reason)) > 0),
    CONSTRAINT event_replay_request_plan_hash_ck CHECK(
        plan_hash IS NULL OR plan_hash ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_replay_request_metadata_ck CHECK(jsonb_typeof(plan_metadata) = 'object'),
    CONSTRAINT event_replay_request_status_ck CHECK(
        status IN ('PLANNING', 'READY', 'AWAITING_APPROVAL', 'APPROVED',
                   'INSTALLING_BARRIER', 'RUNNING', 'SUCCEEDED', 'FAILED',
                   'CANCELLED', 'EXPIRED')
    ),
    CONSTRAINT event_replay_request_counts_ck CHECK(
        transaction_count >= 0 AND event_count >= 0
        AND encrypted_payload_bytes >= 0 AND decrypted_payload_bytes >= 0
    ),
    CONSTRAINT event_replay_request_planned_ck CHECK(
        status = 'PLANNING'
        OR status = 'FAILED'
        OR (plan_hash IS NOT NULL AND transaction_count > 0 AND event_count > 0)
    ),
    CONSTRAINT event_replay_request_approval_ck CHECK(
        (approved_by IS NULL) = (approved_ts IS NULL)
        AND (status NOT IN ('APPROVED', 'INSTALLING_BARRIER', 'RUNNING', 'SUCCEEDED')
             OR approved_ts IS NOT NULL)
    ),
    CONSTRAINT event_replay_request_started_ck CHECK(
        (started_by IS NULL) = (started_ts IS NULL)
        AND (status NOT IN ('RUNNING', 'SUCCEEDED') OR started_ts IS NOT NULL)
    ),
    CONSTRAINT event_replay_request_completed_ck CHECK(
        (status IN ('SUCCEEDED', 'FAILED', 'CANCELLED', 'EXPIRED')) = (completed_ts IS NOT NULL)
    ),
    CONSTRAINT event_replay_request_expiry_ck CHECK(expires_ts > requested_ts),
    CONSTRAINT event_replay_request_fence_ck CHECK(
        fencing_token >= 0 AND (installed_barrier_epoch IS NULL OR installed_barrier_epoch > 0)
    ),
    CONSTRAINT event_replay_request_isolation_ck CHECK(
        isolation_mode IS NULL OR isolation_mode IN (
            'GRAPH_ROOT', 'AGGREGATE', 'HOST', 'DB_PARTITION',
            'KAFKA_PARTITION', 'PROJECTION'
        )
    )
);

ALTER TABLE event_failure_transaction_t
    DROP CONSTRAINT IF EXISTS event_failure_transaction_resolved_request_fk;
ALTER TABLE event_failure_transaction_t
    ADD CONSTRAINT event_failure_transaction_resolved_request_fk
    FOREIGN KEY(host_id, resolved_by_request_id)
    REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT;

CREATE TABLE IF NOT EXISTS event_replay_item_t (
    host_id                    UUID NOT NULL,
    replay_request_id          UUID NOT NULL,
    item_ordinal               INTEGER NOT NULL,
    failure_id                 UUID NOT NULL,
    expected_content_fingerprint VARCHAR(64) NOT NULL,
    dependency_reason          VARCHAR(1024) NOT NULL,
    added_dependency           BOOLEAN NOT NULL DEFAULT FALSE,
    status                     VARCHAR(16) NOT NULL DEFAULT 'PENDING',
    attempt_count              INTEGER NOT NULL DEFAULT 0,
    current_fencing_token      BIGINT NOT NULL DEFAULT 0,
    created_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_item_pk PRIMARY KEY(host_id, replay_request_id, item_ordinal),
    CONSTRAINT event_replay_item_request_fk FOREIGN KEY(host_id, replay_request_id)
        REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_item_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_item_failure_uk UNIQUE(host_id, replay_request_id, failure_id),
    CONSTRAINT event_replay_item_ordinal_ck CHECK(item_ordinal >= 0),
    CONSTRAINT event_replay_item_fingerprint_ck CHECK(
        expected_content_fingerprint ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_replay_item_reason_ck CHECK(length(btrim(dependency_reason)) > 0),
    CONSTRAINT event_replay_item_status_ck CHECK(
        status IN ('PENDING', 'RUNNING', 'SUCCEEDED', 'FAILED')
    ),
    CONSTRAINT event_replay_item_attempt_ck CHECK(
        attempt_count >= 0 AND current_fencing_token >= 0
    )
);

CREATE TABLE IF NOT EXISTS event_replay_attempt_t (
    host_id                    UUID NOT NULL,
    replay_attempt_id          UUID NOT NULL,
    replay_request_id          UUID NOT NULL,
    item_ordinal               INTEGER NOT NULL,
    attempt_number             INTEGER NOT NULL,
    worker_id                  VARCHAR(255) NOT NULL,
    fencing_token              BIGINT NOT NULL,
    started_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_ts               TIMESTAMPTZ,
    result                     VARCHAR(16) NOT NULL DEFAULT 'RUNNING',
    projection_committed       BOOLEAN NOT NULL DEFAULT FALSE,
    pre_projection_metadata    JSONB NOT NULL DEFAULT '{}'::jsonb,
    post_projection_metadata   JSONB NOT NULL DEFAULT '{}'::jsonb,
    error_code                 VARCHAR(128),
    error_message              VARCHAR(2048),
    created_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_attempt_pk PRIMARY KEY(host_id, replay_attempt_id),
    CONSTRAINT event_replay_attempt_item_fk FOREIGN KEY(host_id, replay_request_id, item_ordinal)
        REFERENCES event_replay_item_t(host_id, replay_request_id, item_ordinal) ON DELETE RESTRICT,
    CONSTRAINT event_replay_attempt_number_uk UNIQUE(
        host_id, replay_request_id, item_ordinal, attempt_number
    ),
    CONSTRAINT event_replay_attempt_number_ck CHECK(attempt_number > 0 AND fencing_token >= 0),
    CONSTRAINT event_replay_attempt_result_ck CHECK(
        result IN ('RUNNING', 'SUCCEEDED', 'FAILED', 'ABANDONED')
    ),
    CONSTRAINT event_replay_attempt_terminal_ck CHECK(
        (result = 'RUNNING' AND completed_ts IS NULL AND projection_committed = FALSE)
        OR (result <> 'RUNNING' AND completed_ts IS NOT NULL)
    ),
    CONSTRAINT event_replay_attempt_metadata_ck CHECK(
        jsonb_typeof(pre_projection_metadata) = 'object'
        AND jsonb_typeof(post_projection_metadata) = 'object'
    )
);

CREATE TABLE IF NOT EXISTS event_replay_lease_t (
    host_id              UUID NOT NULL,
    replay_request_id    UUID NOT NULL,
    lease_owner          VARCHAR(255) NOT NULL,
    lease_epoch          BIGINT NOT NULL,
    fencing_token        BIGINT NOT NULL,
    heartbeat_ts         TIMESTAMPTZ NOT NULL,
    expires_ts           TIMESTAMPTZ NOT NULL,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_lease_pk PRIMARY KEY(host_id, replay_request_id),
    CONSTRAINT event_replay_lease_request_fk FOREIGN KEY(host_id, replay_request_id)
        REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_lease_epoch_ck CHECK(lease_epoch > 0 AND fencing_token >= 0),
    CONSTRAINT event_replay_lease_time_ck CHECK(expires_ts > heartbeat_ts)
);

CREATE TABLE IF NOT EXISTS event_replay_barrier_t (
    host_id                UUID NOT NULL,
    barrier_id             UUID NOT NULL,
    projection_name        VARCHAR(128) NOT NULL,
    consumer_group         VARCHAR(255) NOT NULL,
    scope_type             VARCHAR(32) NOT NULL,
    scope_key              VARCHAR(1024) NOT NULL,
    state                  VARCHAR(16) NOT NULL,
    owner_type             VARCHAR(32) NOT NULL,
    replay_request_id      UUID,
    quarantine_failure_id  UUID,
    barrier_epoch          BIGINT NOT NULL,
    fencing_token          BIGINT NOT NULL DEFAULT 0,
    released_by            VARCHAR(255),
    release_reason         VARCHAR(2048),
    released_ts            TIMESTAMPTZ,
    installed_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts             TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_barrier_pk PRIMARY KEY(host_id, barrier_id),
    CONSTRAINT event_replay_barrier_request_fk FOREIGN KEY(host_id, replay_request_id)
        REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_barrier_failure_fk FOREIGN KEY(host_id, quarantine_failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_barrier_scope_ck CHECK(
        scope_type IN ('GRAPH_ROOT', 'AGGREGATE', 'HOST', 'DB_PARTITION',
                       'KAFKA_PARTITION', 'PROJECTION')
        AND length(btrim(scope_key)) > 0
    ),
    CONSTRAINT event_replay_barrier_state_ck CHECK(
        state IN ('INSTALLING', 'ACTIVE', 'DRAINING', 'QUARANTINED')
    ),
    CONSTRAINT event_replay_barrier_owner_ck CHECK(
        (owner_type = 'REPLAY_REQUEST'
            AND state <> 'QUARANTINED'
            AND replay_request_id IS NOT NULL
            AND quarantine_failure_id IS NULL)
        OR (owner_type = 'FAILURE_QUARANTINE'
            AND state = 'QUARANTINED'
            AND replay_request_id IS NULL
            AND quarantine_failure_id IS NOT NULL)
    ),
    CONSTRAINT event_replay_barrier_epoch_ck CHECK(barrier_epoch > 0 AND fencing_token >= 0),
    CONSTRAINT event_replay_barrier_release_ck CHECK(
        (released_ts IS NULL AND released_by IS NULL AND release_reason IS NULL)
        OR (released_ts IS NOT NULL AND released_by IS NOT NULL
            AND release_reason IS NOT NULL AND length(btrim(release_reason)) > 0)
    )
);

CREATE UNIQUE INDEX IF NOT EXISTS event_replay_barrier_active_scope_uk
    ON event_replay_barrier_t(host_id, projection_name, consumer_group, scope_type, scope_key)
    WHERE released_ts IS NULL;

CREATE TABLE IF NOT EXISTS event_projection_deferred_t (
    host_id                  UUID NOT NULL,
    deferred_id              UUID NOT NULL,
    barrier_id               UUID NOT NULL,
    failure_id               UUID,
    original_transaction_id  VARCHAR(255) NOT NULL,
    content_fingerprint      VARCHAR(64) NOT NULL,
    source_processor         VARCHAR(16) NOT NULL,
    source_order_key         VARCHAR(1024) NOT NULL,
    source_coordinates       JSONB NOT NULL,
    event_count              INTEGER NOT NULL,
    encrypted_payload_bytes  BIGINT NOT NULL,
    decrypted_payload_bytes  BIGINT NOT NULL,
    dependency_scopes        JSONB NOT NULL DEFAULT '[]'::jsonb,
    payload_digest           VARCHAR(64) NOT NULL,
    payload_storage          VARCHAR(16) NOT NULL,
    payload_plain            BYTEA,
    payload_ciphertext       BYTEA,
    payload_object_uri       VARCHAR(2048),
    payload_object_version   VARCHAR(255),
    payload_key_id           VARCHAR(255),
    payload_wrapped_key      BYTEA,
    payload_iv               BYTEA,
    status                   VARCHAR(16) NOT NULL DEFAULT 'PENDING',
    attempt_count            INTEGER NOT NULL DEFAULT 0,
    error_code               VARCHAR(128),
    error_message            VARCHAR(2048),
    deferred_ts              TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_ts             TIMESTAMPTZ,
    created_ts               TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts               TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_projection_deferred_pk PRIMARY KEY(host_id, deferred_id),
    CONSTRAINT event_projection_deferred_barrier_fk FOREIGN KEY(host_id, barrier_id)
        REFERENCES event_replay_barrier_t(host_id, barrier_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_deferred_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_deferred_order_uk UNIQUE(host_id, barrier_id, source_order_key),
    CONSTRAINT event_projection_deferred_content_uk UNIQUE(host_id, barrier_id, content_fingerprint),
    CONSTRAINT event_projection_deferred_fingerprint_ck CHECK(
        content_fingerprint ~ '^[0-9a-f]{64}$' AND payload_digest ~ '^[0-9a-f]{64}$'
    ),
    CONSTRAINT event_projection_deferred_processor_ck CHECK(
        source_processor IN ('DATABASE', 'KAFKA')
        AND jsonb_typeof(source_coordinates) = 'object'
    ),
    CONSTRAINT event_projection_deferred_counts_ck CHECK(
        event_count > 0 AND encrypted_payload_bytes >= 0
        AND decrypted_payload_bytes >= 0 AND attempt_count >= 0
        AND jsonb_typeof(dependency_scopes) = 'array'
    ),
    CONSTRAINT event_projection_deferred_payload_storage_ck CHECK(
        (payload_storage = 'DATABASE_PLAIN'
            AND payload_plain IS NOT NULL
            AND payload_digest = encode(sha256(payload_plain), 'hex')
            AND encrypted_payload_bytes = 0
            AND decrypted_payload_bytes = octet_length(payload_plain)
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NULL
            AND payload_wrapped_key IS NULL
            AND payload_iv IS NULL)
        OR (payload_storage = 'DATABASE'
            AND payload_plain IS NULL
            AND payload_ciphertext IS NOT NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL)
        OR (payload_storage = 'OBJECT'
            AND payload_plain IS NULL
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NOT NULL
            AND payload_object_version IS NOT NULL)
    ),
    CONSTRAINT event_projection_deferred_crypto_ck CHECK(
        payload_storage = 'DATABASE_PLAIN'
        OR (octet_length(payload_iv) = 12 AND octet_length(payload_wrapped_key) > 0
            AND length(btrim(payload_key_id)) > 0)
    ),
    CONSTRAINT event_projection_deferred_status_ck CHECK(
        status IN ('PENDING', 'RUNNING', 'SUCCEEDED', 'FAILED')
    ),
    CONSTRAINT event_projection_deferred_terminal_ck CHECK(
        (status IN ('PENDING', 'RUNNING') AND completed_ts IS NULL AND failure_id IS NULL)
        OR (status = 'SUCCEEDED' AND completed_ts IS NOT NULL AND failure_id IS NULL)
        OR (status = 'FAILED' AND completed_ts IS NOT NULL AND failure_id IS NOT NULL)
    )
);

CREATE TABLE IF NOT EXISTS event_projection_deferred_scope_t (
    host_id      UUID NOT NULL,
    deferred_id  UUID NOT NULL,
    barrier_id   UUID NOT NULL,
    created_ts   TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_projection_deferred_scope_pk PRIMARY KEY(host_id, deferred_id, barrier_id),
    CONSTRAINT event_projection_deferred_scope_deferred_fk FOREIGN KEY(host_id, deferred_id)
        REFERENCES event_projection_deferred_t(host_id, deferred_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_deferred_scope_barrier_fk FOREIGN KEY(host_id, barrier_id)
        REFERENCES event_replay_barrier_t(host_id, barrier_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS event_projection_control_t (
    host_id              UUID NOT NULL,
    control_id           UUID NOT NULL,
    projection_name      VARCHAR(128) NOT NULL,
    consumer_group       VARCHAR(255) NOT NULL,
    scope_type           VARCHAR(32) NOT NULL,
    scope_key            VARCHAR(1024) NOT NULL,
    requested_state      VARCHAR(32) NOT NULL,
    control_epoch        BIGINT NOT NULL,
    replay_request_id    UUID,
    acknowledgement_deadline_ts TIMESTAMPTZ,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_projection_control_pk PRIMARY KEY(host_id, control_id),
    CONSTRAINT event_projection_control_request_fk FOREIGN KEY(host_id, replay_request_id)
        REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_control_scope_uk UNIQUE(
        host_id, projection_name, consumer_group, scope_type, scope_key
    ),
    CONSTRAINT event_projection_control_scope_ck CHECK(
        scope_type IN ('HOST', 'DB_PARTITION', 'KAFKA_PARTITION', 'PROJECTION')
        AND length(btrim(scope_key)) > 0
    ),
    CONSTRAINT event_projection_control_state_ck CHECK(
        requested_state IN ('RUNNING', 'PAUSE_REQUESTED', 'PAUSED_FOR_REPLAY', 'RESUME_REQUESTED')
    ),
    CONSTRAINT event_projection_control_owner_ck CHECK(
        (requested_state = 'RUNNING' AND replay_request_id IS NULL)
        OR (requested_state <> 'RUNNING' AND replay_request_id IS NOT NULL)
    ),
    CONSTRAINT event_projection_control_epoch_ck CHECK(control_epoch >= 0)
);

CREATE TABLE IF NOT EXISTS event_projection_worker_t (
    host_id              UUID NOT NULL,
    worker_id            VARCHAR(255) NOT NULL,
    projection_name      VARCHAR(128) NOT NULL,
    consumer_group       VARCHAR(255) NOT NULL,
    source_processor     VARCHAR(16) NOT NULL,
    source_partition_key VARCHAR(512) NOT NULL,
    control_id           UUID,
    observed_epoch       BIGINT NOT NULL DEFAULT 0,
    acknowledged_epoch   BIGINT NOT NULL DEFAULT 0,
    state                VARCHAR(16) NOT NULL DEFAULT 'RUNNING',
    assignment_metadata  JSONB NOT NULL DEFAULT '{}'::jsonb,
    heartbeat_ts         TIMESTAMPTZ NOT NULL,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_projection_worker_pk PRIMARY KEY(host_id, worker_id),
    CONSTRAINT event_projection_worker_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_worker_control_fk FOREIGN KEY(host_id, control_id)
        REFERENCES event_projection_control_t(host_id, control_id) ON DELETE RESTRICT,
    CONSTRAINT event_projection_worker_assignment_uk UNIQUE(
        host_id, projection_name, consumer_group, source_processor, source_partition_key, worker_id
    ),
    CONSTRAINT event_projection_worker_processor_ck CHECK(
        source_processor IN ('DATABASE', 'KAFKA')
    ),
    CONSTRAINT event_projection_worker_epoch_ck CHECK(
        observed_epoch >= 0 AND acknowledged_epoch >= 0
        AND acknowledged_epoch <= observed_epoch
    ),
    CONSTRAINT event_projection_worker_state_ck CHECK(
        state IN ('RUNNING', 'PAUSING', 'PAUSED', 'STOPPED')
    ),
    CONSTRAINT event_projection_worker_control_state_ck CHECK(
        state NOT IN ('PAUSING', 'PAUSED') OR control_id IS NOT NULL
    ),
    CONSTRAINT event_projection_worker_metadata_ck CHECK(
        jsonb_typeof(assignment_metadata) = 'object'
    )
);

CREATE TABLE IF NOT EXISTS event_failure_publish_outbox_t (
    host_id              UUID NOT NULL,
    publication_id       UUID NOT NULL,
    failure_id           UUID NOT NULL,
    envelope_version     VARCHAR(64) NOT NULL,
    target_topic         VARCHAR(255) NOT NULL,
    status               VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    attempt_count        INTEGER NOT NULL DEFAULT 0,
    next_attempt_ts      TIMESTAMPTZ,
    first_error_ts       TIMESTAMPTZ,
    last_error_ts        TIMESTAMPTZ,
    error_code           VARCHAR(128),
    error_message        VARCHAR(2048),
    published_ts         TIMESTAMPTZ,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_failure_publish_outbox_pk PRIMARY KEY(host_id, publication_id),
    CONSTRAINT event_failure_publish_outbox_failure_topic_uq
        UNIQUE(host_id, failure_id, envelope_version, target_topic),
    CONSTRAINT event_failure_publish_outbox_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_failure_publish_outbox_status_ck CHECK(
        status IN ('PENDING', 'RETRY_WAIT', 'PUBLISHED', 'TERMINAL_FAILED')
    ),
    CONSTRAINT event_failure_publish_outbox_attempt_ck CHECK(attempt_count >= 0),
    CONSTRAINT event_failure_publish_outbox_retry_ck CHECK(
        (status = 'PENDING' AND next_attempt_ts IS NULL AND published_ts IS NULL)
        OR (status = 'RETRY_WAIT' AND next_attempt_ts IS NOT NULL AND published_ts IS NULL)
        OR (status = 'PUBLISHED' AND next_attempt_ts IS NULL AND published_ts IS NOT NULL)
        OR (status = 'TERMINAL_FAILED' AND next_attempt_ts IS NULL AND published_ts IS NULL)
    ),
    CONSTRAINT event_failure_publish_outbox_error_time_ck CHECK(
        (first_error_ts IS NULL AND last_error_ts IS NULL)
        OR (first_error_ts IS NOT NULL AND last_error_ts IS NOT NULL
            AND last_error_ts >= first_error_ts)
    )
);

CREATE TABLE IF NOT EXISTS event_replay_action_request_t (
    host_id              UUID NOT NULL,
    action_request_id    UUID NOT NULL,
    action_type          VARCHAR(32) NOT NULL,
    status               VARCHAR(32) NOT NULL DEFAULT 'AWAITING_APPROVAL',
    target_ids           JSONB NOT NULL,
    expected_state       JSONB NOT NULL,
    reason               VARCHAR(2048) NOT NULL,
    requested_by         VARCHAR(255) NOT NULL,
    requested_ts         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_by          VARCHAR(255),
    approved_ts          TIMESTAMPTZ,
    completed_ts         TIMESTAMPTZ,
    expires_ts           TIMESTAMPTZ NOT NULL,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_action_request_pk PRIMARY KEY(host_id, action_request_id),
    CONSTRAINT event_replay_action_request_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_action_request_type_ck CHECK(
        action_type IN ('WAIVE_FAILURES', 'RELEASE_WITH_GAP')
    ),
    CONSTRAINT event_replay_action_request_status_ck CHECK(
        status IN ('AWAITING_APPROVAL', 'COMPLETED', 'CANCELLED', 'EXPIRED')
    ),
    CONSTRAINT event_replay_action_request_json_ck CHECK(
        jsonb_typeof(target_ids) = 'array' AND jsonb_array_length(target_ids) > 0
        AND jsonb_typeof(expected_state) = 'object'
    ),
    CONSTRAINT event_replay_action_request_reason_ck CHECK(length(btrim(reason)) > 0),
    CONSTRAINT event_replay_action_request_approval_ck CHECK(
        (approved_by IS NULL) = (approved_ts IS NULL)
        AND (status <> 'COMPLETED' OR (approved_ts IS NOT NULL AND completed_ts IS NOT NULL))
    ),
    CONSTRAINT event_replay_action_request_expiry_ck CHECK(expires_ts > requested_ts)
);

CREATE TABLE IF NOT EXISTS event_replay_audit_t (
    host_id              UUID NOT NULL,
    audit_id             UUID NOT NULL,
    event_name           VARCHAR(128) NOT NULL,
    actor_type           VARCHAR(32) NOT NULL,
    actor_id             VARCHAR(255) NOT NULL,
    replay_request_id    UUID,
    failure_id           UUID,
    barrier_id           UUID,
    reason               VARCHAR(2048),
    details              JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_ts           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_audit_pk PRIMARY KEY(host_id, audit_id),
    CONSTRAINT event_replay_audit_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_audit_request_fk FOREIGN KEY(host_id, replay_request_id)
        REFERENCES event_replay_request_t(host_id, replay_request_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_audit_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_audit_barrier_fk FOREIGN KEY(host_id, barrier_id)
        REFERENCES event_replay_barrier_t(host_id, barrier_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_audit_actor_ck CHECK(
        actor_type IN ('USER', 'WORKER', 'SYSTEM') AND length(btrim(actor_id)) > 0
    ),
    CONSTRAINT event_replay_audit_reason_ck CHECK(
        reason IS NULL OR length(btrim(reason)) > 0
    ),
    CONSTRAINT event_replay_audit_details_ck CHECK(jsonb_typeof(details) = 'object')
);

CREATE TABLE IF NOT EXISTS event_replay_retention_log_t (
    host_id UUID, retention_id UUID NOT NULL, subject_type VARCHAR(32) NOT NULL,
    subject_id VARCHAR(255) NOT NULL, outcome VARCHAR(32) NOT NULL, reason VARCHAR(1024) NOT NULL,
    details JSONB NOT NULL DEFAULT '{}'::jsonb, created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_retention_log_pk PRIMARY KEY(retention_id),
    CONSTRAINT event_replay_retention_log_host_fk FOREIGN KEY(host_id)
        REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_retention_log_subject_ck CHECK(
        subject_type IN ('PAYLOAD','FAILURE_METADATA','REPLAY_METADATA','AUDIT','PUBLICATION_OUTBOX','OBJECT_RECONCILIATION')
        AND length(btrim(subject_id)) > 0),
    CONSTRAINT event_replay_retention_log_outcome_ck CHECK(
        outcome IN ('DELETED','SKIPPED_LEGAL_HOLD','SKIPPED_ACTIVE','FAILED','ORPHAN_DELETED')),
    CONSTRAINT event_replay_retention_log_reason_ck CHECK(length(btrim(reason)) > 0),
    CONSTRAINT event_replay_retention_log_details_ck CHECK(jsonb_typeof(details) = 'object')
);

CREATE OR REPLACE FUNCTION protect_event_replay_retention_log_v1()
RETURNS trigger LANGUAGE plpgsql AS $body$
BEGIN
    RAISE EXCEPTION 'event replay retention evidence is append-only';
END $body$;
CREATE TRIGGER event_replay_retention_log_append_guard_v1
BEFORE UPDATE OR DELETE ON event_replay_retention_log_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_retention_log_v1();

CREATE INDEX IF NOT EXISTS event_failure_open_age_idx
    ON event_failure_transaction_t(host_id, projection_name, consumer_group, last_failed_ts)
    WHERE status = 'OPEN';
CREATE INDEX IF NOT EXISTS event_failure_host_status_idx
    ON event_failure_transaction_t(host_id, status, last_failed_ts DESC);
CREATE INDEX IF NOT EXISTS event_failure_transaction_lookup_idx
    ON event_failure_transaction_t(host_id, original_transaction_id);
CREATE INDEX IF NOT EXISTS event_failure_dependency_scope_idx
    ON event_failure_transaction_t USING GIN(dependency_scopes);
CREATE INDEX IF NOT EXISTS event_failure_retention_idx
    ON event_failure_transaction_t(status, resolved_ts, last_failed_ts);
CREATE INDEX IF NOT EXISTS event_failure_payload_retention_idx
    ON event_failure_transaction_t(status, legal_hold, resolved_ts)
    WHERE status IN ('RESOLVED','WAIVED') AND legal_hold=FALSE;
CREATE INDEX IF NOT EXISTS event_replay_retention_log_created_idx
    ON event_replay_retention_log_t(created_ts);
CREATE INDEX IF NOT EXISTS event_failure_quota_idx
    ON event_failure_transaction_t(host_id, status, encrypted_payload_bytes);
CREATE INDEX IF NOT EXISTS event_failure_delivery_observed_idx
    ON event_failure_delivery_t(host_id, failure_id, last_observed_ts DESC);
CREATE INDEX IF NOT EXISTS event_failure_event_graph_idx
    ON event_failure_event_t(host_id, root_instance_id, graph_revision)
    WHERE root_instance_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS event_failure_event_aggregate_idx
    ON event_failure_event_t(host_id, aggregate_type, aggregate_id, aggregate_version)
    WHERE aggregate_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS event_failure_event_source_idx
    ON event_failure_event_t(source_processor, source_topic, source_partition, source_offset);
CREATE INDEX IF NOT EXISTS event_replay_request_status_idx
    ON event_replay_request_t(host_id, status, requested_ts DESC);
CREATE INDEX IF NOT EXISTS event_replay_request_expiry_idx
    ON event_replay_request_t(expires_ts)
    WHERE status IN ('READY', 'AWAITING_APPROVAL');
CREATE INDEX IF NOT EXISTS event_replay_request_retention_idx
    ON event_replay_request_t(status, completed_ts, created_ts);
CREATE INDEX IF NOT EXISTS event_replay_item_order_idx
    ON event_replay_item_t(host_id, replay_request_id, status, item_ordinal);
CREATE INDEX IF NOT EXISTS event_replay_attempt_history_idx
    ON event_replay_attempt_t(host_id, replay_request_id, item_ordinal, attempt_number DESC);
CREATE INDEX IF NOT EXISTS event_replay_attempt_retention_idx
    ON event_replay_attempt_t(result, completed_ts, created_ts);
CREATE INDEX IF NOT EXISTS event_replay_lease_expiry_idx
    ON event_replay_lease_t(expires_ts);
CREATE INDEX IF NOT EXISTS event_replay_barrier_scope_idx
    ON event_replay_barrier_t(host_id, projection_name, consumer_group, scope_type, scope_key, state)
    WHERE released_ts IS NULL;
CREATE INDEX IF NOT EXISTS event_replay_barrier_quarantine_idx
    ON event_replay_barrier_t(updated_ts)
    WHERE state = 'QUARANTINED' AND released_ts IS NULL;
CREATE INDEX IF NOT EXISTS event_replay_action_request_pending_idx
    ON event_replay_action_request_t(host_id, status, expires_ts)
    WHERE status = 'AWAITING_APPROVAL';
CREATE INDEX IF NOT EXISTS event_projection_deferred_drain_idx
    ON event_projection_deferred_t(host_id, barrier_id, status, source_order_key);
CREATE INDEX IF NOT EXISTS event_projection_deferred_retention_idx
    ON event_projection_deferred_t(status, completed_ts, deferred_ts);
CREATE INDEX IF NOT EXISTS event_projection_deferred_quota_idx
    ON event_projection_deferred_t(host_id, status, encrypted_payload_bytes);
CREATE INDEX IF NOT EXISTS event_projection_deferred_scope_barrier_idx
    ON event_projection_deferred_scope_t(host_id, barrier_id, deferred_id);
CREATE INDEX IF NOT EXISTS event_projection_control_scope_idx
    ON event_projection_control_t(host_id, projection_name, consumer_group, requested_state, control_epoch);
CREATE INDEX IF NOT EXISTS event_projection_worker_ack_idx
    ON event_projection_worker_t(host_id, projection_name, consumer_group, acknowledged_epoch, heartbeat_ts)
    WHERE state IN ('RUNNING', 'PAUSING', 'PAUSED');
CREATE INDEX IF NOT EXISTS event_failure_publish_retry_idx
    ON event_failure_publish_outbox_t(status, next_attempt_ts, created_ts)
    WHERE status IN ('PENDING', 'RETRY_WAIT');
CREATE UNIQUE INDEX IF NOT EXISTS event_failure_publish_active_uk
    ON event_failure_publish_outbox_t(host_id, failure_id, envelope_version)
    WHERE status IN ('PENDING', 'RETRY_WAIT');
CREATE INDEX IF NOT EXISTS event_failure_publish_retention_idx
    ON event_failure_publish_outbox_t(status, published_ts, updated_ts);
CREATE INDEX IF NOT EXISTS event_failure_publish_quota_idx
    ON event_failure_publish_outbox_t(host_id, status, created_ts);
CREATE INDEX IF NOT EXISTS event_replay_audit_subject_idx
    ON event_replay_audit_t(host_id, replay_request_id, failure_id, created_ts DESC);
CREATE INDEX IF NOT EXISTS event_replay_audit_retention_idx
    ON event_replay_audit_t(created_ts);

CREATE OR REPLACE FUNCTION validate_event_failure_members_v1()
RETURNS trigger LANGUAGE plpgsql AS '
DECLARE
    v_host UUID;
    v_failure UUID;
    v_expected INTEGER;
    v_count BIGINT;
    v_min INTEGER;
    v_max INTEGER;
BEGIN
    v_host := COALESCE(NEW.host_id, OLD.host_id);
    v_failure := COALESCE(NEW.failure_id, OLD.failure_id);
    SELECT event_count INTO v_expected
      FROM event_failure_transaction_t
     WHERE host_id = v_host AND failure_id = v_failure;
    IF NOT FOUND THEN
        RETURN NULL;
    END IF;
    SELECT count(*), min(event_ordinal), max(event_ordinal)
      INTO v_count, v_min, v_max
      FROM event_failure_event_t
     WHERE host_id = v_host AND failure_id = v_failure;
    IF v_count <> v_expected OR v_min <> 0 OR v_max <> v_expected - 1 THEN
        RAISE EXCEPTION ''failure transaction %/% must contain contiguous ordinals 0..%, found count %, min %, max %'',
            v_host, v_failure, v_expected - 1, v_count, v_min, v_max;
    END IF;
    RETURN NULL;
END ';

DROP TRIGGER IF EXISTS event_failure_transaction_members_v1 ON event_failure_transaction_t;
CREATE CONSTRAINT TRIGGER event_failure_transaction_members_v1
AFTER INSERT OR UPDATE OF event_count ON event_failure_transaction_t
DEFERRABLE INITIALLY DEFERRED FOR EACH ROW
EXECUTE FUNCTION validate_event_failure_members_v1();

DROP TRIGGER IF EXISTS event_failure_event_members_v1 ON event_failure_event_t;
CREATE CONSTRAINT TRIGGER event_failure_event_members_v1
AFTER INSERT OR UPDATE OR DELETE ON event_failure_event_t
DEFERRABLE INITIALLY DEFERRED FOR EACH ROW
EXECUTE FUNCTION validate_event_failure_members_v1();

CREATE OR REPLACE FUNCTION protect_event_failure_identity_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.projection_name IS DISTINCT FROM OLD.projection_name
       OR NEW.consumer_group IS DISTINCT FROM OLD.consumer_group
       OR NEW.first_source_processor IS DISTINCT FROM OLD.first_source_processor
       OR NEW.original_transaction_id IS DISTINCT FROM OLD.original_transaction_id
       OR NEW.content_fingerprint IS DISTINCT FROM OLD.content_fingerprint
       OR NEW.event_count IS DISTINCT FROM OLD.event_count
       OR NEW.encrypted_payload_bytes IS DISTINCT FROM OLD.encrypted_payload_bytes
       OR NEW.decrypted_payload_bytes IS DISTINCT FROM OLD.decrypted_payload_bytes
       OR NEW.dependency_scopes IS DISTINCT FROM OLD.dependency_scopes
       OR NEW.first_failed_ts IS DISTINCT FROM OLD.first_failed_ts
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts
       OR NEW.failure_count < OLD.failure_count
       OR NEW.last_failed_ts < OLD.last_failed_ts THEN
        RAISE EXCEPTION ''canonical failure identity is immutable'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_failure_identity_guard_v1 ON event_failure_transaction_t;
CREATE TRIGGER event_failure_identity_guard_v1
BEFORE UPDATE ON event_failure_transaction_t
FOR EACH ROW EXECUTE FUNCTION protect_event_failure_identity_v1();

CREATE OR REPLACE FUNCTION event_replay_retention_delete_enabled_v1()
RETURNS boolean LANGUAGE sql STABLE AS '
    SELECT COALESCE(current_setting(''lightapi.event_replay_retention'', TRUE), '''') = ''on''
';

CREATE OR REPLACE FUNCTION protect_event_failure_event_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP = ''DELETE'' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    IF TG_OP = ''DELETE'' THEN
        RAISE EXCEPTION ''archived failure event rows are immutable'';
    END IF;
    IF OLD.payload_storage = ''DELETED''
       OR NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.event_ordinal IS DISTINCT FROM OLD.event_ordinal
       OR NEW.event_id IS DISTINCT FROM OLD.event_id
       OR NEW.event_type IS DISTINCT FROM OLD.event_type
       OR NEW.aggregate_id IS DISTINCT FROM OLD.aggregate_id
       OR NEW.aggregate_type IS DISTINCT FROM OLD.aggregate_type
       OR NEW.aggregate_version IS DISTINCT FROM OLD.aggregate_version
       OR NEW.root_instance_id IS DISTINCT FROM OLD.root_instance_id
       OR NEW.graph_revision IS DISTINCT FROM OLD.graph_revision
       OR NEW.clone_request_id IS DISTINCT FROM OLD.clone_request_id
       OR NEW.source_processor IS DISTINCT FROM OLD.source_processor
       OR NEW.source_topic IS DISTINCT FROM OLD.source_topic
       OR NEW.source_partition IS DISTINCT FROM OLD.source_partition
       OR NEW.source_offset IS DISTINCT FROM OLD.source_offset
       OR NEW.source_key IS DISTINCT FROM OLD.source_key
       OR NEW.source_headers IS DISTINCT FROM OLD.source_headers
       OR NEW.payload_format IS DISTINCT FROM OLD.payload_format
       OR NEW.payload_digest IS DISTINCT FROM OLD.payload_digest
       OR NEW.encrypted_payload_bytes IS DISTINCT FROM OLD.encrypted_payload_bytes
       OR NEW.decrypted_payload_bytes IS DISTINCT FROM OLD.decrypted_payload_bytes
       OR NEW.sensitive_payload IS DISTINCT FROM OLD.sensitive_payload
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts
       OR NEW.payload_storage <> ''DELETED''
       OR NEW.payload_ciphertext IS NOT NULL
       OR NEW.payload_object_uri IS NOT NULL
       OR NEW.payload_object_version IS NOT NULL
       OR NEW.payload_key_id IS NOT NULL
       OR NEW.payload_wrapped_key IS NOT NULL
       OR NEW.payload_iv IS NOT NULL
       OR NEW.payload_deleted_ts IS NULL
       OR NEW.payload_deleted_reason IS NULL
       OR length(btrim(NEW.payload_deleted_reason)) = 0 THEN
        RAISE EXCEPTION ''archived failure event rows are immutable except payload deletion'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_failure_event_guard_v1 ON event_failure_event_t;
CREATE TRIGGER event_failure_event_guard_v1
BEFORE UPDATE OR DELETE ON event_failure_event_t
FOR EACH ROW EXECUTE FUNCTION protect_event_failure_event_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_item_plan_v1()
RETURNS trigger LANGUAGE plpgsql AS '
DECLARE
    v_host UUID;
    v_request UUID;
    v_status VARCHAR(32);
BEGIN
    IF TG_OP = ''DELETE'' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    v_host := COALESCE(NEW.host_id, OLD.host_id);
    v_request := COALESCE(NEW.replay_request_id, OLD.replay_request_id);
    SELECT status INTO v_status
      FROM event_replay_request_t
     WHERE host_id = v_host AND replay_request_id = v_request;
    IF v_status <> ''PLANNING'' THEN
        IF TG_OP IN (''INSERT'', ''DELETE'') THEN
            RAISE EXCEPTION ''completed replay plan items are immutable'';
        END IF;
        IF NEW.host_id IS DISTINCT FROM OLD.host_id
           OR NEW.replay_request_id IS DISTINCT FROM OLD.replay_request_id
           OR NEW.item_ordinal IS DISTINCT FROM OLD.item_ordinal
           OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
           OR NEW.expected_content_fingerprint IS DISTINCT FROM OLD.expected_content_fingerprint
           OR NEW.repair_id IS DISTINCT FROM OLD.repair_id
           OR NEW.dependency_reason IS DISTINCT FROM OLD.dependency_reason
           OR NEW.added_dependency IS DISTINCT FROM OLD.added_dependency THEN
            RAISE EXCEPTION ''completed replay plan definition is immutable'';
        END IF;
    END IF;
    IF TG_OP = ''DELETE'' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    IF TG_OP = ''DELETE'' THEN
        RETURN OLD;
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_replay_item_plan_guard_v1 ON event_replay_item_t;
CREATE TRIGGER event_replay_item_plan_guard_v1
BEFORE INSERT OR UPDATE OR DELETE ON event_replay_item_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_item_plan_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_request_plan_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF OLD.status <> ''PLANNING'' AND (
       NEW.host_id IS DISTINCT FROM OLD.host_id OR NEW.replay_request_id IS DISTINCT FROM OLD.replay_request_id
       OR NEW.projection_name IS DISTINCT FROM OLD.projection_name OR NEW.consumer_group IS DISTINCT FROM OLD.consumer_group
       OR NEW.selection_strategy IS DISTINCT FROM OLD.selection_strategy OR NEW.validation_mode IS DISTINCT FROM OLD.validation_mode
       OR NEW.reason IS DISTINCT FROM OLD.reason OR NEW.plan_hash IS DISTINCT FROM OLD.plan_hash
       OR NEW.repair_schema_version IS DISTINCT FROM OLD.repair_schema_version
       OR NEW.policy_registry_version IS DISTINCT FROM OLD.policy_registry_version OR NEW.plan_metadata IS DISTINCT FROM OLD.plan_metadata
       OR NEW.transaction_count IS DISTINCT FROM OLD.transaction_count OR NEW.event_count IS DISTINCT FROM OLD.event_count
       OR NEW.encrypted_payload_bytes IS DISTINCT FROM OLD.encrypted_payload_bytes OR NEW.decrypted_payload_bytes IS DISTINCT FROM OLD.decrypted_payload_bytes
       OR NEW.requested_by IS DISTINCT FROM OLD.requested_by OR NEW.requested_ts IS DISTINCT FROM OLD.requested_ts
       OR NEW.expires_ts IS DISTINCT FROM OLD.expires_ts OR NEW.isolation_mode IS DISTINCT FROM OLD.isolation_mode) THEN
        RAISE EXCEPTION ''completed replay plan definition is immutable'';
    END IF;
    RETURN NEW;
END ';
DROP TRIGGER IF EXISTS event_replay_request_plan_guard_v1 ON event_replay_request_t;
CREATE TRIGGER event_replay_request_plan_guard_v1 BEFORE UPDATE ON event_replay_request_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_request_plan_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_attempt_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP = ''DELETE'' THEN
        IF event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
        RAISE EXCEPTION ''replay attempts are append-only'';
    END IF;
    IF NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.replay_attempt_id IS DISTINCT FROM OLD.replay_attempt_id
       OR NEW.replay_request_id IS DISTINCT FROM OLD.replay_request_id
       OR NEW.item_ordinal IS DISTINCT FROM OLD.item_ordinal
       OR NEW.attempt_number IS DISTINCT FROM OLD.attempt_number
       OR NEW.worker_id IS DISTINCT FROM OLD.worker_id
       OR NEW.fencing_token IS DISTINCT FROM OLD.fencing_token
       OR NEW.started_ts IS DISTINCT FROM OLD.started_ts
       OR NEW.pre_projection_metadata IS DISTINCT FROM OLD.pre_projection_metadata
       OR OLD.result <> ''RUNNING''
       OR NEW.result NOT IN (''SUCCEEDED'', ''FAILED'', ''ABANDONED'')
       OR NEW.completed_ts IS NULL THEN
        RAISE EXCEPTION ''replay attempt identity/history is immutable'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_replay_attempt_append_guard_v1 ON event_replay_attempt_t;
CREATE TRIGGER event_replay_attempt_append_guard_v1
BEFORE UPDATE OR DELETE ON event_replay_attempt_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_attempt_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_monotonic_v1()
RETURNS trigger LANGUAGE plpgsql AS '
DECLARE
    v_new JSONB := to_jsonb(NEW);
    v_old JSONB := to_jsonb(OLD);
BEGIN
    IF TG_TABLE_NAME = ''event_replay_request_t''
       AND (v_new->>''fencing_token'')::BIGINT < (v_old->>''fencing_token'')::BIGINT THEN
        RAISE EXCEPTION ''replay request fencing token cannot decrease'';
    ELSIF TG_TABLE_NAME = ''event_replay_item_t''
       AND ((v_new->>''current_fencing_token'')::BIGINT < (v_old->>''current_fencing_token'')::BIGINT
            OR (v_new->>''attempt_count'')::INTEGER < (v_old->>''attempt_count'')::INTEGER) THEN
        RAISE EXCEPTION ''replay item fencing or attempt count cannot decrease'';
    ELSIF TG_TABLE_NAME = ''event_replay_lease_t''
       AND ((v_new->>''lease_epoch'')::BIGINT < (v_old->>''lease_epoch'')::BIGINT
            OR (v_new->>''fencing_token'')::BIGINT < (v_old->>''fencing_token'')::BIGINT) THEN
        RAISE EXCEPTION ''replay lease epoch or fencing token cannot decrease'';
    ELSIF TG_TABLE_NAME = ''event_replay_barrier_t''
       AND ((v_new->>''barrier_epoch'')::BIGINT < (v_old->>''barrier_epoch'')::BIGINT
            OR (v_new->>''fencing_token'')::BIGINT < (v_old->>''fencing_token'')::BIGINT) THEN
        RAISE EXCEPTION ''replay barrier epoch or fencing token cannot decrease'';
    ELSIF TG_TABLE_NAME = ''event_projection_control_t''
       AND (v_new->>''control_epoch'')::BIGINT < (v_old->>''control_epoch'')::BIGINT THEN
        RAISE EXCEPTION ''projection control epoch cannot decrease'';
    ELSIF TG_TABLE_NAME = ''event_projection_worker_t''
       AND ((v_new->>''observed_epoch'')::BIGINT < (v_old->>''observed_epoch'')::BIGINT
            OR (v_new->>''acknowledged_epoch'')::BIGINT < (v_old->>''acknowledged_epoch'')::BIGINT) THEN
        RAISE EXCEPTION ''projection worker epochs cannot decrease'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_replay_request_monotonic_v1 ON event_replay_request_t;
CREATE TRIGGER event_replay_request_monotonic_v1 BEFORE UPDATE ON event_replay_request_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();
DROP TRIGGER IF EXISTS event_replay_item_monotonic_v1 ON event_replay_item_t;
CREATE TRIGGER event_replay_item_monotonic_v1 BEFORE UPDATE ON event_replay_item_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();
DROP TRIGGER IF EXISTS event_replay_lease_monotonic_v1 ON event_replay_lease_t;
CREATE TRIGGER event_replay_lease_monotonic_v1 BEFORE UPDATE ON event_replay_lease_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();
DROP TRIGGER IF EXISTS event_replay_barrier_monotonic_v1 ON event_replay_barrier_t;
CREATE TRIGGER event_replay_barrier_monotonic_v1 BEFORE UPDATE ON event_replay_barrier_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();
DROP TRIGGER IF EXISTS event_projection_control_monotonic_v1 ON event_projection_control_t;
CREATE TRIGGER event_projection_control_monotonic_v1 BEFORE UPDATE ON event_projection_control_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();
DROP TRIGGER IF EXISTS event_projection_worker_monotonic_v1 ON event_projection_worker_t;
CREATE TRIGGER event_projection_worker_monotonic_v1 BEFORE UPDATE ON event_projection_worker_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_monotonic_v1();

CREATE OR REPLACE FUNCTION protect_event_failure_publish_outbox_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.publication_id IS DISTINCT FROM OLD.publication_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.envelope_version IS DISTINCT FROM OLD.envelope_version
       OR NEW.target_topic IS DISTINCT FROM OLD.target_topic
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts THEN
        RAISE EXCEPTION ''failure publication envelope identity is immutable'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_failure_publish_outbox_identity_guard_v1
    ON event_failure_publish_outbox_t;
CREATE TRIGGER event_failure_publish_outbox_identity_guard_v1
BEFORE UPDATE ON event_failure_publish_outbox_t
FOR EACH ROW EXECUTE FUNCTION protect_event_failure_publish_outbox_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_audit_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP = ''DELETE'' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    RAISE EXCEPTION ''event replay audit rows are append-only'';
END ';

DROP TRIGGER IF EXISTS event_replay_audit_append_guard_v1 ON event_replay_audit_t;
CREATE TRIGGER event_replay_audit_append_guard_v1
BEFORE UPDATE OR DELETE ON event_replay_audit_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_audit_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_action_request_v1()
RETURNS trigger LANGUAGE plpgsql AS $body$
BEGIN
    IF TG_OP = 'DELETE' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    IF TG_OP = 'DELETE' OR NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.action_request_id IS DISTINCT FROM OLD.action_request_id
       OR NEW.action_type IS DISTINCT FROM OLD.action_type
       OR NEW.target_ids IS DISTINCT FROM OLD.target_ids
       OR NEW.expected_state IS DISTINCT FROM OLD.expected_state
       OR NEW.reason IS DISTINCT FROM OLD.reason
       OR NEW.requested_by IS DISTINCT FROM OLD.requested_by
       OR NEW.requested_ts IS DISTINCT FROM OLD.requested_ts
       OR NEW.expires_ts IS DISTINCT FROM OLD.expires_ts
       OR OLD.status <> 'AWAITING_APPROVAL'
       OR NEW.status NOT IN ('COMPLETED', 'CANCELLED', 'EXPIRED') THEN
        RAISE EXCEPTION 'event replay operator action history is immutable';
    END IF;
    RETURN NEW;
END $body$;
DROP TRIGGER IF EXISTS event_replay_action_request_guard_v1 ON event_replay_action_request_t;
CREATE TRIGGER event_replay_action_request_guard_v1
BEFORE UPDATE OR DELETE ON event_replay_action_request_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_action_request_v1();

CREATE OR REPLACE FUNCTION protect_event_replay_barrier_release_v1()
RETURNS trigger LANGUAGE plpgsql AS $body$
BEGIN
    IF OLD.released_ts IS NOT NULL AND (
       NEW.released_ts IS DISTINCT FROM OLD.released_ts
       OR NEW.released_by IS DISTINCT FROM OLD.released_by
       OR NEW.release_reason IS DISTINCT FROM OLD.release_reason) THEN
        RAISE EXCEPTION 'released replay barrier evidence is immutable';
    END IF;
    RETURN NEW;
END $body$;
DROP TRIGGER IF EXISTS event_replay_barrier_release_guard_v1 ON event_replay_barrier_t;
CREATE TRIGGER event_replay_barrier_release_guard_v1
BEFORE UPDATE ON event_replay_barrier_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_barrier_release_v1();


-- Event replay redesign R1: additive repair persistence and immutable
-- database-plain payload bytes. Existing encrypted/object rows remain valid.

ALTER TABLE event_store_t
    ADD COLUMN IF NOT EXISTS policy_registry_version VARCHAR(64)
        NOT NULL DEFAULT 'event-replay-policy-v1',
    ADD COLUMN IF NOT EXISTS repair_schema_version VARCHAR(64);
ALTER TABLE event_store_t
    DROP CONSTRAINT IF EXISTS event_store_replay_versions_v2_ck,
    ADD CONSTRAINT event_store_replay_versions_v2_ck CHECK(
        length(btrim(policy_registry_version)) > 0
        AND (repair_schema_version IS NULL OR length(btrim(repair_schema_version)) > 0)
    ) NOT VALID;

ALTER TABLE outbox_message_t
    ADD COLUMN IF NOT EXISTS policy_registry_version VARCHAR(64)
        NOT NULL DEFAULT 'event-replay-policy-v1',
    ADD COLUMN IF NOT EXISTS repair_schema_version VARCHAR(64);
ALTER TABLE outbox_message_t
    DROP CONSTRAINT IF EXISTS outbox_message_replay_versions_v2_ck,
    ADD CONSTRAINT outbox_message_replay_versions_v2_ck CHECK(
        length(btrim(policy_registry_version)) > 0
        AND (repair_schema_version IS NULL OR length(btrim(repair_schema_version)) > 0)
    ) NOT VALID;

ALTER TABLE event_store_t VALIDATE CONSTRAINT event_store_replay_versions_v2_ck;
ALTER TABLE outbox_message_t VALIDATE CONSTRAINT outbox_message_replay_versions_v2_ck;

ALTER TABLE event_failure_transaction_t
    ADD COLUMN IF NOT EXISTS policy_registry_version VARCHAR(64)
        NOT NULL DEFAULT 'event-replay-policy-v1',
    ADD COLUMN IF NOT EXISTS resolution_code VARCHAR(64),
    ADD COLUMN IF NOT EXISTS resolved_by_repair_id UUID;
ALTER TABLE event_failure_transaction_t
    DROP CONSTRAINT IF EXISTS event_failure_transaction_policy_version_v2_ck,
    DROP CONSTRAINT IF EXISTS event_failure_transaction_resolution_v2_ck,
    ADD CONSTRAINT event_failure_transaction_policy_version_v2_ck CHECK(
        length(btrim(policy_registry_version)) > 0
    ),
    ADD CONSTRAINT event_failure_transaction_resolution_v2_ck CHECK(
        (resolution_code IS NULL AND resolved_by_repair_id IS NULL)
        OR (status = 'RESOLVED'
            AND resolution_code = 'RESOLVED_BY_EXACT_REPLAY'
            AND resolved_by_repair_id IS NULL)
        OR (status = 'RESOLVED'
            AND resolution_code = 'RESOLVED_BY_REPAIR'
            AND resolved_by_repair_id IS NOT NULL)
    );

ALTER TABLE event_failure_event_t
    ADD COLUMN IF NOT EXISTS payload_plain BYTEA,
    ADD COLUMN IF NOT EXISTS event_schema_version VARCHAR(64),
    ADD COLUMN IF NOT EXISTS policy_registry_version VARCHAR(64)
        NOT NULL DEFAULT 'event-replay-policy-v1',
    ADD COLUMN IF NOT EXISTS repair_schema_version VARCHAR(64);
ALTER TABLE event_failure_event_t
    DROP CONSTRAINT IF EXISTS event_failure_event_payload_storage_ck,
    DROP CONSTRAINT IF EXISTS event_failure_event_crypto_ck,
    DROP CONSTRAINT IF EXISTS event_failure_event_bytes_ck,
    DROP CONSTRAINT IF EXISTS event_failure_event_versions_v2_ck,
    ADD CONSTRAINT event_failure_event_payload_storage_ck CHECK(
        (payload_storage = 'DATABASE_PLAIN'
            AND payload_plain IS NOT NULL
            AND octet_length(payload_plain) > 0
            AND payload_digest = encode(sha256(payload_plain), 'hex')
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NULL
            AND payload_wrapped_key IS NULL
            AND payload_iv IS NULL
            AND payload_deleted_ts IS NULL
            AND payload_deleted_reason IS NULL)
        OR (payload_storage = 'DATABASE'
            AND payload_plain IS NULL
            AND payload_ciphertext IS NOT NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NOT NULL
            AND payload_wrapped_key IS NOT NULL
            AND payload_iv IS NOT NULL
            AND payload_deleted_ts IS NULL
            AND payload_deleted_reason IS NULL)
        OR (payload_storage = 'OBJECT'
            AND payload_plain IS NULL
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NOT NULL
            AND payload_object_version IS NOT NULL
            AND payload_key_id IS NOT NULL
            AND payload_wrapped_key IS NOT NULL
            AND payload_iv IS NOT NULL
            AND payload_deleted_ts IS NULL
            AND payload_deleted_reason IS NULL)
        OR (payload_storage = 'DELETED'
            AND payload_plain IS NULL
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL
            AND payload_key_id IS NULL
            AND payload_wrapped_key IS NULL
            AND payload_iv IS NULL
            AND payload_deleted_ts IS NOT NULL
            AND length(btrim(payload_deleted_reason)) > 0)
    ),
    ADD CONSTRAINT event_failure_event_crypto_ck CHECK(
        payload_storage IN ('DATABASE_PLAIN', 'DELETED')
        OR (octet_length(payload_iv) = 12 AND octet_length(payload_wrapped_key) > 0)
    ),
    ADD CONSTRAINT event_failure_event_bytes_ck CHECK(
        encrypted_payload_bytes >= 0 AND decrypted_payload_bytes >= 0
        AND (payload_storage <> 'DATABASE_PLAIN'
             OR (encrypted_payload_bytes = 0
                 AND decrypted_payload_bytes = octet_length(payload_plain)))
    ),
    ADD CONSTRAINT event_failure_event_versions_v2_ck CHECK(
        length(btrim(policy_registry_version)) > 0
        AND (event_schema_version IS NULL OR length(btrim(event_schema_version)) > 0)
        AND (repair_schema_version IS NULL OR length(btrim(repair_schema_version)) > 0)
    );

ALTER TABLE event_replay_request_t
    ADD COLUMN IF NOT EXISTS repair_schema_version VARCHAR(64);
ALTER TABLE event_replay_request_t
    DROP CONSTRAINT IF EXISTS event_replay_request_repair_schema_v2_ck,
    ADD CONSTRAINT event_replay_request_repair_schema_v2_ck CHECK(
        repair_schema_version IS NULL OR length(btrim(repair_schema_version)) > 0
    );

CREATE OR REPLACE FUNCTION event_replay_changed_fields_valid_v2(fields JSONB)
RETURNS boolean LANGUAGE sql IMMUTABLE AS '
    SELECT jsonb_typeof(fields) = ''array''
       AND jsonb_array_length(fields) BETWEEN 1 AND 64
       AND NOT EXISTS (
            SELECT 1
              FROM jsonb_array_elements(fields) AS entry(value)
             WHERE jsonb_typeof(value) <> ''string''
                OR length(btrim(value #>> ''{}'')) NOT BETWEEN 1 AND 255
       )
';

CREATE TABLE IF NOT EXISTS event_repair_t (
    host_id                          UUID NOT NULL,
    repair_id                        UUID NOT NULL,
    failure_id                       UUID NOT NULL,
    status                           VARCHAR(32) NOT NULL DEFAULT 'AWAITING_APPROVAL',
    reason                           VARCHAR(2048) NOT NULL,
    policy_registry_version          VARCHAR(64) NOT NULL,
    repair_schema_version            VARCHAR(64) NOT NULL,
    original_transaction_fingerprint VARCHAR(64) NOT NULL,
    corrected_transaction_fingerprint VARCHAR(64) NOT NULL,
    changed_event_count              INTEGER NOT NULL,
    requested_by                     VARCHAR(255) NOT NULL,
    requested_ts                     TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    decision_by                      VARCHAR(255),
    decision_ts                      TIMESTAMPTZ,
    approved_by                      VARCHAR(255),
    approved_ts                      TIMESTAMPTZ,
    applied_by                       VARCHAR(255),
    applied_ts                       TIMESTAMPTZ,
    completed_ts                     TIMESTAMPTZ,
    created_ts                       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts                       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_repair_pk PRIMARY KEY(host_id, repair_id),
    CONSTRAINT event_repair_failure_fk FOREIGN KEY(host_id, failure_id)
        REFERENCES event_failure_transaction_t(host_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_repair_target_uk UNIQUE(host_id, repair_id, failure_id),
    CONSTRAINT event_repair_status_ck CHECK(status IN (
        'AWAITING_APPROVAL', 'APPROVED', 'APPLIED', 'CANCELLED', 'REJECTED'
    )),
    CONSTRAINT event_repair_reason_ck CHECK(length(btrim(reason)) > 0),
    CONSTRAINT event_repair_versions_ck CHECK(
        length(btrim(policy_registry_version)) > 0
        AND length(btrim(repair_schema_version)) > 0
    ),
    CONSTRAINT event_repair_fingerprints_ck CHECK(
        original_transaction_fingerprint ~ '^[0-9a-f]{64}$'
        AND corrected_transaction_fingerprint ~ '^[0-9a-f]{64}$'
        AND corrected_transaction_fingerprint <> original_transaction_fingerprint
    ),
    CONSTRAINT event_repair_count_ck CHECK(changed_event_count > 0),
    CONSTRAINT event_repair_actor_pairs_ck CHECK(
        (decision_by IS NULL) = (decision_ts IS NULL)
        AND (approved_by IS NULL) = (approved_ts IS NULL)
        AND (applied_by IS NULL) = (applied_ts IS NULL)
        AND (decision_by IS NULL OR decision_by <> requested_by)
        AND (approved_by IS NULL OR approved_by <> requested_by)
    ),
    CONSTRAINT event_repair_lifecycle_ck CHECK(
        (status = 'AWAITING_APPROVAL'
            AND decision_by IS NULL AND approved_by IS NULL
            AND applied_by IS NULL AND completed_ts IS NULL)
        OR (status = 'APPROVED'
            AND decision_by IS NOT NULL AND approved_by = decision_by
            AND approved_ts = decision_ts
            AND applied_by IS NULL AND completed_ts IS NULL)
        OR (status = 'APPLIED'
            AND decision_by IS NOT NULL AND approved_by = decision_by
            AND approved_ts = decision_ts
            AND applied_by IS NOT NULL AND completed_ts = applied_ts)
        OR (status = 'REJECTED'
            AND decision_by IS NOT NULL AND approved_by IS NULL
            AND applied_by IS NULL AND completed_ts = decision_ts)
        OR (status = 'CANCELLED'
            AND applied_by IS NULL AND completed_ts IS NOT NULL
            AND ((decision_by IS NULL AND approved_by IS NULL)
                 OR (decision_by IS NOT NULL AND approved_by = decision_by
                     AND approved_ts = decision_ts)))
    ),
    CONSTRAINT event_repair_times_ck CHECK(
        created_ts >= requested_ts
        AND updated_ts >= requested_ts
        AND (decision_ts IS NULL OR decision_ts >= requested_ts)
        AND (approved_ts IS NULL OR approved_ts >= requested_ts)
        AND (applied_ts IS NULL OR applied_ts >= approved_ts)
        AND (completed_ts IS NULL OR completed_ts >= requested_ts)
    )
);

DO $event_repair_parent_keys_v2$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
         WHERE conrelid = 'event_failure_transaction_t'::regclass
           AND conname = 'event_failure_transaction_scope_parent_v2_uk'
    ) THEN
        ALTER TABLE event_failure_transaction_t
            ADD CONSTRAINT event_failure_transaction_scope_parent_v2_uk UNIQUE(
                host_id, failure_id, projection_name, consumer_group, status
            );
    END IF;
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
         WHERE conrelid = 'event_failure_event_t'::regclass
           AND conname = 'event_failure_event_repair_member_v2_uk'
    ) THEN
        ALTER TABLE event_failure_event_t
            ADD CONSTRAINT event_failure_event_repair_member_v2_uk UNIQUE(
                host_id, failure_id, event_ordinal, event_id, payload_digest
            );
    END IF;
END
$event_repair_parent_keys_v2$;

CREATE TABLE IF NOT EXISTS event_failure_scope_t (
    host_id          UUID NOT NULL,
    failure_id       UUID NOT NULL,
    projection_name  VARCHAR(128) NOT NULL,
    consumer_group   VARCHAR(255) NOT NULL,
    scope_type       VARCHAR(32) NOT NULL,
    scope_key        VARCHAR(1024) NOT NULL,
    status           VARCHAR(16) NOT NULL,
    created_ts       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_failure_scope_pk PRIMARY KEY(
        host_id, failure_id, scope_type, scope_key
    ),
    -- Projection and consumer identity are immutable; this cascade is for status only.
    CONSTRAINT event_failure_scope_parent_fk FOREIGN KEY(
        host_id, failure_id, projection_name, consumer_group, status
    ) REFERENCES event_failure_transaction_t(
        host_id, failure_id, projection_name, consumer_group, status
    ) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT event_failure_scope_type_ck CHECK(scope_type IN (
        'GRAPH_ROOT', 'AGGREGATE', 'HOST', 'DB_PARTITION',
        'KAFKA_PARTITION', 'PROJECTION'
    )),
    CONSTRAINT event_failure_scope_key_ck CHECK(length(btrim(scope_key)) > 0),
    CONSTRAINT event_failure_scope_status_ck CHECK(status IN ('OPEN', 'RESOLVED', 'WAIVED'))
);

CREATE TABLE IF NOT EXISTS event_repair_event_t (
    host_id                    UUID NOT NULL,
    repair_id                  UUID NOT NULL,
    failure_id                 UUID NOT NULL,
    event_ordinal              INTEGER NOT NULL,
    original_event_id          VARCHAR(255) NOT NULL,
    original_payload_digest    VARCHAR(64) NOT NULL,
    corrected_payload_format   VARCHAR(32) NOT NULL,
    corrected_payload_storage  VARCHAR(32) NOT NULL,
    corrected_payload_digest   VARCHAR(64) NOT NULL,
    corrected_payload_plain    BYTEA,
    corrected_payload_ciphertext BYTEA,
    corrected_payload_object_uri VARCHAR(2048),
    corrected_payload_object_version VARCHAR(255),
    corrected_payload_key_id   VARCHAR(255),
    corrected_payload_wrapped_key BYTEA,
    corrected_payload_iv       BYTEA,
    corrected_payload_bytes    BIGINT NOT NULL,
    corrected_event_schema_version VARCHAR(64) NOT NULL,
    changed_field_names        JSONB NOT NULL,
    created_ts                 TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_repair_event_pk PRIMARY KEY(host_id, repair_id, event_ordinal),
    CONSTRAINT event_repair_event_repair_fk FOREIGN KEY(host_id, repair_id, failure_id)
        REFERENCES event_repair_t(host_id, repair_id, failure_id) ON DELETE RESTRICT,
    CONSTRAINT event_repair_event_original_fk FOREIGN KEY(
        host_id, failure_id, event_ordinal, original_event_id, original_payload_digest
    ) REFERENCES event_failure_event_t(
        host_id, failure_id, event_ordinal, event_id, payload_digest
    ) ON DELETE RESTRICT,
    CONSTRAINT event_repair_event_ordinal_ck CHECK(event_ordinal >= 0),
    CONSTRAINT event_repair_event_digests_ck CHECK(
        original_payload_digest ~ '^[0-9a-f]{64}$'
        AND corrected_payload_digest ~ '^[0-9a-f]{64}$'
        AND corrected_payload_digest <> original_payload_digest
    ),
    CONSTRAINT event_repair_event_schema_ck CHECK(
        length(btrim(corrected_event_schema_version)) > 0
    ),
    CONSTRAINT event_repair_event_changed_fields_ck CHECK(
        event_replay_changed_fields_valid_v2(changed_field_names)
    ),
    CONSTRAINT event_repair_event_payload_storage_ck CHECK(
        (corrected_payload_storage = 'DATABASE_PLAIN'
            AND corrected_payload_plain IS NOT NULL
            AND octet_length(corrected_payload_plain) = corrected_payload_bytes
            AND corrected_payload_bytes > 0
            AND corrected_payload_digest = encode(sha256(corrected_payload_plain), 'hex')
            AND corrected_payload_ciphertext IS NULL
            AND corrected_payload_object_uri IS NULL
            AND corrected_payload_object_version IS NULL
            AND corrected_payload_key_id IS NULL
            AND corrected_payload_wrapped_key IS NULL
            AND corrected_payload_iv IS NULL)
    )
);

COMMENT ON COLUMN event_repair_event_t.corrected_payload_storage IS
    'R8 supports DATABASE_PLAIN only; encrypted/object columns remain solely for non-destructive upgrade and rollback compatibility';

ALTER TABLE event_replay_item_t
    ADD COLUMN IF NOT EXISTS repair_id UUID;
ALTER TABLE event_replay_item_t
    DROP CONSTRAINT IF EXISTS event_replay_item_repair_target_v2_fk,
    ADD CONSTRAINT event_replay_item_repair_target_v2_fk FOREIGN KEY(
        host_id, repair_id, failure_id
    ) REFERENCES event_repair_t(host_id, repair_id, failure_id) ON DELETE RESTRICT;

ALTER TABLE event_failure_transaction_t
    DROP CONSTRAINT IF EXISTS event_failure_transaction_resolution_repair_v2_fk,
    ADD CONSTRAINT event_failure_transaction_resolution_repair_v2_fk FOREIGN KEY(
        host_id, resolved_by_repair_id, failure_id
    ) REFERENCES event_repair_t(host_id, repair_id, failure_id) ON DELETE RESTRICT;

CREATE OR REPLACE FUNCTION validate_event_repair_members_v2()
RETURNS trigger LANGUAGE plpgsql AS '
DECLARE
    v_host UUID;
    v_repair UUID;
    v_expected INTEGER;
    v_actual INTEGER;
BEGIN
    v_host := COALESCE(NEW.host_id, OLD.host_id);
    v_repair := COALESCE(NEW.repair_id, OLD.repair_id);
    SELECT changed_event_count INTO v_expected
      FROM event_repair_t
     WHERE host_id = v_host AND repair_id = v_repair;
    IF v_expected IS NULL THEN RETURN NULL; END IF;
    SELECT count(*) INTO v_actual
      FROM event_repair_event_t
     WHERE host_id = v_host AND repair_id = v_repair;
    IF v_actual <> v_expected THEN
        RAISE EXCEPTION ''repair % member count %, expected %'', v_repair, v_actual, v_expected;
    END IF;
    RETURN NULL;
END ';

DROP TRIGGER IF EXISTS event_repair_member_count_parent_v2 ON event_repair_t;
CREATE CONSTRAINT TRIGGER event_repair_member_count_parent_v2
AFTER INSERT OR UPDATE OF changed_event_count ON event_repair_t
DEFERRABLE INITIALLY DEFERRED FOR EACH ROW
EXECUTE FUNCTION validate_event_repair_members_v2();
DROP TRIGGER IF EXISTS event_repair_member_count_child_v2 ON event_repair_event_t;
CREATE CONSTRAINT TRIGGER event_repair_member_count_child_v2
AFTER INSERT OR UPDATE OR DELETE ON event_repair_event_t
DEFERRABLE INITIALLY DEFERRED FOR EACH ROW
EXECUTE FUNCTION validate_event_repair_members_v2();

CREATE OR REPLACE FUNCTION protect_event_repair_v2()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP = ''INSERT'' THEN
        IF NEW.status <> ''AWAITING_APPROVAL'' THEN
            RAISE EXCEPTION ''repair must begin awaiting approval'';
        END IF;
        RETURN NEW;
    END IF;
    IF TG_OP = ''DELETE''
       OR NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.repair_id IS DISTINCT FROM OLD.repair_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.reason IS DISTINCT FROM OLD.reason
       OR NEW.policy_registry_version IS DISTINCT FROM OLD.policy_registry_version
       OR NEW.repair_schema_version IS DISTINCT FROM OLD.repair_schema_version
       OR NEW.original_transaction_fingerprint IS DISTINCT FROM OLD.original_transaction_fingerprint
       OR NEW.corrected_transaction_fingerprint IS DISTINCT FROM OLD.corrected_transaction_fingerprint
       OR NEW.changed_event_count IS DISTINCT FROM OLD.changed_event_count
       OR NEW.requested_by IS DISTINCT FROM OLD.requested_by
       OR NEW.requested_ts IS DISTINCT FROM OLD.requested_ts
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts
       OR NEW.updated_ts < OLD.updated_ts
       OR OLD.status IN (''APPLIED'', ''CANCELLED'', ''REJECTED'')
       OR (OLD.status = ''AWAITING_APPROVAL''
           AND NEW.status NOT IN (''APPROVED'', ''CANCELLED'', ''REJECTED''))
       OR (OLD.status = ''APPROVED''
           AND NEW.status NOT IN (''APPLIED'', ''CANCELLED'')) THEN
        RAISE EXCEPTION ''repair identity, evidence, and lifecycle are immutable'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_repair_guard_v2 ON event_repair_t;
CREATE TRIGGER event_repair_guard_v2
BEFORE INSERT OR UPDATE OR DELETE ON event_repair_t
FOR EACH ROW EXECUTE FUNCTION protect_event_repair_v2();

CREATE OR REPLACE FUNCTION protect_event_repair_event_v2()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP <> ''INSERT'' THEN
        RAISE EXCEPTION ''repair event bytes and audit summary are append-only'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_repair_event_guard_v2 ON event_repair_event_t;
CREATE TRIGGER event_repair_event_guard_v2
BEFORE UPDATE OR DELETE ON event_repair_event_t
FOR EACH ROW EXECUTE FUNCTION protect_event_repair_event_v2();

CREATE OR REPLACE FUNCTION protect_event_failure_event_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF TG_OP = ''DELETE'' AND event_replay_retention_delete_enabled_v1() THEN RETURN OLD; END IF;
    IF TG_OP = ''DELETE'' THEN
        RAISE EXCEPTION ''archived failure event rows are immutable'';
    END IF;
    IF OLD.payload_storage = ''DELETED''
       OR NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.event_ordinal IS DISTINCT FROM OLD.event_ordinal
       OR NEW.event_id IS DISTINCT FROM OLD.event_id
       OR NEW.event_type IS DISTINCT FROM OLD.event_type
       OR NEW.aggregate_id IS DISTINCT FROM OLD.aggregate_id
       OR NEW.aggregate_type IS DISTINCT FROM OLD.aggregate_type
       OR NEW.aggregate_version IS DISTINCT FROM OLD.aggregate_version
       OR NEW.root_instance_id IS DISTINCT FROM OLD.root_instance_id
       OR NEW.graph_revision IS DISTINCT FROM OLD.graph_revision
       OR NEW.clone_request_id IS DISTINCT FROM OLD.clone_request_id
       OR NEW.source_processor IS DISTINCT FROM OLD.source_processor
       OR NEW.source_topic IS DISTINCT FROM OLD.source_topic
       OR NEW.source_partition IS DISTINCT FROM OLD.source_partition
       OR NEW.source_offset IS DISTINCT FROM OLD.source_offset
       OR NEW.source_key IS DISTINCT FROM OLD.source_key
       OR NEW.source_headers IS DISTINCT FROM OLD.source_headers
       OR NEW.payload_format IS DISTINCT FROM OLD.payload_format
       OR NEW.payload_digest IS DISTINCT FROM OLD.payload_digest
       OR NEW.event_schema_version IS DISTINCT FROM OLD.event_schema_version
       OR NEW.policy_registry_version IS DISTINCT FROM OLD.policy_registry_version
       OR NEW.repair_schema_version IS DISTINCT FROM OLD.repair_schema_version
       OR NEW.encrypted_payload_bytes IS DISTINCT FROM OLD.encrypted_payload_bytes
       OR NEW.decrypted_payload_bytes IS DISTINCT FROM OLD.decrypted_payload_bytes
       OR NEW.sensitive_payload IS DISTINCT FROM OLD.sensitive_payload
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts
       OR NEW.payload_storage <> ''DELETED''
       OR NEW.payload_plain IS NOT NULL
       OR NEW.payload_ciphertext IS NOT NULL
       OR NEW.payload_object_uri IS NOT NULL
       OR NEW.payload_object_version IS NOT NULL
       OR NEW.payload_key_id IS NOT NULL
       OR NEW.payload_wrapped_key IS NOT NULL
       OR NEW.payload_iv IS NOT NULL
       OR NEW.payload_deleted_ts IS NULL
       OR NEW.payload_deleted_reason IS NULL
       OR length(btrim(NEW.payload_deleted_reason)) = 0 THEN
        RAISE EXCEPTION ''archived failure event rows are immutable except payload deletion'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_failure_event_guard_v1 ON event_failure_event_t;
CREATE TRIGGER event_failure_event_guard_v1
BEFORE UPDATE OR DELETE ON event_failure_event_t
FOR EACH ROW EXECUTE FUNCTION protect_event_failure_event_v1();

CREATE OR REPLACE FUNCTION event_replay_reconciliation_enabled_v2()
RETURNS boolean LANGUAGE sql STABLE AS '
    SELECT COALESCE(current_setting(''lightapi.event_replay_reconciliation'', TRUE), '''') = ''on''
';

CREATE OR REPLACE FUNCTION protect_event_failure_identity_v1()
RETURNS trigger LANGUAGE plpgsql AS '
BEGIN
    IF NEW.host_id IS DISTINCT FROM OLD.host_id
       OR NEW.failure_id IS DISTINCT FROM OLD.failure_id
       OR NEW.projection_name IS DISTINCT FROM OLD.projection_name
       OR NEW.consumer_group IS DISTINCT FROM OLD.consumer_group
       OR NEW.first_source_processor IS DISTINCT FROM OLD.first_source_processor
       OR NEW.original_transaction_id IS DISTINCT FROM OLD.original_transaction_id
       OR NEW.content_fingerprint IS DISTINCT FROM OLD.content_fingerprint
       OR NEW.event_count IS DISTINCT FROM OLD.event_count
       OR NEW.encrypted_payload_bytes IS DISTINCT FROM OLD.encrypted_payload_bytes
       OR NEW.decrypted_payload_bytes IS DISTINCT FROM OLD.decrypted_payload_bytes
       OR NEW.dependency_scopes IS DISTINCT FROM OLD.dependency_scopes
       OR NEW.policy_registry_version IS DISTINCT FROM OLD.policy_registry_version
       OR NEW.first_failed_ts IS DISTINCT FROM OLD.first_failed_ts
       OR NEW.created_ts IS DISTINCT FROM OLD.created_ts
       OR NEW.failure_count < OLD.failure_count
       OR NEW.last_failed_ts < OLD.last_failed_ts
       OR (OLD.status <> ''OPEN'' AND (
           NEW.status IS DISTINCT FROM OLD.status
           OR NEW.resolved_ts IS DISTINCT FROM OLD.resolved_ts
           OR NEW.resolved_by_request_id IS DISTINCT FROM OLD.resolved_by_request_id
           OR NEW.resolution_code IS DISTINCT FROM OLD.resolution_code
           OR NEW.resolved_by_repair_id IS DISTINCT FROM OLD.resolved_by_repair_id)
           AND NOT (
               OLD.status = ''RESOLVED''
               AND NEW.status = ''OPEN''
               AND event_replay_reconciliation_enabled_v2()
               AND NEW.resolved_ts IS NULL
               AND NEW.resolved_by_request_id IS NULL
               AND NEW.resolution_code IS NULL
               AND NEW.resolved_by_repair_id IS NULL)) THEN
        RAISE EXCEPTION ''canonical failure identity and terminal resolution are immutable'';
    END IF;
    RETURN NEW;
END ';

DROP TRIGGER IF EXISTS event_failure_identity_guard_v1 ON event_failure_transaction_t;
CREATE TRIGGER event_failure_identity_guard_v1
BEFORE UPDATE ON event_failure_transaction_t
FOR EACH ROW EXECUTE FUNCTION protect_event_failure_identity_v1();

CREATE INDEX IF NOT EXISTS event_failure_open_scope_v2_idx
    ON event_failure_scope_t(
        host_id, projection_name, consumer_group, scope_type, scope_key
    ) WHERE status = 'OPEN';
CREATE INDEX IF NOT EXISTS event_failure_open_command_scope_v2_idx
    ON event_failure_scope_t(
        host_id, scope_type, scope_key, projection_name, consumer_group, failure_id
    ) WHERE status = 'OPEN';
CREATE INDEX IF NOT EXISTS event_repair_failure_v2_idx
    ON event_repair_t(host_id, failure_id, status, requested_ts DESC);
CREATE INDEX IF NOT EXISTS event_repair_status_v2_idx
    ON event_repair_t(host_id, status, requested_ts DESC);

REVOKE SELECT (payload_plain) ON event_failure_event_t FROM PUBLIC;
REVOKE SELECT (payload_plain) ON event_projection_deferred_t FROM PUBLIC;
REVOKE SELECT (corrected_payload_plain, corrected_payload_ciphertext,
               corrected_payload_wrapped_key, corrected_payload_iv)
    ON event_repair_event_t FROM PUBLIC;

COMMENT ON COLUMN event_failure_event_t.payload_plain IS
    'Immutable canonical replay bytes for DATABASE_PLAIN; digest exact stored bytes before parsing';
COMMENT ON COLUMN event_failure_event_t.payload_storage IS
    'R8 writes DATABASE_PLAIN only; legacy DATABASE/OBJECT columns remain solely for non-destructive upgrade and rollback compatibility';
COMMENT ON COLUMN event_projection_deferred_t.payload_storage IS
    'R8 writes DATABASE_PLAIN only; legacy DATABASE/OBJECT columns remain solely for non-destructive upgrade and rollback compatibility';
COMMENT ON COLUMN event_repair_event_t.corrected_payload_plain IS
    'Immutable corrected canonical bytes; never exposed by list/query APIs';
COMMENT ON TABLE event_failure_scope_t IS
    'Normalized failure scopes maintained by capture for indexed ordered-scope command guards';


COMMIT;

-- PDB-1 authoritative LLM control-plane schema for fresh installations.
-- The historical model rename patch remains separate and is not replayed here.
-- BEGIN CONSOLIDATED LLM CONTROL-PLANE SCHEMA
BEGIN;

DO $legacy_llm_model_guard$
BEGIN
    IF to_regclass(format('%I.llm_model_catalog_t', current_schema())) IS NOT NULL THEN
        RAISE EXCEPTION 'run patch_20260721_01_llm_model_rename.sql before ddl.sql on an existing database';
    END IF;
END
$legacy_llm_model_guard$;

-- Global inventory of canonical provider model identifiers, capabilities, and token limits used by every host.
CREATE TABLE IF NOT EXISTS llm_model_t (
    model_id UUID NOT NULL,
    provider_type VARCHAR(32) NOT NULL,
    physical_model_id VARCHAR(255) NOT NULL,
    model_family VARCHAR(126) NOT NULL,
    model_version VARCHAR(64),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    context_token_limit BIGINT NOT NULL CHECK(context_token_limit > 0),
    output_token_limit BIGINT NOT NULL CHECK(output_token_limit > 0),
    modalities JSONB NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(modalities) = 'array'),
    operations JSONB NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(operations) = 'array'),
    declared_capabilities JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(declared_capabilities) = 'object'),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(model_id),
    UNIQUE(provider_type, physical_model_id),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','DEPRECATED','RETIRED'))
);

-- Enables a model in an environment and records its regional, data-classification, and capability restrictions.
CREATE TABLE IF NOT EXISTS llm_model_registration_t (
    host_id UUID NOT NULL,
    model_registration_id UUID NOT NULL,
    model_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    regions JSONB NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(regions) = 'array'),
    data_classifications JSONB NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(data_classifications) = 'array'),
    capability_restrictions JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(capability_restrictions) = 'object'),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, model_registration_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(model_id) REFERENCES llm_model_t(model_id) ON DELETE RESTRICT,
    UNIQUE(host_id, model_id, environment),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','SUSPENDED','RETIRED'))
);

-- Identifies a provider billing and quota account used by deployments; credentials are stored separately as secret references.
CREATE TABLE IF NOT EXISTS llm_provider_account_t (
    host_id UUID NOT NULL,
    provider_account_id UUID NOT NULL,
    account_name VARCHAR(126) NOT NULL,
    provider_type VARCHAR(32) NOT NULL,
    billing_principal VARCHAR(255) NOT NULL,
    quota_group_id VARCHAR(126) NOT NULL,
    capacity_metadata JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(capacity_metadata) = 'object'),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, provider_account_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    UNIQUE(host_id, provider_type, account_name),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','SUSPENDED','RETIRED'))
);

-- Defines a callable provider endpoint that binds a registered model to an account, region, and conformance evidence.
CREATE TABLE IF NOT EXISTS llm_provider_deployment_t (
    host_id UUID NOT NULL,
    provider_deployment_id UUID NOT NULL,
    model_registration_id UUID NOT NULL,
    provider_account_id UUID NOT NULL,
    deployment_name VARCHAR(126) NOT NULL,
    provider_type VARCHAR(32) NOT NULL,
    provider_protocol VARCHAR(32) NOT NULL,
    physical_model_id VARCHAR(255) NOT NULL,
    base_url TEXT NOT NULL CHECK(base_url ~ '^https://'),
    region VARCHAR(64),
    transport_bounds JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(transport_bounds) = 'object'),
    conformance_state VARCHAR(16) NOT NULL DEFAULT 'UNKNOWN',
    conformance_digest VARCHAR(71),
    conformance_valid_until TIMESTAMPTZ,
    conformance_result JSONB,
    refresh_before_seconds INTEGER CHECK(refresh_before_seconds IS NULL OR refresh_before_seconds > 0),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, provider_deployment_id),
    FOREIGN KEY(host_id, model_registration_id) REFERENCES llm_model_registration_t(host_id, model_registration_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, provider_account_id) REFERENCES llm_provider_account_t(host_id, provider_account_id) ON DELETE RESTRICT,
    UNIQUE(host_id, deployment_name),
    CONSTRAINT llm_provider_deployment_provider_protocol_ck
        CHECK(provider_protocol IN ('openai_chat','openai_responses','openai_embeddings','anthropic_messages','bedrock_converse')),
    CHECK(conformance_state IN ('UNKNOWN','PENDING','PASS','FAIL','EXPIRED','QUARANTINED')),
    CHECK(lifecycle_status IN ('DRAFT','VALIDATING','ACTIVE','SUSPENDED','RETIRED')),
    CHECK(conformance_valid_until IS NULL OR conformance_digest IS NOT NULL)
);

ALTER TABLE llm_provider_deployment_t
    ADD COLUMN IF NOT EXISTS conformance_result JSONB;
-- Compact PASS flags from an older schema are not production attestations.
-- Quarantine them during upgrade so the stronger constraint can be installed
-- without treating unaudited capability declarations as evidence.
UPDATE llm_provider_deployment_t
   SET conformance_state = 'QUARANTINED'
 WHERE conformance_state = 'PASS'
   AND NOT ((
       conformance_result IS NOT NULL
       AND conformance_digest IS NOT NULL
       AND conformance_valid_until IS NOT NULL
       AND jsonb_typeof(conformance_result) = 'object'
       AND conformance_result->>'schemaVersion' = '1'
       AND conformance_result->>'state' = 'pass'
       AND conformance_result->>'digest' = conformance_digest
       AND conformance_result->>'provider' = provider_protocol
       AND conformance_result->>'physicalModel' = physical_model_id
       AND CASE
           WHEN conformance_result->>'validUntil' ~ '^\d{4}-\d{2}-\d{2}T'
           THEN (conformance_result->>'validUntil')::timestamptz = conformance_valid_until
           ELSE FALSE
       END
       AND jsonb_typeof(conformance_result->'capabilities') = 'object'
       AND jsonb_typeof(conformance_result->'capabilityEvidence') = 'object'
   ) IS TRUE);
ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_conformance_result_shape_ck;
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_conformance_result_shape_ck CHECK(
        (conformance_result IS NULL OR jsonb_typeof(conformance_result) = 'object') IS TRUE
    );
ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_pass_result_ck;
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_pass_result_ck CHECK(
        (conformance_state <> 'PASS' OR (
            conformance_result IS NOT NULL
            AND conformance_digest IS NOT NULL
            AND conformance_valid_until IS NOT NULL
            AND conformance_result->>'schemaVersion' = '1'
            AND conformance_result->>'state' = 'pass'
            AND conformance_result->>'digest' = conformance_digest
            AND conformance_result->>'provider' = provider_protocol
            AND conformance_result->>'physicalModel' = physical_model_id
            AND (conformance_result->>'validUntil')::timestamptz = conformance_valid_until
            AND jsonb_typeof(conformance_result->'capabilities') = 'object'
            AND jsonb_typeof(conformance_result->'capabilityEvidence') = 'object'
        )) IS TRUE
    );
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_embedding_space_evidence_ck CHECK(
        provider_protocol <> 'openai_embeddings' OR conformance_state <> 'PASS' OR (
            jsonb_typeof(conformance_result->'capabilities'->'embedding'->'space') = 'object'
            AND length(conformance_result->'capabilities'->'embedding'->'space'->>'spaceId') BETWEEN 1 AND 255
            AND (conformance_result->'capabilities'->'embedding'->'space'->>'revision') ~ '^[1-9][0-9]*$'
            AND (conformance_result->'capabilities'->'embedding'->'space'->>'dimension') ~ '^[1-9][0-9]*$'
            AND conformance_result->'capabilities'->'embedding'->'space'->>'normalization' IN ('none','l2')
            AND conformance_result->'capabilities'->'embedding'->'space'->>'distanceMetric' IN ('cosine','inner_product','l2')
            AND length(conformance_result->'capabilities'->'embedding'->'space'->>'documentInputTransformVersion') BETWEEN 1 AND 255
            AND ((conformance_result->'capabilities'->'embedding'->'space') - ARRAY[
                'spaceId','revision','dimension','normalization','distanceMetric',
                'documentInputTransformVersion']::text[]) = '{}'::jsonb
        )
    );

-- Tracks versioned secret references and rotation windows used to authenticate a provider deployment without storing secret material.
CREATE TABLE IF NOT EXISTS llm_provider_credential_t (
    host_id UUID NOT NULL,
    provider_credential_id UUID NOT NULL,
    provider_deployment_id UUID NOT NULL,
    credential_version INTEGER NOT NULL CHECK(credential_version > 0),
    secret_reference VARCHAR(1024) NOT NULL,
    effective_ts TIMESTAMPTZ NOT NULL,
    expires_ts TIMESTAMPTZ,
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'PENDING',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, provider_credential_id),
    FOREIGN KEY(host_id, provider_deployment_id) REFERENCES llm_provider_deployment_t(host_id, provider_deployment_id) ON DELETE RESTRICT,
    UNIQUE(host_id, provider_deployment_id, credential_version),
    CONSTRAINT llm_provider_credential_secret_reference_ck CHECK(
        secret_reference ~ '^env:[A-Za-z_][A-Za-z0-9_]*$'
        OR secret_reference ~ '^[A-Za-z][A-Za-z0-9+.-]*://'),
    CHECK(expires_ts IS NULL OR expires_ts > effective_ts),
    CHECK(lifecycle_status IN ('PENDING','ACTIVE','ROTATING','REVOKED','EXPIRED'))
);

-- Provides the stable client-facing model name and request-policy envelope resolved by gateways and agents.
CREATE TABLE IF NOT EXISTS llm_public_alias_t (
    host_id UUID NOT NULL,
    public_alias_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    alias_name VARCHAR(126) NOT NULL,
    operations JSONB NOT NULL CHECK(
        jsonb_typeof(operations) = 'array'
        AND jsonb_array_length(operations) > 0
        AND operations <@ '["generate", "embed"]'::jsonb
    ),
    required_capabilities JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(required_capabilities) = 'object'),
    require_expected_embedding_space BOOLEAN NOT NULL DEFAULT FALSE,
    embedding_workload_lane VARCHAR(16) NOT NULL DEFAULT 'standard',
    max_input_tokens BIGINT CHECK(max_input_tokens IS NULL OR max_input_tokens > 0),
    max_output_tokens BIGINT CHECK(max_output_tokens IS NULL OR max_output_tokens > 0),
    max_request_bytes BIGINT CHECK(max_request_bytes IS NULL OR max_request_bytes > 0),
    data_classification VARCHAR(32),
    logging_mode VARCHAR(16) NOT NULL DEFAULT 'METADATA',
    pii_mode VARCHAR(16) NOT NULL DEFAULT 'DENY',
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    replacement_alias_id UUID,
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, public_alias_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, replacement_alias_id) REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE RESTRICT,
    UNIQUE(host_id, environment, alias_name),
    CHECK(logging_mode IN ('NONE','METADATA','REDACTED')),
    CHECK(pii_mode IN ('DENY','REDACT','TOKENIZE','ALLOW')),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','DEPRECATED','RETIRED')),
    CONSTRAINT llm_public_alias_embedding_space_ck CHECK(
        (operations ? 'embed' AND (
            jsonb_typeof(required_capabilities->'embeddingSpace') = 'object'
            AND length(required_capabilities->'embeddingSpace'->>'spaceId') BETWEEN 1 AND 255
            AND (required_capabilities->'embeddingSpace'->>'revision') ~ '^[1-9][0-9]*$'
            AND (required_capabilities->'embeddingSpace'->>'dimension') ~ '^[1-9][0-9]*$'
            AND required_capabilities->'embeddingSpace'->>'normalization' IN ('none','l2')
            AND required_capabilities->'embeddingSpace'->>'distanceMetric' IN ('cosine','inner_product','l2')
            AND length(required_capabilities->'embeddingSpace'->>'documentInputTransformVersion') BETWEEN 1 AND 255
            AND ((required_capabilities->'embeddingSpace') - ARRAY[
                'spaceId','revision','dimension','normalization','distanceMetric',
                'documentInputTransformVersion']::text[]) = '{}'::jsonb
        )) OR (NOT (operations ? 'embed') AND NOT (required_capabilities ? 'embeddingSpace'))
    ),
    CONSTRAINT llm_public_alias_expected_space_required_ck
        CHECK(NOT require_expected_embedding_space OR operations ? 'embed'),
    CONSTRAINT llm_public_alias_embedding_workload_lane_ck
        CHECK(embedding_workload_lane IN ('standard','kb_query','kb_index')),
    CONSTRAINT llm_public_alias_embedding_lane_shape_ck
        CHECK(embedding_workload_lane = 'standard' OR (
        operations = '["embed"]'::jsonb
        AND require_expected_embedding_space
    )),
    CHECK(replacement_alias_id IS NULL OR replacement_alias_id <> public_alias_id)
);

-- Maps an alias to ordered provider deployments for primary routing, fallback, and future weighted or canary selection.
CREATE TABLE IF NOT EXISTS llm_alias_route_t (
    host_id UUID NOT NULL,
    alias_route_id UUID NOT NULL,
    public_alias_id UUID NOT NULL,
    provider_deployment_id UUID NOT NULL,
    route_priority INTEGER NOT NULL CHECK(route_priority >= 0),
    route_weight INTEGER NOT NULL DEFAULT 1 CHECK(route_weight > 0),
    fallback_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    canary_percent NUMERIC(5,2) NOT NULL DEFAULT 0 CHECK(canary_percent >= 0 AND canary_percent <= 100),
    residency_conditions JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(residency_conditions) = 'object'),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, alias_route_id),
    FOREIGN KEY(host_id, public_alias_id) REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, provider_deployment_id) REFERENCES llm_provider_deployment_t(host_id, provider_deployment_id) ON DELETE RESTRICT,
    UNIQUE(host_id, public_alias_id, provider_deployment_id),
    UNIQUE(host_id, public_alias_id, route_priority),
    CHECK(route_weight = 1),
    CHECK(canary_percent = 0)
);

-- Stores effective-dated deployment pricing versions used for cost calculation, budgeting, and audit.
CREATE TABLE IF NOT EXISTS llm_pricing_version_t (
    host_id UUID NOT NULL,
    pricing_version_id UUID NOT NULL,
    provider_deployment_id UUID NOT NULL,
    pricing_version INTEGER NOT NULL CHECK(pricing_version > 0),
    operation VARCHAR(16) NOT NULL CHECK(operation IN ('generate','embed')),
    input_micros_per_million BIGINT NOT NULL CHECK(input_micros_per_million >= 0),
    output_micros_per_million BIGINT CHECK(output_micros_per_million IS NULL OR output_micros_per_million >= 0),
    cached_input_micros_per_million BIGINT CHECK(cached_input_micros_per_million IS NULL OR cached_input_micros_per_million >= 0),
    effective_ts TIMESTAMPTZ NOT NULL,
    expires_ts TIMESTAMPTZ,
    source VARCHAR(255) NOT NULL,
    approved_by VARCHAR(126) NOT NULL,
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, pricing_version_id),
    FOREIGN KEY(host_id, provider_deployment_id) REFERENCES llm_provider_deployment_t(host_id, provider_deployment_id) ON DELETE RESTRICT,
    UNIQUE(host_id, provider_deployment_id, operation, pricing_version),
    CHECK((operation = 'generate' AND output_micros_per_million IS NOT NULL)
       OR (operation = 'embed' AND output_micros_per_million IS NULL)),
    CHECK(expires_ts IS NULL OR expires_ts > effective_ts)
);

-- Defines reusable access, budget, content, cache, PII, and provider-extension policy applied to model use.
CREATE TABLE IF NOT EXISTS llm_model_policy_t (
    host_id UUID NOT NULL,
    model_policy_id UUID NOT NULL,
    policy_name VARCHAR(126) NOT NULL,
    access_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(access_policy) = 'object'),
    budget_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(budget_policy) = 'object'),
    content_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(content_policy) = 'object'),
    cache_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(cache_policy) = 'object'),
    pii_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(pii_policy) = 'object'),
    native_extension_policy JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(native_extension_policy) = 'object'),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, model_policy_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    UNIQUE(host_id, policy_name),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','SUSPENDED','RETIRED'))
);

-- Assigns a model policy to an agent, client, principal, or product profile, optionally for a specific alias.
CREATE TABLE IF NOT EXISTS llm_model_policy_binding_t (
    host_id UUID NOT NULL,
    model_policy_binding_id UUID NOT NULL,
    model_policy_id UUID NOT NULL,
    subject_type VARCHAR(16) NOT NULL,
    subject_id VARCHAR(255) NOT NULL,
    public_alias_id UUID,
    agent_default BOOLEAN NOT NULL DEFAULT FALSE,
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, model_policy_binding_id),
    FOREIGN KEY(host_id, model_policy_id) REFERENCES llm_model_policy_t(host_id, model_policy_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, public_alias_id) REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE RESTRICT,
    UNIQUE(host_id, model_policy_id, subject_type, subject_id, public_alias_id),
    CHECK(subject_type IN ('AGENT','CLIENT','PRINCIPAL','PRODUCT_PROFILE')),
    CHECK(NOT agent_default OR public_alias_id IS NOT NULL)
);

CREATE UNIQUE INDEX IF NOT EXISTS llm_policy_binding_agent_default_uk
    ON llm_model_policy_binding_t(host_id, model_policy_id, subject_type, subject_id)
    WHERE active IS TRUE AND agent_default IS TRUE;

-- Stores immutable versioned resources from which runtime gateway configuration projections are assembled.
CREATE TABLE IF NOT EXISTS llm_projection_resource_t (
    host_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    projection_resource_id UUID NOT NULL,
    resource_type VARCHAR(32) NOT NULL,
    resource_key VARCHAR(255) NOT NULL,
    resource_version BIGINT NOT NULL CHECK(resource_version > 0),
    sequence_id BIGINT NOT NULL CHECK(sequence_id > 0),
    schema_version INTEGER NOT NULL CHECK(schema_version > 0),
    payload JSONB NOT NULL CHECK(jsonb_typeof(payload) = 'object'),
    payload_digest VARCHAR(71) NOT NULL CHECK(payload_digest ~ '^sha256:[0-9a-f]{64}$'),
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'CANDIDATE',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, environment, projection_resource_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    UNIQUE(host_id, environment, resource_key, resource_version),
    UNIQUE(host_id, environment, sequence_id),
    CHECK(lifecycle_status IN ('CANDIDATE','PUBLISHED','RETIRED'))
);

-- Records each validated values-backed gateway configuration publication and rollback relationship.
CREATE TABLE IF NOT EXISTS llm_gateway_publication_t (
    host_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    gateway_publication_id UUID NOT NULL,
    publication_version BIGINT NOT NULL CHECK(publication_version > 0),
    manifest JSONB NOT NULL CHECK(jsonb_typeof(manifest) = 'object'),
    manifest_digest VARCHAR(71) NOT NULL CHECK(manifest_digest ~ '^sha256:[0-9a-f]{64}$'),
    minimum_gateway_version VARCHAR(32) NOT NULL,
    enabled_routing_features JSONB NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(enabled_routing_features) = 'array'),
    validation_result JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(validation_result) = 'object'),
    publication_state VARCHAR(16) NOT NULL DEFAULT 'CANDIDATE',
    rollback_of_publication_id UUID,
    source_digest VARCHAR(71),
    config_properties JSONB,
    config_properties_digest VARCHAR(71),
    delivery_mode VARCHAR(32) NOT NULL DEFAULT 'INSTANCE_PROPERTIES',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, environment, gateway_publication_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id, environment, rollback_of_publication_id) REFERENCES llm_gateway_publication_t(host_id, environment, gateway_publication_id) ON DELETE RESTRICT,
    UNIQUE(host_id, environment, publication_version),
    UNIQUE(host_id, environment, manifest_digest),
    CHECK(publication_state IN ('CANDIDATE','VALIDATED','PUBLISHED','FAILED','ROLLED_BACK')),
    CONSTRAINT llm_gateway_publication_source_digest_ck CHECK(
        source_digest IS NULL OR source_digest ~ '^sha256:[0-9a-f]{64}$'),
    CONSTRAINT llm_gateway_publication_properties_shape_ck CHECK(
        config_properties IS NULL OR jsonb_typeof(config_properties)='array'),
    CONSTRAINT llm_gateway_publication_properties_digest_ck CHECK(
        config_properties_digest IS NULL OR config_properties_digest ~ '^sha256:[0-9a-f]{64}$'),
    CONSTRAINT llm_gateway_publication_delivery_mode_ck CHECK(
        delivery_mode = 'INSTANCE_PROPERTIES'
        AND source_digest IS NOT NULL
        AND config_properties IS NOT NULL
        AND config_properties_digest IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS llm_gateway_instance_publication_t (
    host_id UUID NOT NULL,
    instance_publication_id UUID NOT NULL,
    instance_id UUID NOT NULL,
    environment VARCHAR(32) NOT NULL,
    gateway_publication_id UUID NOT NULL,
    application_version BIGINT NOT NULL CHECK(application_version > 0),
    property_set_digest VARCHAR(71) NOT NULL CHECK(property_set_digest ~ '^sha256:[0-9a-f]{64}$'),
    application_state VARCHAR(16) NOT NULL DEFAULT 'APPLIED',
    rollback_of_instance_publication_id UUID,
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, instance_publication_id),
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, environment, gateway_publication_id)
        REFERENCES llm_gateway_publication_t(host_id, environment, gateway_publication_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, rollback_of_instance_publication_id)
        REFERENCES llm_gateway_instance_publication_t(host_id, instance_publication_id) ON DELETE RESTRICT,
    UNIQUE(host_id, instance_id, application_version),
    CHECK(application_state IN ('APPLIED','ROLLED_BACK'))
);
CREATE INDEX IF NOT EXISTS llm_gateway_instance_publication_history_idx
    ON llm_gateway_instance_publication_t(host_id, instance_id, application_version DESC)
    WHERE active IS TRUE;

CREATE TABLE IF NOT EXISTS llm_gateway_instance_property_ownership_t (
    host_id UUID NOT NULL,
    instance_id UUID NOT NULL,
    property_id UUID NOT NULL,
    instance_publication_id UUID NOT NULL,
    property_value_digest VARCHAR(71) NOT NULL CHECK(property_value_digest ~ '^sha256:[0-9a-f]{64}$'),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, instance_id, property_id),
    FOREIGN KEY(host_id, instance_id) REFERENCES instance_t(host_id, instance_id) ON DELETE CASCADE,
    FOREIGN KEY(property_id) REFERENCES config_property_t(property_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, instance_publication_id)
        REFERENCES llm_gateway_instance_publication_t(host_id, instance_publication_id) ON DELETE RESTRICT
);
CREATE INDEX IF NOT EXISTS llm_gateway_instance_property_publication_idx
    ON llm_gateway_instance_property_ownership_t(host_id, instance_publication_id);

CREATE OR REPLACE FUNCTION llm_reject_published_digest_mutation()
RETURNS trigger LANGUAGE plpgsql AS $function$
BEGIN
    IF OLD.lifecycle_status = 'PUBLISHED'
       AND (NEW.payload_digest <> OLD.payload_digest OR NEW.payload <> OLD.payload) THEN
        RAISE EXCEPTION 'published LLM projection resources are immutable';
    END IF;
    RETURN NEW;
END
$function$;

DROP TRIGGER IF EXISTS llm_projection_resource_immutable_trg ON llm_projection_resource_t;
CREATE TRIGGER llm_projection_resource_immutable_trg
BEFORE UPDATE ON llm_projection_resource_t
FOR EACH ROW EXECUTE FUNCTION llm_reject_published_digest_mutation();

CREATE OR REPLACE FUNCTION llm_reject_published_manifest_mutation()
RETURNS trigger LANGUAGE plpgsql AS $function$
BEGIN
    IF OLD.publication_state IN ('PUBLISHED','ROLLED_BACK')
       AND (
           NEW.manifest_digest <> OLD.manifest_digest
           OR NEW.manifest <> OLD.manifest
           OR NEW.source_digest IS DISTINCT FROM OLD.source_digest
           OR NEW.config_properties IS DISTINCT FROM OLD.config_properties
           OR NEW.config_properties_digest IS DISTINCT FROM OLD.config_properties_digest
           OR NEW.delivery_mode <> OLD.delivery_mode
       ) THEN
        RAISE EXCEPTION 'published LLM gateway configurations are immutable';
    END IF;
    RETURN NEW;
END
$function$;

DROP TRIGGER IF EXISTS llm_gateway_publication_immutable_trg ON llm_gateway_publication_t;
CREATE TRIGGER llm_gateway_publication_immutable_trg
BEFORE UPDATE ON llm_gateway_publication_t
FOR EACH ROW EXECUTE FUNCTION llm_reject_published_manifest_mutation();

ALTER TABLE agent_definition_t
    ADD COLUMN IF NOT EXISTS model_alias_id UUID,
    ADD COLUMN IF NOT EXISTS model_policy_id UUID;

ALTER TABLE agent_definition_t ALTER COLUMN model_provider DROP NOT NULL;
ALTER TABLE agent_definition_t ALTER COLUMN model_name DROP NOT NULL;

ALTER TABLE agent_definition_t DROP CONSTRAINT IF EXISTS agent_definition_model_selection_ck;
ALTER TABLE agent_definition_t ADD CONSTRAINT agent_definition_model_selection_ck CHECK (
    NOT (model_alias_id IS NOT NULL AND model_policy_id IS NOT NULL)
    AND (
        model_alias_id IS NOT NULL
        OR model_policy_id IS NOT NULL
        OR (model_provider IS NOT NULL AND model_name IS NOT NULL)
    )
    AND ((model_provider IS NULL) = (model_name IS NULL))
    AND ((model_alias_id IS NULL AND model_policy_id IS NULL) OR api_key_ref IS NULL)
);

ALTER TABLE agent_definition_t DROP CONSTRAINT IF EXISTS agent_definition_model_alias_fk;
ALTER TABLE agent_definition_t ADD CONSTRAINT agent_definition_model_alias_fk
    FOREIGN KEY(host_id, model_alias_id) REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE RESTRICT;
ALTER TABLE agent_definition_t DROP CONSTRAINT IF EXISTS agent_definition_model_policy_fk;
ALTER TABLE agent_definition_t ADD CONSTRAINT agent_definition_model_policy_fk
    FOREIGN KEY(host_id, model_policy_id) REFERENCES llm_model_policy_t(host_id, model_policy_id) ON DELETE RESTRICT;

CREATE INDEX IF NOT EXISTS llm_deployment_conformance_due_idx
    ON llm_provider_deployment_t(host_id, conformance_valid_until)
    WHERE active IS TRUE AND lifecycle_status = 'ACTIVE';
CREATE INDEX IF NOT EXISTS llm_projection_resource_sequence_idx
    ON llm_projection_resource_t(host_id, environment, sequence_id);
CREATE INDEX IF NOT EXISTS llm_publication_current_idx
    ON llm_gateway_publication_t(host_id, environment, publication_version DESC)
    WHERE active IS TRUE;

COMMIT;
-- END CONSOLIDATED LLM CONTROL-PLANE SCHEMA

-- BEGIN INLINED patch_20260719_03_llm_production_integration.sql
-- DIST-1 / LA-1: distinguish public aliases from operator-approved,
-- agent-bound compatibility aliases. Additive and idempotent.
BEGIN;

ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS alias_visibility VARCHAR(24) NOT NULL DEFAULT 'PUBLIC';
ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS bound_agent_def_id UUID;
ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS bound_workload_principal VARCHAR(255);

ALTER TABLE llm_public_alias_t
    DROP CONSTRAINT IF EXISTS llm_public_alias_visibility_ck;
ALTER TABLE llm_public_alias_t
    ADD CONSTRAINT llm_public_alias_visibility_ck CHECK (
        (alias_visibility = 'PUBLIC' AND bound_agent_def_id IS NULL AND bound_workload_principal IS NULL)
        OR (alias_visibility = 'INTERNAL_LEGACY' AND bound_agent_def_id IS NOT NULL AND bound_workload_principal IS NULL)
        OR (alias_visibility = 'INTERNAL_WORKLOAD' AND bound_agent_def_id IS NULL
            AND length(bound_workload_principal) BETWEEN 1 AND 255)
    );

ALTER TABLE llm_public_alias_t
    DROP CONSTRAINT IF EXISTS llm_public_alias_bound_agent_fk;
ALTER TABLE llm_public_alias_t
    ADD CONSTRAINT llm_public_alias_bound_agent_fk
    FOREIGN KEY(host_id, bound_agent_def_id)
    REFERENCES agent_definition_t(host_id, agent_def_id) ON DELETE RESTRICT;

CREATE INDEX IF NOT EXISTS llm_public_alias_bound_agent_idx
    ON llm_public_alias_t(host_id, bound_agent_def_id)
    WHERE alias_visibility = 'INTERNAL_LEGACY' AND active IS TRUE;

CREATE OR REPLACE FUNCTION enforce_llm_public_alias_embedding_space_immutable()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.operations IS DISTINCT FROM OLD.operations
     OR NEW.required_capabilities->'embeddingSpace'
        IS DISTINCT FROM OLD.required_capabilities->'embeddingSpace'
     OR NEW.require_expected_embedding_space IS DISTINCT FROM OLD.require_expected_embedding_space
     OR NEW.embedding_workload_lane IS DISTINCT FROM OLD.embedding_workload_lane THEN
    RAISE EXCEPTION 'Alias operation and embedding-space identity are immutable; create a new Alias revision';
  END IF;
  RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS llm_public_alias_embedding_space_immutable_trg ON llm_public_alias_t;
CREATE TRIGGER llm_public_alias_embedding_space_immutable_trg
BEFORE UPDATE ON llm_public_alias_t FOR EACH ROW
EXECUTE FUNCTION enforce_llm_public_alias_embedding_space_immutable();

COMMIT;
-- END INLINED patch_20260719_03_llm_production_integration.sql

ALTER TABLE llm_public_alias_t
    DROP CONSTRAINT IF EXISTS llm_public_alias_embedding_lane_shape_ck,
    ADD CONSTRAINT llm_public_alias_embedding_lane_shape_ck CHECK (
        embedding_workload_lane = 'standard' OR (
            operations = '["embed"]'::jsonb
            AND require_expected_embedding_space
            AND alias_visibility = 'INTERNAL_WORKLOAD'
        )
    );

-- BEGIN KNOWLEDGE EMBEDDING STABILITY SCHEMA
CREATE TABLE IF NOT EXISTS knowledge_embedding_profile_t (
    profile_id UUID NOT NULL, profile_revision BIGINT NOT NULL CHECK(profile_revision > 0),
    host_id UUID, alias_owner_host_id UUID NOT NULL, public_alias_id UUID NOT NULL,
    expected_space_id VARCHAR(255) NOT NULL CHECK(length(expected_space_id) > 0),
    expected_space_revision BIGINT NOT NULL CHECK(expected_space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    normalization VARCHAR(16) NOT NULL CHECK(normalization IN ('none','l2')),
    distance_metric VARCHAR(24) NOT NULL CHECK(distance_metric IN ('cosine','inner_product','l2')),
    document_input_transform_version VARCHAR(255) NOT NULL CHECK(length(document_input_transform_version) > 0),
    query_input_transform_version VARCHAR(255) NOT NULL CHECK(length(query_input_transform_version) > 0),
    qualification_digest VARCHAR(128) NOT NULL CHECK(length(qualification_digest) >= 64),
    active BOOLEAN NOT NULL DEFAULT TRUE, update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(profile_id, profile_revision),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(alias_owner_host_id, public_alias_id) REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_embedding_profile_global_space_uq
    ON knowledge_embedding_profile_t(expected_space_id,expected_space_revision,query_input_transform_version)
    WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_embedding_profile_tenant_space_uq
    ON knowledge_embedding_profile_t(host_id,expected_space_id,expected_space_revision,query_input_transform_version)
    WHERE host_id IS NOT NULL AND active IS TRUE;
CREATE OR REPLACE VIEW knowledge_qualified_embedding_alias_v AS
SELECT a.host_id,a.host_id alias_owner_host_id,a.public_alias_id,a.alias_name,
       a.required_capabilities->'embeddingSpace' embedding_space,TRUE active,a.update_ts,
       count(*) eligible_route_count
FROM llm_public_alias_t a JOIN llm_alias_route_t r ON r.host_id=a.host_id AND r.public_alias_id=a.public_alias_id AND r.active
JOIN llm_provider_deployment_t d ON d.host_id=r.host_id AND d.provider_deployment_id=r.provider_deployment_id
WHERE a.active AND a.lifecycle_status='ACTIVE' AND a.operations ? 'embed' AND a.require_expected_embedding_space
  AND d.active AND d.lifecycle_status='ACTIVE' AND d.provider_protocol='openai_embeddings'
  AND d.conformance_state='PASS' AND d.conformance_valid_until>CURRENT_TIMESTAMP
  AND d.conformance_result->'capabilities'->'embedding'->'space'=a.required_capabilities->'embeddingSpace'
GROUP BY a.host_id,a.public_alias_id,a.alias_name,a.required_capabilities->'embeddingSpace',a.update_ts
HAVING bool_and(jsonb_array_length(d.conformance_result->'capabilities'->'embedding'->'supportedDimensions')=1
 AND d.conformance_result->'capabilities'->'embedding'->'supportedDimensions'
 @> jsonb_build_array((a.required_capabilities->'embeddingSpace'->>'dimension')::integer));
CREATE OR REPLACE FUNCTION qualify_knowledge_embedding_profile() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM knowledge_qualified_embedding_alias_v q
  WHERE q.alias_owner_host_id=NEW.alias_owner_host_id AND q.public_alias_id=NEW.public_alias_id
  AND q.embedding_space->>'spaceId'=NEW.expected_space_id
  AND (q.embedding_space->>'revision')::bigint=NEW.expected_space_revision
  AND (q.embedding_space->>'dimension')::integer=NEW.dimension
  AND q.embedding_space->>'normalization'=NEW.normalization
  AND q.embedding_space->>'distanceMetric'=NEW.distance_metric
  AND q.embedding_space->>'documentInputTransformVersion'=NEW.document_input_transform_version) THEN
  RAISE EXCEPTION 'embedding profile must reference a currently qualified immutable Alias space';
 END IF; RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_embedding_profile_qualification_trg ON knowledge_embedding_profile_t;
CREATE TRIGGER knowledge_embedding_profile_qualification_trg BEFORE INSERT ON knowledge_embedding_profile_t
FOR EACH ROW EXECUTE FUNCTION qualify_knowledge_embedding_profile();
CREATE TABLE IF NOT EXISTS knowledge_retrieval_profile_t (
    profile_id UUID PRIMARY KEY, host_id UUID,
    strategy VARCHAR(16) NOT NULL DEFAULT 'HYBRID' CHECK(strategy IN ('LEXICAL','VECTOR','HYBRID')),
    lexical_candidates INTEGER NOT NULL CHECK(lexical_candidates > 0),
    vector_candidates INTEGER NOT NULL CHECK(vector_candidates > 0),
    top_k INTEGER NOT NULL CHECK(top_k > 0 AND top_k <= lexical_candidates + vector_candidates),
    token_budget INTEGER NOT NULL CHECK(token_budget > 0),
    fusion_method VARCHAR(16) NOT NULL DEFAULT 'RRF' CHECK(fusion_method='RRF'),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0), active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS knowledge_base_t (
    knowledge_base_id UUID PRIMARY KEY, host_id UUID, name VARCHAR(255) NOT NULL, description TEXT,
    environment VARCHAR(32) NOT NULL, status VARCHAR(24) NOT NULL DEFAULT 'DRAFT'
        CHECK(status IN ('DRAFT','ACTIVE','DISABLED','RETIRED')),
    acl_mode VARCHAR(24) NOT NULL DEFAULT 'UNIFORM_SCOPE' CHECK(acl_mode IN ('UNIFORM_SCOPE','MIRROR_SOURCE_ACL')),
    embedding_profile_id UUID NOT NULL, embedding_profile_revision BIGINT NOT NULL,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0), active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id,embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id,profile_revision) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_base_global_name_uq
    ON knowledge_base_t(environment,name) WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_base_tenant_name_uq
    ON knowledge_base_t(host_id,environment,name) WHERE host_id IS NOT NULL AND active IS TRUE;
CREATE TABLE IF NOT EXISTS knowledge_index_generation_t (
    index_generation_id UUID PRIMARY KEY, knowledge_base_id UUID NOT NULL,
    embedding_profile_id UUID NOT NULL, embedding_profile_revision BIGINT NOT NULL,
    space_id VARCHAR(255) NOT NULL, space_revision BIGINT NOT NULL CHECK(space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0), parser_version VARCHAR(255) NOT NULL,
    chunker_version VARCHAR(255) NOT NULL, query_input_transform_version VARCHAR(255) NOT NULL,
    state VARCHAR(16) NOT NULL CHECK(state IN ('BUILDING','VALIDATING','PROMOTED','FAILED','SUPERSEDED','PURGED')),
    evidence JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(evidence)='object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, promoted_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id,embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id,profile_revision) ON DELETE RESTRICT
);
CREATE OR REPLACE FUNCTION validate_knowledge_index_generation_profile() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM knowledge_embedding_profile_t p
  WHERE p.profile_id=NEW.embedding_profile_id AND p.profile_revision=NEW.embedding_profile_revision
  AND p.expected_space_id=NEW.space_id AND p.expected_space_revision=NEW.space_revision
  AND p.dimension=NEW.dimension AND p.query_input_transform_version=NEW.query_input_transform_version) THEN
  RAISE EXCEPTION 'index generation must preserve its immutable embedding profile contract';
 END IF; RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_index_generation_profile_trg ON knowledge_index_generation_t;
CREATE TRIGGER knowledge_index_generation_profile_trg BEFORE INSERT OR UPDATE ON knowledge_index_generation_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_generation_profile();
CREATE TABLE IF NOT EXISTS knowledge_index_pointer_t (
    knowledge_base_id UUID NOT NULL, embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL, index_generation_id UUID NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(knowledge_base_id,embedding_profile_id,embedding_profile_revision),
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE CASCADE,
    FOREIGN KEY(index_generation_id) REFERENCES knowledge_index_generation_t(index_generation_id) ON DELETE RESTRICT
);
CREATE OR REPLACE FUNCTION validate_knowledge_index_pointer() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM knowledge_index_generation_t g
  WHERE g.index_generation_id=NEW.index_generation_id AND g.knowledge_base_id=NEW.knowledge_base_id
  AND g.embedding_profile_id=NEW.embedding_profile_id
  AND g.embedding_profile_revision=NEW.embedding_profile_revision AND g.state='PROMOTED') THEN
  RAISE EXCEPTION 'index pointer must select one matching promoted generation';
 END IF; RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_index_pointer_valid_trg ON knowledge_index_pointer_t;
CREATE TRIGGER knowledge_index_pointer_valid_trg BEFORE INSERT OR UPDATE ON knowledge_index_pointer_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_pointer();
CREATE TABLE IF NOT EXISTS knowledge_consumer_quota_t (
    knowledge_base_id UUID NOT NULL, consumer_host_id UUID NOT NULL,
    max_concurrency INTEGER NOT NULL CHECK(max_concurrency > 0),
    requests_per_minute INTEGER NOT NULL CHECK(requests_per_minute > 0),
    max_cost_micros_per_day BIGINT NOT NULL CHECK(max_cost_micros_per_day > 0), active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(knowledge_base_id,consumer_host_id),
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE CASCADE,
    FOREIGN KEY(consumer_host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS knowledge_query_usage_t (
    usage_id UUID PRIMARY KEY, knowledge_base_id UUID NOT NULL, consumer_host_id UUID NOT NULL,
    request_id VARCHAR(255) NOT NULL, request_day DATE NOT NULL,
    charged_micros BIGINT NOT NULL CHECK(charged_micros >= 0), status VARCHAR(24) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id,consumer_host_id)
        REFERENCES knowledge_consumer_quota_t(knowledge_base_id,consumer_host_id) ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id,consumer_host_id,request_id)
);
CREATE OR REPLACE FUNCTION enforce_knowledge_embedding_profile_immutable() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF ROW(NEW.host_id,NEW.alias_owner_host_id,NEW.public_alias_id,NEW.expected_space_id,
        NEW.expected_space_revision,NEW.dimension,NEW.normalization,NEW.distance_metric,
        NEW.document_input_transform_version,NEW.query_input_transform_version,NEW.qualification_digest)
       IS DISTINCT FROM ROW(OLD.host_id,OLD.alias_owner_host_id,OLD.public_alias_id,OLD.expected_space_id,
        OLD.expected_space_revision,OLD.dimension,OLD.normalization,OLD.distance_metric,
        OLD.document_input_transform_version,OLD.query_input_transform_version,OLD.qualification_digest) THEN
        RAISE EXCEPTION 'knowledge embedding profiles are immutable; create a new revision';
    END IF;
    RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_embedding_profile_immutable_trg ON knowledge_embedding_profile_t;
CREATE TRIGGER knowledge_embedding_profile_immutable_trg BEFORE UPDATE ON knowledge_embedding_profile_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_embedding_profile_immutable();
-- END KNOWLEDGE EMBEDDING STABILITY SCHEMA
-- BEGIN INLINED patch_20260808_03_llm_local_provider_transport.sql
BEGIN;

-- Some installations reached the S1 embedding-space schema without taking the
-- destructive Wave 1 clean cutover. Bridge those retained projections to the
-- exact protocol/operation contract before creating endpoint projections.
DO $legacy_wave1_precondition$
BEGIN
    IF EXISTS (
        SELECT 1 FROM llm_provider_deployment_t
         WHERE lower(provider_protocol) NOT IN (
             'openai','anthropic','openai_chat','openai_responses',
             'openai_embeddings','anthropic_messages','bedrock_converse')) THEN
        RAISE EXCEPTION USING MESSAGE =
            'legacy LLM transport migration found an unsupported provider protocol';
    END IF;
    IF EXISTS (
        SELECT 1
          FROM llm_public_alias_t alias_row
          CROSS JOIN LATERAL jsonb_array_elements_text(alias_row.operations) operation(value)
         WHERE operation.value NOT IN ('chat_completions','embeddings','generate','embed')) THEN
        RAISE EXCEPTION USING MESSAGE =
            'legacy LLM transport migration found an unsupported alias operation';
    END IF;
    IF EXISTS (
        SELECT 1
          FROM llm_public_alias_t
         WHERE operations ? 'embeddings'
           AND NOT (
               jsonb_typeof(required_capabilities->'embeddingSpace') = 'object'
               AND length(required_capabilities->'embeddingSpace'->>'spaceId') BETWEEN 1 AND 255
               AND (required_capabilities->'embeddingSpace'->>'revision') ~ '^[1-9][0-9]*$'
               AND (required_capabilities->'embeddingSpace'->>'dimension') ~ '^[1-9][0-9]*$'
               AND required_capabilities->'embeddingSpace'->>'normalization' IN ('none','l2')
               AND required_capabilities->'embeddingSpace'->>'distanceMetric' IN ('cosine','inner_product','l2')
               AND length(required_capabilities->'embeddingSpace'->>'documentInputTransformVersion') BETWEEN 1 AND 255
           )) THEN
        RAISE EXCEPTION USING MESSAGE =
            'legacy embedding aliases require an operator-approved requiredCapabilities.embeddingSpace before transport migration';
    END IF;
END
$legacy_wave1_precondition$;

CREATE TEMP TABLE llm_transport_runtime_view_restore_t(
    view_schema name NOT NULL,
    view_name name NOT NULL,
    view_owner name NOT NULL,
    view_options text,
    view_definition text NOT NULL
) ON COMMIT DROP;
INSERT INTO llm_transport_runtime_view_restore_t
SELECT namespace.nspname,relation.relname,pg_get_userbyid(relation.relowner),
       array_to_string(relation.reloptions,', '),pg_get_viewdef(relation.oid,TRUE)
  FROM pg_class relation
  JOIN pg_namespace namespace ON namespace.oid=relation.relnamespace
 WHERE relation.oid=to_regclass('knowledge_embedding_profile_runtime_v');
CREATE TEMP TABLE llm_transport_runtime_view_grant_restore_t(
    grantee name NOT NULL,
    privilege_type text NOT NULL,
    is_grantable boolean NOT NULL
) ON COMMIT DROP;
INSERT INTO llm_transport_runtime_view_grant_restore_t
SELECT CASE WHEN privilege.grantee=0 THEN 'PUBLIC'::name
            ELSE pg_get_userbyid(privilege.grantee)::name END,
       privilege.privilege_type,privilege.is_grantable
  FROM pg_class relation
  CROSS JOIN LATERAL aclexplode(
      COALESCE(relation.relacl,acldefault('r',relation.relowner))) privilege
 WHERE relation.oid=to_regclass('knowledge_embedding_profile_runtime_v')
   AND privilege.grantee<>relation.relowner;
DROP VIEW IF EXISTS knowledge_embedding_profile_runtime_v;
DROP VIEW IF EXISTS knowledge_qualified_embedding_alias_v;

ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_provider_protocol_ck;
ALTER TABLE llm_provider_deployment_t
    ALTER COLUMN provider_protocol DROP DEFAULT,
    ALTER COLUMN provider_protocol TYPE VARCHAR(32);
UPDATE llm_provider_deployment_t deployment
   SET provider_protocol = CASE lower(deployment.provider_protocol)
       WHEN 'openai' THEN CASE WHEN EXISTS (
           SELECT 1
             FROM llm_model_registration_t registration
             JOIN llm_model_t model ON model.model_id=registration.model_id
            WHERE registration.host_id=deployment.host_id
              AND registration.model_registration_id=deployment.model_registration_id
              AND (model.operations ? 'embed' OR model.operations ? 'embeddings')
              AND NOT (model.operations ? 'generate' OR model.operations ? 'chat_completions')
       ) THEN 'openai_embeddings' ELSE 'openai_chat' END
       WHEN 'anthropic' THEN 'anthropic_messages'
       ELSE lower(deployment.provider_protocol)
   END;
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_provider_protocol_ck CHECK(
        provider_protocol IN (
            'openai_chat','openai_responses','openai_embeddings','anthropic_messages','bedrock_converse'));

-- Existing PASS evidence names the legacy protocol and cannot attest to the
-- exact protocol contract. Preserve the row but require requalification.
UPDATE llm_provider_deployment_t
   SET conformance_state='QUARANTINED'
 WHERE conformance_state='PASS'
   AND NOT (conformance_result IS NOT NULL
       AND conformance_result->>'provider'=provider_protocol);

DROP TRIGGER IF EXISTS llm_public_alias_embedding_space_immutable_trg
    ON llm_public_alias_t;
ALTER TABLE llm_public_alias_t
    ALTER COLUMN operations DROP DEFAULT,
    DROP CONSTRAINT IF EXISTS llm_public_alias_operations_ck,
    DROP CONSTRAINT IF EXISTS llm_public_alias_t_operations_check;
UPDATE llm_public_alias_t alias_row
   SET operations = (
       SELECT jsonb_agg(mapped.value ORDER BY mapped.first_ordinality)
         FROM (
             SELECT CASE operation.value
                        WHEN 'chat_completions' THEN 'generate'
                        WHEN 'embeddings' THEN 'embed'
                        ELSE operation.value
                    END AS value,
                    min(operation.ordinality) AS first_ordinality
               FROM jsonb_array_elements_text(alias_row.operations)
                    WITH ORDINALITY AS operation(value, ordinality)
              GROUP BY CASE operation.value
                           WHEN 'chat_completions' THEN 'generate'
                           WHEN 'embeddings' THEN 'embed'
                           ELSE operation.value
                       END
         ) mapped)
 WHERE operations ?| ARRAY['chat_completions','embeddings'];
ALTER TABLE llm_public_alias_t
    ADD CHECK(
        jsonb_typeof(operations)='array'
        AND jsonb_array_length(operations)>0
        AND operations <@ '["generate","embed"]'::jsonb);
CREATE TRIGGER llm_public_alias_embedding_space_immutable_trg
BEFORE UPDATE ON llm_public_alias_t FOR EACH ROW
EXECUTE FUNCTION enforce_llm_public_alias_embedding_space_immutable();

CREATE OR REPLACE VIEW knowledge_qualified_embedding_alias_v AS
SELECT a.host_id,a.host_id AS alias_owner_host_id,a.public_alias_id,a.alias_name,
       a.required_capabilities->'embeddingSpace' AS embedding_space,
       TRUE AS active,a.update_ts,count(*) AS eligible_route_count
  FROM llm_public_alias_t a
  JOIN llm_alias_route_t r ON r.host_id=a.host_id AND r.public_alias_id=a.public_alias_id
                          AND r.active IS TRUE
  JOIN llm_provider_deployment_t d ON d.host_id=r.host_id
                                  AND d.provider_deployment_id=r.provider_deployment_id
                                  AND d.active IS TRUE AND d.lifecycle_status='ACTIVE'
 WHERE a.active IS TRUE AND a.lifecycle_status='ACTIVE' AND a.operations ? 'embed'
   AND a.require_expected_embedding_space IS TRUE
   AND d.provider_protocol='openai_embeddings' AND d.conformance_state='PASS'
   AND d.conformance_valid_until>CURRENT_TIMESTAMP
   AND d.conformance_result->'capabilities'->'embedding'->'space'=
       a.required_capabilities->'embeddingSpace'
 GROUP BY a.host_id,a.public_alias_id,a.alias_name,
          a.required_capabilities->'embeddingSpace',a.update_ts
HAVING bool_and(
    jsonb_array_length(d.conformance_result->'capabilities'->'embedding'->'supportedDimensions')=1
    AND d.conformance_result->'capabilities'->'embedding'->'supportedDimensions'
        @> jsonb_build_array((a.required_capabilities->'embeddingSpace'->>'dimension')::integer)
);

DO $restore_runtime_view$
DECLARE
    saved_view record;
    saved_grant record;
BEGIN
    SELECT * INTO saved_view FROM llm_transport_runtime_view_restore_t;
    IF FOUND THEN
        EXECUTE format('CREATE VIEW %I.%I%s AS %s',
            saved_view.view_schema,saved_view.view_name,
            CASE WHEN saved_view.view_options IS NULL THEN ''
                 ELSE ' WITH (' || saved_view.view_options || ')' END,
            saved_view.view_definition);
        EXECUTE format('ALTER VIEW %I.%I OWNER TO %I',
            saved_view.view_schema,saved_view.view_name,saved_view.view_owner);
        FOR saved_grant IN SELECT * FROM llm_transport_runtime_view_grant_restore_t LOOP
            EXECUTE format('GRANT %s ON TABLE %I.%I TO %s%s',
                saved_grant.privilege_type,saved_view.view_schema,saved_view.view_name,
                CASE WHEN saved_grant.grantee='PUBLIC' THEN 'PUBLIC'
                     ELSE quote_ident(saved_grant.grantee) END,
                CASE WHEN saved_grant.is_grantable THEN ' WITH GRANT OPTION' ELSE '' END);
        END LOOP;
    END IF;
END
$restore_runtime_view$;

ALTER TABLE llm_pricing_version_t
    ADD COLUMN IF NOT EXISTS operation VARCHAR(16);
UPDATE llm_pricing_version_t pricing
   SET operation = CASE WHEN deployment.provider_protocol='openai_embeddings'
                        THEN 'embed' ELSE 'generate' END,
       output_micros_per_million = CASE
           WHEN deployment.provider_protocol='openai_embeddings' THEN NULL
           ELSE pricing.output_micros_per_million END
  FROM llm_provider_deployment_t deployment
 WHERE pricing.host_id=deployment.host_id
   AND pricing.provider_deployment_id=deployment.provider_deployment_id
   AND pricing.operation IS NULL;
ALTER TABLE llm_pricing_version_t
    ALTER COLUMN operation SET NOT NULL,
    ALTER COLUMN output_micros_per_million DROP NOT NULL;
DO $drop_legacy_pricing_unique$
DECLARE
    legacy_constraint name;
BEGIN
    FOR legacy_constraint IN
        SELECT constraint_row.conname
          FROM pg_constraint constraint_row
         WHERE constraint_row.conrelid='llm_pricing_version_t'::regclass
           AND constraint_row.contype='u'
           AND (
               SELECT array_agg(attribute_row.attname::text ORDER BY attribute_row.attname)
                 FROM unnest(constraint_row.conkey) AS key_column(attnum)
                 JOIN pg_attribute attribute_row
                   ON attribute_row.attrelid=constraint_row.conrelid
                  AND attribute_row.attnum=key_column.attnum
           ) IN (
               ARRAY['host_id','pricing_version','provider_deployment_id']::text[],
               ARRAY['host_id','operation','pricing_version','provider_deployment_id']::text[])
    LOOP
        EXECUTE format('ALTER TABLE llm_pricing_version_t DROP CONSTRAINT %I',
                       legacy_constraint);
    END LOOP;
END
$drop_legacy_pricing_unique$;
ALTER TABLE llm_pricing_version_t
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_output_micros_per_million_check,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_check,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_check1,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_check2,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_operation_check,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_t_operation_check1,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_operation_ck,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_rates_ck,
    DROP CONSTRAINT IF EXISTS llm_pricing_version_deployment_operation_version_uq;
ALTER TABLE llm_pricing_version_t
    ADD CHECK(operation IN ('generate','embed')),
    ADD CHECK(output_micros_per_million IS NULL OR output_micros_per_million>=0),
    ADD UNIQUE(host_id,provider_deployment_id,operation,pricing_version),
    ADD CHECK((operation='generate' AND output_micros_per_million IS NOT NULL)
           OR (operation='embed' AND output_micros_per_million IS NULL)),
    ADD CHECK(expires_ts IS NULL OR expires_ts>effective_ts);

CREATE TABLE IF NOT EXISTS llm_network_zone_t (
    host_id UUID NOT NULL,
    network_zone_id UUID NOT NULL,
    zone_name VARCHAR(126) NOT NULL,
    dns_names JSONB NOT NULL DEFAULT '[]'::jsonb,
    cidrs JSONB NOT NULL DEFAULT '[]'::jsonb,
    allowed_ports JSONB NOT NULL DEFAULT '[]'::jsonb,
    allow_private_tls BOOLEAN NOT NULL DEFAULT FALSE,
    allow_private_plaintext BOOLEAN NOT NULL DEFAULT FALSE,
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, network_zone_id),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    UNIQUE(host_id, zone_name),
    CHECK(jsonb_typeof(dns_names) = 'array'),
    CHECK(jsonb_typeof(cidrs) = 'array'),
    CHECK(jsonb_typeof(allowed_ports) = 'array'),
    CHECK(lifecycle_status IN ('DRAFT','ACTIVE','SUSPENDED','RETIRED'))
);

CREATE TABLE IF NOT EXISTS llm_provider_endpoint_t (
    host_id UUID NOT NULL,
    provider_endpoint_id UUID NOT NULL,
    provider_account_id UUID NOT NULL,
    endpoint_name VARCHAR(126) NOT NULL,
    provider_type VARCHAR(32) NOT NULL,
    provider_protocol VARCHAR(32) NOT NULL,
    aws_region VARCHAR(64),
    base_url TEXT NOT NULL,
    headers JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(headers) = 'object'),
    endpoint_auth_mode VARCHAR(16) NOT NULL DEFAULT 'BEARER',
    api_key_header VARCHAR(32),
    network_profile_mode VARCHAR(24) NOT NULL DEFAULT 'PUBLIC_TLS',
    network_termination VARCHAR(32) NOT NULL DEFAULT 'NATIVE',
    network_zone_id UUID,
    trust_bundle_reference VARCHAR(1024),
    trust_bundle_sha256 VARCHAR(64),
    pool_idle_timeout_ms BIGINT NOT NULL DEFAULT 30000,
    client_refresh_interval_ms BIGINT NOT NULL DEFAULT 300000,
    lifecycle_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(host_id, provider_endpoint_id),
    FOREIGN KEY(host_id, provider_account_id)
        REFERENCES llm_provider_account_t(host_id, provider_account_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id, network_zone_id)
        REFERENCES llm_network_zone_t(host_id, network_zone_id) ON DELETE RESTRICT,
    UNIQUE(host_id, endpoint_name),
    CONSTRAINT llm_provider_endpoint_protocol_ck CHECK(
        provider_protocol IN ('openai_chat','openai_responses','openai_embeddings','anthropic_messages','bedrock_converse')),
    CONSTRAINT llm_provider_endpoint_auth_ck CHECK(
        endpoint_auth_mode IN ('NONE','BEARER','API_KEY','BEDROCK_API_KEY','AWS_SIGV4')
        AND (endpoint_auth_mode = 'API_KEY') = (api_key_header IS NOT NULL)
        AND (api_key_header IS NULL OR api_key_header IN ('authorization','x-api-key'))),
    CONSTRAINT llm_provider_endpoint_bedrock_ck CHECK(
        (provider_type = 'aws_bedrock') = (provider_protocol = 'bedrock_converse')
        AND ((provider_type = 'aws_bedrock'
              AND aws_region ~ '^[a-z0-9]+(-[a-z0-9]+)+-[0-9]+$'
              AND endpoint_auth_mode IN ('BEDROCK_API_KEY','AWS_SIGV4'))
          OR (provider_type <> 'aws_bedrock' AND aws_region IS NULL
              AND endpoint_auth_mode NOT IN ('BEDROCK_API_KEY','AWS_SIGV4')))),
    CONSTRAINT llm_provider_endpoint_profile_ck CHECK(
        network_profile_mode IN ('PUBLIC_TLS','PRIVATE_TLS','PRIVATE_PLAINTEXT')
        AND network_termination IN ('NATIVE','LIGHT_GATEWAY_SIDECAR')
        AND ((network_profile_mode = 'PUBLIC_TLS' AND base_url ~ '^https://' AND network_zone_id IS NULL)
          OR (network_profile_mode = 'PRIVATE_TLS' AND base_url ~ '^https://' AND network_zone_id IS NOT NULL)
          OR (network_profile_mode = 'PRIVATE_PLAINTEXT' AND base_url ~ '^http://' AND network_zone_id IS NOT NULL
              AND endpoint_auth_mode = 'NONE'))),
    CONSTRAINT llm_provider_endpoint_trust_ck CHECK(
        (network_profile_mode = 'PRIVATE_TLS') =
        (trust_bundle_reference IS NOT NULL AND trust_bundle_sha256 IS NOT NULL)
        AND (trust_bundle_sha256 IS NULL OR trust_bundle_sha256 ~ '^[0-9a-f]{64}$')),
    CONSTRAINT llm_provider_endpoint_pool_ck CHECK(
        pool_idle_timeout_ms > 0 AND client_refresh_interval_ms >= pool_idle_timeout_ms),
    CHECK(lifecycle_status IN ('DRAFT','VALIDATING','ACTIVE','SUSPENDED','RETIRED'))
);

ALTER TABLE llm_provider_deployment_t
    ADD COLUMN IF NOT EXISTS provider_endpoint_id UUID,
    ADD COLUMN IF NOT EXISTS deployment_revision_id VARCHAR(255),
    ADD COLUMN IF NOT EXISTS physical_runtime_id VARCHAR(255),
    ADD COLUMN IF NOT EXISTS capacity_domain_id VARCHAR(255),
    ADD COLUMN IF NOT EXISTS runtime_capacity JSONB,
    ADD COLUMN IF NOT EXISTS readiness_policy VARCHAR(32),
    ADD COLUMN IF NOT EXISTS expected_sidecar JSONB,
    ADD COLUMN IF NOT EXISTS qualification_contract JSONB,
    ADD COLUMN IF NOT EXISTS bedrock_policy JSONB;

INSERT INTO llm_provider_endpoint_t(
    host_id, provider_endpoint_id, provider_account_id, endpoint_name,
    provider_type, provider_protocol, base_url, endpoint_auth_mode, network_profile_mode,
    network_termination, lifecycle_status, active, update_ts, update_user)
SELECT d.host_id,
       d.provider_deployment_id,
       d.provider_account_id,
       'backfill-' || d.provider_deployment_id::text,
       d.provider_type, d.provider_protocol, rtrim(d.base_url, '/'), 'BEARER', 'PUBLIC_TLS', 'NATIVE',
       CASE WHEN d.lifecycle_status = 'ACTIVE' THEN 'ACTIVE' ELSE 'DRAFT' END,
       d.active, d.update_ts, d.update_user
  FROM llm_provider_deployment_t d
ON CONFLICT(host_id, provider_endpoint_id) DO NOTHING;

UPDATE llm_provider_deployment_t d
   SET provider_endpoint_id = d.provider_deployment_id,
       deployment_revision_id = COALESCE(d.deployment_revision_id,
           d.provider_deployment_id::text || '/r' || d.aggregate_version::text),
       physical_runtime_id = COALESCE(d.physical_runtime_id, 'external/' || d.provider_deployment_id::text),
       capacity_domain_id = COALESCE(d.capacity_domain_id, 'external-account/' || d.provider_account_id::text),
       runtime_capacity = COALESCE(d.runtime_capacity, jsonb_build_object(
           'maxParallelRequests', CASE
               WHEN jsonb_typeof(d.transport_bounds->'concurrency') = 'number'
               THEN GREATEST(32, (d.transport_bounds->>'concurrency')::bigint)
               ELSE 32
           END,
           'maxQueuedRequests', 32,
           'coldStartTimeoutMs', 30000, 'streamSetupTimeoutMs', 10000,
           'requestTimeoutMs', 30000)),
       readiness_policy = COALESCE(d.readiness_policy, 'IMMEDIATE')
 WHERE d.provider_endpoint_id IS NULL;

ALTER TABLE llm_provider_deployment_t
    ALTER COLUMN provider_endpoint_id SET NOT NULL,
    ALTER COLUMN deployment_revision_id SET NOT NULL,
    ALTER COLUMN physical_runtime_id SET NOT NULL,
    ALTER COLUMN capacity_domain_id SET NOT NULL,
    ALTER COLUMN runtime_capacity SET NOT NULL,
    ALTER COLUMN readiness_policy SET NOT NULL;
ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_endpoint_fk,
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_runtime_capacity_ck,
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_readiness_ck,
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_sidecar_shape_ck;
ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_qualification_shape_ck;
ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_bedrock_policy_shape_ck;
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_endpoint_fk
        FOREIGN KEY(host_id, provider_endpoint_id)
        REFERENCES llm_provider_endpoint_t(host_id, provider_endpoint_id) ON DELETE RESTRICT,
    ADD CONSTRAINT llm_provider_deployment_runtime_capacity_ck CHECK(
        jsonb_typeof(runtime_capacity) = 'object'
        AND (runtime_capacity->>'maxParallelRequests') ~ '^[1-9][0-9]*$'
        AND (runtime_capacity->>'maxQueuedRequests') ~ '^[1-9][0-9]*$'
        AND (runtime_capacity->>'coldStartTimeoutMs') ~ '^[1-9][0-9]*$'
        AND (runtime_capacity->>'streamSetupTimeoutMs') ~ '^[1-9][0-9]*$'
        AND (runtime_capacity->>'requestTimeoutMs') ~ '^[1-9][0-9]*$'),
    ADD CONSTRAINT llm_provider_deployment_readiness_ck CHECK(
        readiness_policy IN ('IMMEDIATE','WARM_BEFORE_ELIGIBLE')),
    ADD CONSTRAINT llm_provider_deployment_sidecar_shape_ck CHECK(
        expected_sidecar IS NULL OR jsonb_typeof(expected_sidecar) = 'object'),
    ADD CONSTRAINT llm_provider_deployment_qualification_shape_ck CHECK(
        qualification_contract IS NULL OR jsonb_typeof(qualification_contract) = 'object'),
    ADD CONSTRAINT llm_provider_deployment_bedrock_policy_shape_ck CHECK(
        (provider_protocol = 'bedrock_converse') = (bedrock_policy IS NOT NULL)
        AND (bedrock_policy IS NULL OR jsonb_typeof(bedrock_policy) = 'object'));

ALTER TABLE llm_provider_credential_t
    ALTER COLUMN provider_deployment_id DROP NOT NULL,
    ADD COLUMN IF NOT EXISTS provider_endpoint_id UUID,
    ADD COLUMN IF NOT EXISTS credential_purpose VARCHAR(24) NOT NULL DEFAULT 'ENDPOINT',
    ADD COLUMN IF NOT EXISTS environment VARCHAR(32),
    ADD COLUMN IF NOT EXISTS reasoning_key_id VARCHAR(255),
    ADD COLUMN IF NOT EXISTS reasoning_key_role VARCHAR(16),
    ADD COLUMN IF NOT EXISTS reasoning_key_set_generation BIGINT,
    ADD COLUMN IF NOT EXISTS reasoning_key_set_state VARCHAR(16),
    ADD COLUMN IF NOT EXISTS reasoning_state_limits JSONB;
UPDATE llm_provider_credential_t c
   SET provider_endpoint_id = d.provider_endpoint_id,
       provider_deployment_id = NULL
  FROM llm_provider_deployment_t d
 WHERE c.host_id=d.host_id AND c.provider_deployment_id=d.provider_deployment_id
   AND c.provider_endpoint_id IS NULL;
ALTER TABLE llm_provider_credential_t
    DROP CONSTRAINT IF EXISTS llm_provider_credential_endpoint_fk,
    DROP CONSTRAINT IF EXISTS llm_provider_credential_purpose_ck,
    DROP CONSTRAINT IF EXISTS llm_provider_credential_owner_ck;
ALTER TABLE llm_provider_credential_t
    ADD CONSTRAINT llm_provider_credential_endpoint_fk
        FOREIGN KEY(host_id, provider_endpoint_id)
        REFERENCES llm_provider_endpoint_t(host_id, provider_endpoint_id) ON DELETE RESTRICT,
    ADD CONSTRAINT llm_provider_credential_purpose_ck CHECK(
        credential_purpose IN ('ENDPOINT','SIDECAR_RUNTIME','REASONING_SEAL')),
    ADD CONSTRAINT llm_provider_credential_owner_ck CHECK(
        (credential_purpose = 'ENDPOINT' AND provider_endpoint_id IS NOT NULL
            AND provider_deployment_id IS NULL AND environment IS NULL AND reasoning_key_id IS NULL)
        OR (credential_purpose = 'SIDECAR_RUNTIME' AND provider_deployment_id IS NOT NULL
            AND provider_endpoint_id IS NULL AND environment IS NULL AND reasoning_key_id IS NULL)
        OR (credential_purpose = 'REASONING_SEAL' AND provider_endpoint_id IS NULL
            AND provider_deployment_id IS NULL AND environment IS NOT NULL
            AND reasoning_key_id IS NOT NULL AND reasoning_key_role IN ('CURRENT','PREVIOUS')
            AND reasoning_key_set_generation > 0
            AND reasoning_key_set_state IN ('PREPARED','ACTIVE')
            AND jsonb_typeof(reasoning_state_limits) = 'object'));
CREATE UNIQUE INDEX IF NOT EXISTS llm_provider_credential_endpoint_version_uq
    ON llm_provider_credential_t(host_id, provider_endpoint_id, credential_version)
    WHERE provider_endpoint_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS llm_reasoning_seal_role_generation_uq
    ON llm_provider_credential_t(host_id,environment,reasoning_key_set_generation,reasoning_key_role)
    WHERE credential_purpose='REASONING_SEAL' AND active IS TRUE;
CREATE UNIQUE INDEX IF NOT EXISTS llm_reasoning_seal_key_id_uq
    ON llm_provider_credential_t(host_id,environment,reasoning_key_id)
    WHERE credential_purpose='REASONING_SEAL' AND active IS TRUE;

ALTER TABLE llm_pricing_version_t
    ADD COLUMN IF NOT EXISTS pricing_basis VARCHAR(24) NOT NULL DEFAULT 'EXTERNAL_PROVIDER';
ALTER TABLE llm_pricing_version_t
    DROP CONSTRAINT IF EXISTS llm_pricing_version_basis_ck;
ALTER TABLE llm_pricing_version_t
    ADD CONSTRAINT llm_pricing_version_basis_ck CHECK(
        pricing_basis IN ('EXTERNAL_PROVIDER','ZERO_MARGINAL','AMORTIZED_INTERNAL')
        AND (pricing_basis <> 'ZERO_MARGINAL' OR
             (input_micros_per_million = 0 AND COALESCE(output_micros_per_million, 0) = 0))
        AND (pricing_basis <> 'AMORTIZED_INTERNAL' OR
             (input_micros_per_million > 0 OR COALESCE(output_micros_per_million, 0) > 0)));

ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_pass_result_ck;
ALTER TABLE llm_provider_deployment_t
    ADD CONSTRAINT llm_provider_deployment_pass_result_ck CHECK(
        conformance_state <> 'PASS' OR (
            conformance_result IS NOT NULL
            AND conformance_digest IS NOT NULL
            AND conformance_valid_until IS NOT NULL
            AND conformance_result->>'state' = 'pass'
            AND conformance_result->>'digest' = conformance_digest
            AND conformance_result->>'provider' = provider_protocol
            AND conformance_result->>'physicalModel' = physical_model_id
            AND (conformance_result->>'validUntil')::timestamptz = conformance_valid_until
            AND jsonb_typeof(conformance_result->'capabilities') = 'object'
            AND jsonb_typeof(conformance_result->'capabilityEvidence') = 'object'
            AND ((conformance_result->>'schemaVersion' = '1') OR (
                conformance_result->>'schemaVersion' = '2'
                AND conformance_result->>'evidenceKind' = 'live_endpoint'
                AND length(conformance_result->>'signerKeyId') BETWEEN 1 AND 255
                AND conformance_result->>'signature' ~ '^base64:[A-Za-z0-9+/]+={0,2}$'
                AND jsonb_typeof(conformance_result->'liveEvidence') = 'object'
            ))
        ));

COMMIT;
-- END INLINED patch_20260808_03_llm_local_provider_transport.sql

-- BEGIN INLINED patch_20260810_01_llm_remove_conformance_lifecycle.sql
BEGIN;

-- Preserve the immutable embedding-space contract before retiring live
-- conformance. Existing deployments that route to one exact Alias space can
-- inherit that operator-declared space into the global model declaration.
WITH model_spaces AS (
    SELECT registration.model_id,
           (jsonb_agg(DISTINCT alias.required_capabilities->'embeddingSpace'))->0 AS space
      FROM llm_public_alias_t alias
      JOIN llm_alias_route_t route ON route.host_id=alias.host_id
       AND route.public_alias_id=alias.public_alias_id AND route.active IS TRUE
      JOIN llm_provider_deployment_t deployment ON deployment.host_id=route.host_id
       AND deployment.provider_deployment_id=route.provider_deployment_id
       AND deployment.active IS TRUE AND deployment.provider_protocol='openai_embeddings'
      JOIN llm_model_registration_t registration ON registration.host_id=deployment.host_id
       AND registration.model_registration_id=deployment.model_registration_id
     WHERE alias.active IS TRUE
       AND jsonb_typeof(alias.required_capabilities->'embeddingSpace')='object'
     GROUP BY registration.model_id
    HAVING count(DISTINCT alias.required_capabilities->'embeddingSpace')=1
)
UPDATE llm_model_t model
   SET declared_capabilities=jsonb_set(
       model.declared_capabilities,
       '{embedding}',
       COALESCE(model.declared_capabilities->'embedding','{}'::jsonb)
           || jsonb_build_object('space',spaces.space),
       TRUE)
  FROM model_spaces spaces
 WHERE model.model_id=spaces.model_id
   AND model.operations ? 'embed'
   AND NOT (model.declared_capabilities->'embedding' ? 'space');

-- Lifecycle is no longer an authoring workflow, but terminal historical states
-- still express an operator's intent that a resource must not be published.
-- Preserve that intent through the existing soft-delete flag before dropping
-- the lifecycle columns. Draft/pending/validating rows remain active by design.
DO $preserve_terminal_lifecycle$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_model_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_model_t SET active=FALSE
                     WHERE lifecycle_status IN ('DEPRECATED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_model_registration_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_model_registration_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_provider_account_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_provider_account_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_network_zone_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_network_zone_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_provider_endpoint_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_provider_endpoint_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_provider_credential_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_provider_credential_t SET active=FALSE
                     WHERE lifecycle_status IN ('REVOKED','EXPIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_public_alias_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_public_alias_t SET active=FALSE
                     WHERE lifecycle_status IN ('DEPRECATED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_model_policy_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_model_policy_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid='llm_provider_deployment_t'::regclass
                  AND attname='lifecycle_status' AND NOT attisdropped) THEN
        EXECUTE $sql$UPDATE llm_provider_deployment_t SET active=FALSE
                     WHERE lifecycle_status IN ('SUSPENDED','RETIRED')$sql$;
    END IF;
END
$preserve_terminal_lifecycle$;

-- Preserve dependent views such as knowledge_embedding_profile_runtime_v.
-- The replacement exposes the same columns while releasing its dependencies
-- on the lifecycle and conformance columns before those columns are dropped.
CREATE OR REPLACE VIEW knowledge_qualified_embedding_alias_v AS
SELECT alias.host_id,alias.host_id AS alias_owner_host_id,alias.public_alias_id,alias.alias_name,
       alias.required_capabilities->'embeddingSpace' AS embedding_space,
       TRUE AS active,alias.update_ts,count(*) AS eligible_route_count
  FROM llm_public_alias_t alias
  JOIN llm_alias_route_t route ON route.host_id=alias.host_id
   AND route.public_alias_id=alias.public_alias_id AND route.active IS TRUE
  JOIN llm_provider_deployment_t deployment ON deployment.host_id=route.host_id
   AND deployment.provider_deployment_id=route.provider_deployment_id
   AND deployment.active IS TRUE AND deployment.provider_protocol='openai_embeddings'
  JOIN llm_model_registration_t registration ON registration.host_id=deployment.host_id
   AND registration.model_registration_id=deployment.model_registration_id AND registration.active IS TRUE
  JOIN llm_model_t model ON model.model_id=registration.model_id AND model.active IS TRUE
 WHERE alias.active IS TRUE AND alias.operations ? 'embed'
   AND alias.require_expected_embedding_space IS TRUE
   AND (model.declared_capabilities || registration.capability_restrictions)
       ->'embedding'->'space'=alias.required_capabilities->'embeddingSpace'
 GROUP BY alias.host_id,alias.public_alias_id,alias.alias_name,
          alias.required_capabilities->'embeddingSpace',alias.update_ts
HAVING bool_and(
    jsonb_array_length(COALESCE(
        (model.declared_capabilities || registration.capability_restrictions)
            ->'embedding'->'supportedDimensions',
        (model.declared_capabilities || registration.capability_restrictions)
            ->'embedding'->'dimensions'))=1
    AND COALESCE(
        (model.declared_capabilities || registration.capability_restrictions)
            ->'embedding'->'supportedDimensions',
        (model.declared_capabilities || registration.capability_restrictions)
            ->'embedding'->'dimensions')
        @> jsonb_build_array((alias.required_capabilities->'embeddingSpace'->>'dimension')::integer)
);

DROP INDEX IF EXISTS llm_deployment_conformance_due_idx;

ALTER TABLE llm_model_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_model_registration_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_provider_account_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_network_zone_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_provider_endpoint_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_provider_credential_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_public_alias_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_model_policy_t DROP COLUMN IF EXISTS lifecycle_status;
ALTER TABLE llm_provider_deployment_t
    DROP COLUMN IF EXISTS lifecycle_status,
    DROP COLUMN IF EXISTS conformance_state,
    DROP COLUMN IF EXISTS conformance_digest,
    DROP COLUMN IF EXISTS conformance_valid_until,
    DROP COLUMN IF EXISTS conformance_result,
    DROP COLUMN IF EXISTS qualification_contract,
    DROP COLUMN IF EXISTS refresh_before_seconds;

COMMIT;
-- END INLINED patch_20260810_01_llm_remove_conformance_lifecycle.sql
-- BEGIN LIGHT KNOWLEDGE PHASE 0 CONTRACT SCHEMA
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
    profile_name VARCHAR(255) NOT NULL
        CONSTRAINT knowledge_retrieval_profile_name_ck
        CHECK(length(btrim(profile_name)) > 0),
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
CREATE UNIQUE INDEX knowledge_retrieval_profile_global_name_uq
    ON knowledge_retrieval_profile_t(profile_name)
    WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX knowledge_retrieval_profile_tenant_name_uq
    ON knowledge_retrieval_profile_t(host_id,profile_name)
    WHERE host_id IS NOT NULL AND active IS TRUE;

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
-- END LIGHT KNOWLEDGE PHASE 0 CONTRACT SCHEMA
-- BEGIN LIGHT KNOWLEDGE PHASE 1A OPERATIONAL SCHEMA
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
-- END LIGHT KNOWLEDGE PHASE 1A OPERATIONAL SCHEMA
-- BEGIN LIGHT KNOWLEDGE PHASE 1B OPERATIONAL SCHEMA
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
-- END LIGHT KNOWLEDGE PHASE 1B OPERATIONAL SCHEMA
-- BEGIN LIGHT KNOWLEDGE PHASE 2 ENTERPRISE ACL SCHEMA
-- Light Knowledge Phase 2 enterprise connector and principal ACL schema.
BEGIN;

ALTER TABLE knowledge_job_t
    DROP CONSTRAINT knowledge_job_type_phase1b_ck,
    ADD CONSTRAINT knowledge_job_type_phase2_ck CHECK(job_type IN (
        'SYNC', 'DELTA_SYNC', 'FULL_REINDEX', 'PROMOTE', 'PURGE',
        'RETRIEVAL_TEST', 'CONNECTIVITY_TEST', 'UPLOAD', 'COMPACTION',
        'ANTI_ENTROPY', 'CONNECTOR_SYNC', 'ACL_RECONCILE',
        'PROVIDER_NOTIFICATION'
    ));

CREATE TABLE knowledge_acl_reconciliation_t (
    reconciliation_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    provider VARCHAR(16) NOT NULL CHECK(provider IN ('SHAREPOINT', 'CONFLUENCE')),
    reconciliation_mode VARCHAR(12) NOT NULL
        CHECK(reconciliation_mode IN ('FULL', 'DELTA', 'HINT')),
    state VARCHAR(16) NOT NULL CHECK(state IN (
        'REQUESTED', 'RUNNING', 'COMPLETE', 'FAILED', 'INCOMPLETE'
    )),
    input_cursor_digest CHAR(64)
        CHECK(input_cursor_digest IS NULL OR input_cursor_digest ~ '^[a-f0-9]{64}$'),
    output_cursor_digest CHAR(64)
        CHECK(output_cursor_digest IS NULL OR output_cursor_digest ~ '^[a-f0-9]{64}$'),
    discovered_object_count BIGINT NOT NULL DEFAULT 0 CHECK(discovered_object_count >= 0),
    applied_acl_count BIGINT NOT NULL DEFAULT 0 CHECK(applied_acl_count >= 0),
    denied_object_count BIGINT NOT NULL DEFAULT 0 CHECK(denied_object_count >= 0),
    unresolved_subject_count BIGINT NOT NULL DEFAULT 0 CHECK(unresolved_subject_count >= 0),
    provider_evidence JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(provider_evidence) = 'object'),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    started_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_ts TIMESTAMPTZ,
    fresh_until_ts TIMESTAMPTZ,
    error_code VARCHAR(96),
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(reconciliation_id, knowledge_base_id),
    CHECK(state <> 'COMPLETE' OR (
        finished_ts IS NOT NULL AND fresh_until_ts IS NOT NULL
        AND fresh_until_ts >= finished_ts
        AND fresh_until_ts <= finished_ts + INTERVAL '15 minutes'
        AND unresolved_subject_count = 0
    ))
);
CREATE INDEX knowledge_acl_reconciliation_source_idx
    ON knowledge_acl_reconciliation_t(source_id, started_ts DESC);

CREATE TABLE knowledge_source_acl_state_t (
    source_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    reconciliation_id UUID,
    state VARCHAR(16) NOT NULL CHECK(state IN (
        'PENDING', 'RECONCILING', 'COMPLETE', 'STALE', 'INCOMPLETE'
    )),
    discovered_object_count BIGINT NOT NULL DEFAULT 0 CHECK(discovered_object_count >= 0),
    covered_object_count BIGINT NOT NULL DEFAULT 0 CHECK(covered_object_count >= 0),
    denied_object_count BIGINT NOT NULL DEFAULT 0 CHECK(denied_object_count >= 0),
    unresolved_subject_count BIGINT NOT NULL DEFAULT 0 CHECK(unresolved_subject_count >= 0),
    observed_ts TIMESTAMPTZ,
    fresh_until_ts TIMESTAMPTZ,
    evidence_digest CHAR(64) CHECK(evidence_digest IS NULL
        OR evidence_digest ~ '^[a-f0-9]{64}$'),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(reconciliation_id, knowledge_base_id)
        REFERENCES knowledge_acl_reconciliation_t(reconciliation_id, knowledge_base_id)
        ON DELETE RESTRICT,
    CHECK(state <> 'COMPLETE' OR (
        reconciliation_id IS NOT NULL
        AND observed_ts IS NOT NULL AND fresh_until_ts IS NOT NULL
        AND fresh_until_ts > observed_ts
        AND fresh_until_ts <= observed_ts + INTERVAL '15 minutes'
        AND covered_object_count = discovered_object_count
        AND unresolved_subject_count = 0
    ))
);

CREATE TABLE knowledge_connector_object_t (
    connector_object_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    provider VARCHAR(16) NOT NULL CHECK(provider IN ('SHAREPOINT', 'CONFLUENCE')),
    external_id VARCHAR(1024) NOT NULL,
    provider_version VARCHAR(255) NOT NULL,
    canonical_uri VARCHAR(2048) NOT NULL,
    document_id UUID,
    parent_external_id VARCHAR(1024),
    relationship_kind VARCHAR(16) NOT NULL DEFAULT 'NONE'
        CHECK(relationship_kind IN ('NONE', 'CONTAINMENT', 'REFERENCE')),
    deleted BOOLEAN NOT NULL DEFAULT FALSE,
    last_reconciliation_id UUID NOT NULL,
    observed_ts TIMESTAMPTZ NOT NULL,
    FOREIGN KEY(knowledge_base_id)
        REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(last_reconciliation_id, knowledge_base_id)
        REFERENCES knowledge_acl_reconciliation_t(reconciliation_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(source_id, external_id)
);

CREATE TABLE knowledge_subject_mapping_t (
    subject_mapping_id UUID PRIMARY KEY,
    host_id UUID,
    source_id UUID NOT NULL,
    provider_subject_type VARCHAR(32) NOT NULL,
    provider_subject_id VARCHAR(1024) NOT NULL,
    normalized_subject_type VARCHAR(16) NOT NULL CHECK(normalized_subject_type IN (
        'USER', 'GROUP', 'ORGANIZATION', 'EVERYONE', 'UNRESOLVED'
    )),
    normalized_subject_id VARCHAR(1024),
    mapping_state VARCHAR(16) NOT NULL CHECK(mapping_state IN (
        'APPROVED', 'REVOKED', 'AMBIGUOUS', 'UNRESOLVED'
    )),
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    valid_from_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valid_until_ts TIMESTAMPTZ,
    update_user VARCHAR(255) NOT NULL,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    CHECK((mapping_state = 'APPROVED') = (normalized_subject_id IS NOT NULL))
);
CREATE UNIQUE INDEX knowledge_subject_mapping_global_uk
    ON knowledge_subject_mapping_t(source_id, provider_subject_type, provider_subject_id)
    WHERE host_id IS NULL;
CREATE UNIQUE INDEX knowledge_subject_mapping_tenant_uk
    ON knowledge_subject_mapping_t(host_id, source_id, provider_subject_type, provider_subject_id)
    WHERE host_id IS NOT NULL;

ALTER TABLE knowledge_document_acl_t
    ADD COLUMN reconciliation_id UUID,
    ADD COLUMN provider_effective_decision BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT knowledge_document_acl_reconciliation_fk
        FOREIGN KEY(reconciliation_id, knowledge_base_id)
        REFERENCES knowledge_acl_reconciliation_t(reconciliation_id, knowledge_base_id)
        ON DELETE RESTRICT,
    ADD CONSTRAINT knowledge_document_acl_mirror_evidence_ck CHECK(
        visibility_mode <> 'MIRROR_SOURCE_ACL' OR reconciliation_id IS NOT NULL
    ),
    ADD CONSTRAINT knowledge_document_acl_freshness_ck CHECK(
        visibility_mode <> 'MIRROR_SOURCE_ACL'
        OR fresh_until_ts <= observed_ts + INTERVAL '15 minutes'
    );

CREATE TABLE knowledge_acl_subject_t (
    acl_revision_id UUID NOT NULL,
    subject_ordinal INTEGER NOT NULL CHECK(subject_ordinal >= 0),
    knowledge_base_id UUID NOT NULL,
    document_id UUID NOT NULL,
    provider_subject_type VARCHAR(32) NOT NULL,
    provider_subject_id VARCHAR(1024) NOT NULL,
    normalized_subject_type VARCHAR(16) NOT NULL CHECK(normalized_subject_type IN (
        'USER', 'GROUP', 'ORGANIZATION', 'EVERYONE', 'UNRESOLVED'
    )),
    normalized_subject_id VARCHAR(1024),
    effect VARCHAR(8) NOT NULL CHECK(effect IN ('ALLOW', 'DENY')),
    mapping_complete BOOLEAN NOT NULL,
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    PRIMARY KEY(acl_revision_id, subject_ordinal),
    FOREIGN KEY(acl_revision_id, knowledge_base_id)
        REFERENCES knowledge_document_acl_t(acl_revision_id, knowledge_base_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    CHECK(mapping_complete = (
        normalized_subject_type <> 'UNRESOLVED' AND normalized_subject_id IS NOT NULL
    ))
);
CREATE INDEX knowledge_acl_subject_match_idx
   ON knowledge_acl_subject_t(
       acl_revision_id, effect, normalized_subject_type, normalized_subject_id
   );

CREATE OR REPLACE FUNCTION knowledge_document_acl_authorized(
    p_document_id UUID,
    p_subject_id TEXT,
    p_subject_type TEXT,
    p_groups TEXT[],
    p_organizations TEXT[]
) RETURNS BOOLEAN LANGUAGE sql STABLE AS $function$
    SELECT COALESCE(bool_or(
        source.acl_mode='UNIFORM_SCOPE' OR (
            source.acl_mode='MIRROR_SOURCE_ACL'
            AND acl.visibility_mode='MIRROR_SOURCE_ACL'
            AND acl.completeness_state='COMPLETE'
            AND acl.provider_effective_decision
            AND acl.observed_ts<=now() AND acl.fresh_until_ts>now()
            AND source_acl.state='COMPLETE'
            AND source_acl.observed_ts<=now()
            AND source_acl.fresh_until_ts>now()
            AND source_acl.covered_object_count=source_acl.discovered_object_count
            AND source_acl.unresolved_subject_count=0
            AND NOT EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t unresolved
                 WHERE unresolved.acl_revision_id=acl.acl_revision_id
                   AND (NOT unresolved.mapping_complete
                        OR unresolved.normalized_subject_type='UNRESOLVED')
            )
            AND NOT EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t denied
                 WHERE denied.acl_revision_id=acl.acl_revision_id
                   AND denied.effect='DENY'
                   AND ((denied.normalized_subject_type='EVERYONE'
                         AND denied.normalized_subject_id='*')
                     OR (denied.normalized_subject_type='USER'
                         AND upper(p_subject_type) IN ('USER','PERSON')
                         AND denied.normalized_subject_id=p_subject_id)
                     OR (denied.normalized_subject_type='GROUP'
                         AND denied.normalized_subject_id=ANY(p_groups))
                     OR (denied.normalized_subject_type='ORGANIZATION'
                         AND denied.normalized_subject_id=ANY(p_organizations)))
            )
            AND EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t allowed
                 WHERE allowed.acl_revision_id=acl.acl_revision_id
                   AND allowed.effect='ALLOW'
                   AND ((allowed.normalized_subject_type='EVERYONE'
                         AND allowed.normalized_subject_id='*')
                     OR (allowed.normalized_subject_type='USER'
                         AND upper(p_subject_type) IN ('USER','PERSON')
                         AND allowed.normalized_subject_id=p_subject_id)
                     OR (allowed.normalized_subject_type='GROUP'
                         AND allowed.normalized_subject_id=ANY(p_groups))
                     OR (allowed.normalized_subject_type='ORGANIZATION'
                         AND allowed.normalized_subject_id=ANY(p_organizations)))
            )
        )
    ),FALSE)
      FROM knowledge_document_t document
      JOIN knowledge_source_t source ON source.source_id=document.source_id
      JOIN LATERAL (
        SELECT revision.* FROM knowledge_document_acl_t revision
         WHERE revision.document_id=document.document_id
         ORDER BY revision.acl_sequence DESC LIMIT 1
      ) acl ON TRUE
      LEFT JOIN knowledge_source_acl_state_t source_acl
        ON source_acl.source_id=source.source_id
     WHERE document.document_id=p_document_id
       AND document.lifecycle_state='ACTIVE'
       AND source.status='ACTIVE'
$function$;

CREATE TABLE knowledge_connector_notification_t (
    connector_notification_id UUID PRIMARY KEY,
    source_id UUID NOT NULL,
    provider VARCHAR(16) NOT NULL CHECK(provider IN ('SHAREPOINT', 'CONFLUENCE')),
    provider_notification_id VARCHAR(1024) NOT NULL,
    state VARCHAR(12) NOT NULL CHECK(state IN ('RECEIVED', 'APPLIED', 'DISCARDED')),
    received_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    applied_ts TIMESTAMPTZ,
    evidence_digest CHAR(64) NOT NULL CHECK(evidence_digest ~ '^[a-f0-9]{64}$'),
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id) ON DELETE RESTRICT,
    UNIQUE(source_id, provider_notification_id)
);

GRANT SELECT ON TABLE
    knowledge_source_acl_state_t,
    knowledge_acl_subject_t,
    knowledge_connector_object_t
TO light_knowledge_api_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    knowledge_acl_reconciliation_t,
    knowledge_source_acl_state_t,
    knowledge_connector_object_t,
    knowledge_subject_mapping_t,
    knowledge_acl_subject_t,
    knowledge_connector_notification_t
TO light_knowledge_worker_role;
GRANT UPDATE(reconciliation_id, provider_effective_decision)
    ON TABLE knowledge_document_acl_t TO light_knowledge_worker_role;
GRANT SELECT ON TABLE
    knowledge_acl_reconciliation_t,
    knowledge_source_acl_state_t,
    knowledge_connector_object_t,
    knowledge_subject_mapping_t,
    knowledge_acl_subject_t,
    knowledge_connector_notification_t
TO light_knowledge_ops_read_role;

COMMIT;
-- END LIGHT KNOWLEDGE PHASE 2 ENTERPRISE ACL SCHEMA
-- BEGIN LIGHT KNOWLEDGE PHASE 2 OPERATIONAL HARDENING
-- Light Knowledge Phase 2 operational reconciliation hardening.
BEGIN;

CREATE TABLE knowledge_acl_transition_t (
    acl_transition_id UUID PRIMARY KEY,
    reconciliation_id UUID NOT NULL,
    knowledge_base_id UUID NOT NULL,
    source_id UUID NOT NULL,
    document_id UUID NOT NULL,
    previous_acl_digest CHAR(64) NOT NULL
        CHECK(previous_acl_digest ~ '^[a-f0-9]{64}$'),
    current_acl_digest CHAR(64) NOT NULL
        CHECK(current_acl_digest ~ '^[a-f0-9]{64}$'),
    transition_kind VARCHAR(32) NOT NULL
        CHECK(transition_kind IN ('PERMISSION_CHANGED')),
    observed_ts TIMESTAMPTZ NOT NULL,
    recorded_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(reconciliation_id, knowledge_base_id)
        REFERENCES knowledge_acl_reconciliation_t(
            reconciliation_id, knowledge_base_id
        ) ON DELETE RESTRICT,
    FOREIGN KEY(source_id) REFERENCES knowledge_source_t(source_id)
        ON DELETE RESTRICT,
    FOREIGN KEY(document_id, knowledge_base_id)
        REFERENCES knowledge_document_t(document_id, knowledge_base_id)
        ON DELETE RESTRICT,
    UNIQUE(reconciliation_id, document_id),
    CHECK(previous_acl_digest <> current_acl_digest)
);
CREATE INDEX knowledge_acl_transition_source_idx
    ON knowledge_acl_transition_t(source_id, recorded_ts DESC);

CREATE OR REPLACE FUNCTION prevent_knowledge_acl_mode_downgrade()
RETURNS trigger LANGUAGE plpgsql AS $function$
BEGIN
    IF OLD.acl_mode='MIRROR_SOURCE_ACL'
       AND NEW.acl_mode='UNIFORM_SCOPE' THEN
        RAISE EXCEPTION 'MIRROR_SOURCE_ACL cannot be downgraded in place; create a new source identity';
    END IF;
    RETURN NEW;
END
$function$;
CREATE TRIGGER knowledge_source_acl_mode_fence_trg
BEFORE UPDATE OF acl_mode ON knowledge_source_t
FOR EACH ROW EXECUTE FUNCTION prevent_knowledge_acl_mode_downgrade();

-- A complete source reconciliation is the bounded freshness authority. ACL
-- revisions remain immutable descriptions of the last permission transition;
-- unchanged documents do not need timestamp-only replacement revisions on
-- every provider delta page.
CREATE OR REPLACE FUNCTION knowledge_document_acl_authorized(
    p_document_id UUID,
    p_subject_id TEXT,
    p_subject_type TEXT,
    p_groups TEXT[],
    p_organizations TEXT[]
) RETURNS BOOLEAN LANGUAGE sql STABLE AS $function$
    SELECT COALESCE(bool_or(
        source.acl_mode='UNIFORM_SCOPE' OR (
            source.acl_mode='MIRROR_SOURCE_ACL'
            AND acl.visibility_mode='MIRROR_SOURCE_ACL'
            AND acl.completeness_state='COMPLETE'
            AND acl.provider_effective_decision
            AND source_acl.state='COMPLETE'
            AND source_acl.observed_ts<=now()
            AND source_acl.fresh_until_ts>now()
            AND source_acl.covered_object_count=source_acl.discovered_object_count
            AND source_acl.unresolved_subject_count=0
            AND NOT EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t unresolved
                 WHERE unresolved.acl_revision_id=acl.acl_revision_id
                   AND (NOT unresolved.mapping_complete
                        OR unresolved.normalized_subject_type='UNRESOLVED')
            )
            AND NOT EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t denied
                 WHERE denied.acl_revision_id=acl.acl_revision_id
                   AND denied.effect='DENY'
                   AND ((denied.normalized_subject_type='EVERYONE'
                         AND denied.normalized_subject_id='*')
                     OR (denied.normalized_subject_type='USER'
                         AND upper(p_subject_type) IN ('USER','PERSON')
                         AND denied.normalized_subject_id=p_subject_id)
                     OR (denied.normalized_subject_type='GROUP'
                         AND denied.normalized_subject_id=ANY(p_groups))
                     OR (denied.normalized_subject_type='ORGANIZATION'
                         AND denied.normalized_subject_id=ANY(p_organizations)))
            )
            AND EXISTS (
                SELECT 1 FROM knowledge_acl_subject_t allowed
                 WHERE allowed.acl_revision_id=acl.acl_revision_id
                   AND allowed.effect='ALLOW'
                   AND ((allowed.normalized_subject_type='EVERYONE'
                         AND allowed.normalized_subject_id='*')
                     OR (allowed.normalized_subject_type='USER'
                         AND upper(p_subject_type) IN ('USER','PERSON')
                         AND allowed.normalized_subject_id=p_subject_id)
                     OR (allowed.normalized_subject_type='GROUP'
                         AND allowed.normalized_subject_id=ANY(p_groups))
                     OR (allowed.normalized_subject_type='ORGANIZATION'
                         AND allowed.normalized_subject_id=ANY(p_organizations)))
            )
        )
    ),FALSE)
      FROM knowledge_document_t document
      JOIN knowledge_source_t source ON source.source_id=document.source_id
      JOIN LATERAL (
        SELECT revision.* FROM knowledge_document_acl_t revision
         WHERE revision.document_id=document.document_id
         ORDER BY revision.acl_sequence DESC LIMIT 1
      ) acl ON TRUE
      LEFT JOIN knowledge_source_acl_state_t source_acl
        ON source_acl.source_id=source.source_id
     WHERE document.document_id=p_document_id
       AND document.lifecycle_state='ACTIVE'
       AND source.status='ACTIVE'
$function$;

GRANT SELECT ON TABLE knowledge_acl_transition_t
TO light_knowledge_ops_read_role;
GRANT SELECT, INSERT ON TABLE knowledge_acl_transition_t
TO light_knowledge_worker_role;

COMMIT;
-- END LIGHT KNOWLEDGE PHASE 2 OPERATIONAL HARDENING
-- BEGIN LIGHT KNOWLEDGE PHASE 3 PRODUCTION OPERATIONS
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
-- END LIGHT KNOWLEDGE PHASE 3 PRODUCTION OPERATIONS
-- BEGIN LIGHT KNOWLEDGE PHASE 4 OPTIONAL GRAPH ASSISTED PILOT
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
-- END LIGHT KNOWLEDGE PHASE 4 OPTIONAL GRAPH ASSISTED PILOT
-- BEGIN LIGHT KNOWLEDGE METRICS INDEX ONLINE MIGRATION
-- Additive online correction for databases that applied the released Phase 1a
-- patch before the Knowledge metrics endpoint began counting graph fallbacks.
-- CONCURRENTLY avoids blocking retrieval audit inserts on populated databases.

CREATE INDEX CONCURRENTLY IF NOT EXISTS
    knowledge_query_audit_fallback_created_idx
    ON knowledge_query_audit_t(created_ts DESC)
    WHERE fallback_reason IS NOT NULL;
-- END LIGHT KNOWLEDGE METRICS INDEX ONLINE MIGRATION
-- BEGIN LIGHT KNOWLEDGE SYNC LIFECYCLE
-- Additive operational lifecycle for source sync requests. This preserves the
-- released Phase 1a tables while making accepted and queued work observable.
BEGIN;

ALTER TABLE knowledge_sync_run_t
    DROP CONSTRAINT knowledge_sync_run_t_state_check,
    DROP CONSTRAINT knowledge_sync_run_t_check,
    ALTER COLUMN state SET DEFAULT 'ACCEPTED';

-- Released rows used REQUESTED. Normalize them after removing the old state
-- constraint and before installing the v2 contract.
UPDATE knowledge_sync_run_t SET state='ACCEPTED' WHERE state='REQUESTED';

ALTER TABLE knowledge_sync_run_t
    ADD CONSTRAINT knowledge_sync_run_state_v2_ck CHECK(state IN (
        'ACCEPTED', 'QUEUED', 'RUNNING', 'SUCCEEDED', 'FAILED',
        'PAUSED_BUDGET', 'FAILED_BUDGET', 'CANCELLED'
    )),
    ADD CONSTRAINT knowledge_sync_run_snapshot_watermark_v2_ck CHECK(
        snapshot_watermark IS NULL OR snapshot_watermark >= 0
    ),
    ADD COLUMN job_id UUID,
    ADD COLUMN request_event_id UUID,
    ADD COLUMN index_generation_id UUID,
    ADD COLUMN ingestion_policy_id UUID,
    ADD COLUMN ingestion_policy_version BIGINT,
    ADD COLUMN phase VARCHAR(32) NOT NULL DEFAULT 'ACCEPTED',
    ADD COLUMN progress JSONB NOT NULL DEFAULT '{}'::jsonb
        CHECK(jsonb_typeof(progress) = 'object'),
    ADD COLUMN attempt_count INTEGER NOT NULL DEFAULT 0
        CHECK(attempt_count >= 0),
    ADD COLUMN next_attempt_ts TIMESTAMPTZ,
    ADD COLUMN update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ADD CONSTRAINT knowledge_sync_run_job_fk FOREIGN KEY(job_id)
        REFERENCES knowledge_job_t(job_id) ON DELETE RESTRICT,
    ADD CONSTRAINT knowledge_sync_run_generation_fk
        FOREIGN KEY(index_generation_id)
        REFERENCES knowledge_index_generation_t(index_generation_id)
        ON DELETE RESTRICT,
    ADD CONSTRAINT knowledge_sync_run_policy_fk
        FOREIGN KEY(ingestion_policy_id)
        REFERENCES knowledge_ingestion_policy_t(ingestion_policy_id)
        ON DELETE RESTRICT;

CREATE UNIQUE INDEX knowledge_sync_run_job_uq
    ON knowledge_sync_run_t(job_id) WHERE job_id IS NOT NULL;
CREATE INDEX knowledge_sync_run_base_state_idx
    ON knowledge_sync_run_t(knowledge_base_id,state,requested_ts DESC);

COMMIT;
-- END LIGHT KNOWLEDGE SYNC LIFECYCLE
-- BEGIN WORKFLOW BACKED MCP PHASE 0 CONTRACT
BEGIN;

CREATE TABLE workflow_tool_binding_t (
    host_id UUID NOT NULL,
    binding_id UUID NOT NULL,
    tool_id UUID NOT NULL,
    wf_def_id UUID NOT NULL,
    workflow_version VARCHAR(64) NOT NULL,
    definition_digest VARCHAR(71) NOT NULL CHECK(definition_digest ~ '^sha256:[0-9a-f]{64}$'),
    schema_digest VARCHAR(71) NOT NULL CHECK(schema_digest ~ '^sha256:[0-9a-f]{64}$'),
    invocation_mode VARCHAR(8) NOT NULL CHECK(invocation_mode IN ('sync','async')),
    sync_wait_ms INTEGER NOT NULL CHECK(sync_wait_ms BETWEEN 1 AND 120000),
    total_deadline_ms INTEGER NOT NULL CHECK(total_deadline_ms >= sync_wait_ms),
    execution_class VARCHAR(16) NOT NULL CHECK(execution_class IN ('interactive','standard','batch')),
    result_text_mode VARCHAR(16) NOT NULL CHECK(result_text_mode IN ('compact-json','summary')),
    idempotency_policy JSONB NOT NULL CHECK(jsonb_typeof(idempotency_policy)='object'),
    delegation_policy JSONB NOT NULL CHECK(jsonb_typeof(delegation_policy)='object'),
    response_policy_digest VARCHAR(71) NOT NULL CHECK(response_policy_digest ~ '^sha256:[0-9a-f]{64}$'),
    runtime_bounds JSONB NOT NULL CHECK(jsonb_typeof(runtime_bounds)='object'),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,binding_id),
    UNIQUE(host_id,tool_id,workflow_version),
    FOREIGN KEY(host_id,tool_id) REFERENCES tool_t(host_id,tool_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,wf_def_id) REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,wf_def_id,workflow_version) REFERENCES wf_definition_version_t(host_id,wf_def_id,version) ON DELETE RESTRICT,
    CHECK(invocation_mode <> 'sync' OR execution_class='interactive')
);
CREATE UNIQUE INDEX workflow_tool_binding_active_tool_uq
    ON workflow_tool_binding_t(host_id,tool_id) WHERE active;

-- A Tool granted to a workflow is independent from a Tool implemented by a workflow.
CREATE TABLE workflow_tool_grant_t (
    host_id UUID NOT NULL,
    grant_id UUID NOT NULL,
    tool_id UUID NOT NULL,
    wf_def_id UUID NOT NULL,
    tool_version VARCHAR(20) NOT NULL,
    lightapi_digest VARCHAR(71) NOT NULL CHECK(lightapi_digest ~ '^sha256:[0-9a-f]{64}$'),
    allowed_environments TEXT[] NOT NULL CHECK(cardinality(allowed_environments) > 0),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,grant_id),
    FOREIGN KEY(host_id,tool_id) REFERENCES tool_t(host_id,tool_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,wf_def_id) REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX workflow_tool_grant_active_scope_uq
    ON workflow_tool_grant_t(host_id,tool_id,wf_def_id)
    WHERE active;
CREATE INDEX workflow_tool_grant_callable_idx
    ON workflow_tool_grant_t(host_id,wf_def_id,active,tool_id);

CREATE TABLE workflow_tool_access_request_t (
    host_id UUID NOT NULL,
    request_id UUID NOT NULL,
    target_wf_def_id UUID NOT NULL,
    requester_user_id UUID NOT NULL,
    approval_wf_def_id UUID NOT NULL,
    approval_wf_instance_id VARCHAR(126) NOT NULL,
    approval_definition_digest VARCHAR(71) NOT NULL
        CHECK(approval_definition_digest ~ '^sha256:[0-9a-f]{64}$'),
    request_digest VARCHAR(71) NOT NULL
        CHECK(request_digest ~ '^sha256:[0-9a-f]{64}$'),
    justification VARCHAR(2000) NOT NULL CHECK(length(trim(justification)) > 0),
    status VARCHAR(32) NOT NULL
        CHECK(status IN ('REQUESTED','GRANTED','REJECTED','STALE','CANCELLED','FAILED')),
    decision_user_id UUID,
    decision_comment VARCHAR(2000),
    requested_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    decided_ts TIMESTAMPTZ,
    error_code VARCHAR(64),
    error_message VARCHAR(2000),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    PRIMARY KEY(host_id,request_id),
    UNIQUE(host_id,approval_wf_instance_id),
    FOREIGN KEY(host_id,target_wf_def_id)
        REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,approval_wf_def_id)
        REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT,
    CHECK((status = 'REQUESTED' AND decided_ts IS NULL)
       OR (status <> 'REQUESTED' AND decided_ts IS NOT NULL)),
    CHECK(status NOT IN ('STALE','FAILED') OR error_code IS NOT NULL)
);
CREATE INDEX workflow_tool_access_request_target_idx
    ON workflow_tool_access_request_t(host_id,target_wf_def_id,status);
CREATE INDEX workflow_tool_access_request_requester_idx
    ON workflow_tool_access_request_t(host_id,requester_user_id,status);

CREATE TABLE workflow_tool_access_request_item_t (
    host_id UUID NOT NULL,
    request_id UUID NOT NULL,
    tool_id UUID NOT NULL,
    capability_ref VARCHAR(512) NOT NULL,
    tool_version VARCHAR(20) NOT NULL,
    lightapi_digest VARCHAR(71) NOT NULL
        CHECK(lightapi_digest ~ '^sha256:[0-9a-f]{64}$'),
    allowed_environments TEXT[] NOT NULL
        CHECK(cardinality(allowed_environments) BETWEEN 1 AND 16),
    usage_locations JSONB NOT NULL DEFAULT '[]'::JSONB
        CHECK(jsonb_typeof(usage_locations) = 'array'),
    status VARCHAR(32) NOT NULL
        CHECK(status IN ('REQUESTED','GRANTED','REJECTED','STALE','CANCELLED','FAILED')),
    PRIMARY KEY(host_id,request_id,tool_id),
    UNIQUE(host_id,request_id,capability_ref),
    FOREIGN KEY(host_id,request_id)
        REFERENCES workflow_tool_access_request_t(host_id,request_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id,tool_id)
        REFERENCES tool_t(host_id,tool_id) ON DELETE RESTRICT
);

CREATE TABLE workflow_tool_dependency_t (
    host_id UUID NOT NULL,
    outer_binding_id UUID NOT NULL,
    nested_tool_id UUID NOT NULL,
    nested_tool_version VARCHAR(64) NOT NULL,
    contract_digest VARCHAR(71) NOT NULL CHECK(contract_digest ~ '^sha256:[0-9a-f]{64}$'),
    compatibility_policy VARCHAR(32) NOT NULL CHECK(compatibility_policy IN ('exact','follow-compatible')),
    authorization_tool_name VARCHAR(126) NOT NULL,
    authorization_endpoint_key VARCHAR(255) NOT NULL,
    authorization_policy_digest VARCHAR(71) NOT NULL CHECK(authorization_policy_digest ~ '^sha256:[0-9a-f]{64}$'),
    lifecycle_status VARCHAR(16) NOT NULL CHECK(lifecycle_status IN ('active','superseded','retirement-candidate','revoked')),
    dispatch_target JSONB NOT NULL CHECK(jsonb_typeof(dispatch_target)='object'),
    retention_until TIMESTAMPTZ,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,outer_binding_id,nested_tool_id,nested_tool_version),
    FOREIGN KEY(host_id,outer_binding_id) REFERENCES workflow_tool_binding_t(host_id,binding_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,nested_tool_id) REFERENCES tool_t(host_id,tool_id) ON DELETE RESTRICT
);
CREATE INDEX workflow_tool_dependency_reverse_idx
    ON workflow_tool_dependency_t(host_id,nested_tool_id,active,outer_binding_id);

CREATE TABLE workflow_endpoint_target_t (
    host_id UUID NOT NULL,
    binding_id UUID NOT NULL,
    endpoint_ref VARCHAR(255) NOT NULL,
    endpoint_uri TEXT NOT NULL CHECK(endpoint_uri ~ '^https?://'),
    allowed_methods TEXT[] NOT NULL CHECK(cardinality(allowed_methods) > 0),
    authorization_policy_digest VARCHAR(71) NOT NULL
        CHECK(authorization_policy_digest ~ '^sha256:[0-9a-f]{64}$'),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,endpoint_ref),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE CASCADE,
    FOREIGN KEY(host_id,binding_id) REFERENCES workflow_tool_binding_t(host_id,binding_id) ON DELETE CASCADE,
    CHECK(allowed_methods <@ ARRAY['GET','HEAD','POST','PUT','PATCH','DELETE']::TEXT[])
);

CREATE TABLE workflow_invocation_t (
    host_id UUID NOT NULL,
    workflow_instance_id UUID NOT NULL,
    binding_id UUID NOT NULL,
    process_id UUID,
    stable_tool_ref UUID NOT NULL,
    wf_def_id UUID NOT NULL,
    workflow_version VARCHAR(64) NOT NULL,
    definition_digest VARCHAR(71) NOT NULL CHECK(definition_digest ~ '^sha256:[0-9a-f]{64}$'),
    schema_digest VARCHAR(71) NOT NULL CHECK(schema_digest ~ '^sha256:[0-9a-f]{64}$'),
    policy_digest VARCHAR(71) NOT NULL CHECK(policy_digest ~ '^sha256:[0-9a-f]{64}$'),
    response_policy_digest VARCHAR(71) NOT NULL CHECK(response_policy_digest ~ '^sha256:[0-9a-f]{64}$'),
    principal_subject VARCHAR(255) NOT NULL,
    end_user_subject VARCHAR(255) NOT NULL,
    input JSONB NOT NULL CHECK(jsonb_typeof(input)='object'),
    input_digest VARCHAR(71) NOT NULL CHECK(input_digest ~ '^sha256:[0-9a-f]{64}$'),
    canonical_input_profile VARCHAR(32) NOT NULL CHECK(canonical_input_profile='rfc8785-safe-json-v1'),
    invocation_mode VARCHAR(8) NOT NULL CHECK(invocation_mode IN ('sync','async')),
    execution_class VARCHAR(16) NOT NULL CHECK(execution_class IN ('interactive','standard','batch')),
    permit_depth INTEGER NOT NULL DEFAULT 0 CHECK(permit_depth BETWEEN 0 AND 16),
    state VARCHAR(16) NOT NULL CHECK(state IN ('ACCEPTED','RUNNING','WAITING','COMPLETED','FAILED','CANCELLED')),
    effect_state VARCHAR(16) NOT NULL DEFAULT 'none' CHECK(effect_state IN ('none','possible','confirmed')),
    public_result JSONB,
    normalized_error JSONB,
    correlation_id VARCHAR(255) NOT NULL,
    deadline_ts TIMESTAMPTZ NOT NULL,
    accepted_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    terminal_ts TIMESTAMPTZ,
    state_version BIGINT NOT NULL DEFAULT 1 CHECK(state_version > 0),
    PRIMARY KEY(host_id,workflow_instance_id),
    UNIQUE(host_id,process_id),
    FOREIGN KEY(host_id,binding_id) REFERENCES workflow_tool_binding_t(host_id,binding_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,wf_def_id) REFERENCES wf_definition_t(host_id,wf_def_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,process_id) REFERENCES process_info_t(host_id,process_id) ON DELETE RESTRICT,
    CHECK(invocation_mode <> 'sync' OR execution_class='interactive'),
    CHECK((state IN ('COMPLETED','FAILED','CANCELLED'))=(terminal_ts IS NOT NULL)),
    CHECK(public_result IS NULL OR jsonb_typeof(public_result)='object'),
    CHECK(normalized_error IS NULL OR jsonb_typeof(normalized_error)='object')
);
CREATE INDEX workflow_invocation_subject_idx
    ON workflow_invocation_t(host_id,principal_subject,end_user_subject,accepted_ts DESC);
CREATE INDEX workflow_invocation_state_idx
    ON workflow_invocation_t(host_id,execution_class,state,deadline_ts);

CREATE TABLE workflow_invocation_idempotency_t (
    host_id UUID NOT NULL,
    reservation_id UUID NOT NULL,
    scope_digest VARCHAR(71) NOT NULL CHECK(scope_digest ~ '^sha256:[0-9a-f]{64}$'),
    idempotency_kind VARCHAR(16) NOT NULL CHECK(idempotency_kind IN ('DERIVED','EXPLICIT','BUSINESS')),
    stable_tool_ref UUID NOT NULL,
    principal_subject VARCHAR(255) NOT NULL,
    end_user_subject VARCHAR(255) NOT NULL,
    workflow_instance_id UUID NOT NULL,
    definition_digest VARCHAR(71) NOT NULL CHECK(definition_digest ~ '^sha256:[0-9a-f]{64}$'),
    input_digest VARCHAR(71) NOT NULL CHECK(input_digest ~ '^sha256:[0-9a-f]{64}$'),
    generation BIGINT NOT NULL DEFAULT 1 CHECK(generation > 0),
    in_flight_until TIMESTAMPTZ NOT NULL,
    result_replay_until TIMESTAMPTZ NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,reservation_id),
    CHECK(result_replay_until >= in_flight_until)
);
CREATE UNIQUE INDEX workflow_invocation_idempotency_current_uq
    ON workflow_invocation_idempotency_t(host_id,scope_digest) WHERE active;

CREATE TABLE workflow_invocation_budget_t (
    host_id UUID NOT NULL,
    ledger_id UUID NOT NULL,
    workflow_instance_id UUID NOT NULL,
    generation BIGINT NOT NULL DEFAULT 1 CHECK(generation > 0),
    task_attempt_limit BIGINT NOT NULL CHECK(task_attempt_limit > 0),
    nested_call_limit BIGINT NOT NULL CHECK(nested_call_limit >= 0),
    byte_limit BIGINT NOT NULL CHECK(byte_limit > 0),
    cost_unit_limit BIGINT NOT NULL CHECK(cost_unit_limit >= 0),
    task_attempt_used BIGINT NOT NULL DEFAULT 0 CHECK(task_attempt_used >= 0),
    nested_call_used BIGINT NOT NULL DEFAULT 0 CHECK(nested_call_used >= 0),
    byte_used BIGINT NOT NULL DEFAULT 0 CHECK(byte_used >= 0),
    cost_unit_used BIGINT NOT NULL DEFAULT 0 CHECK(cost_unit_used >= 0),
    task_attempt_reserved BIGINT NOT NULL DEFAULT 0 CHECK(task_attempt_reserved >= 0),
    nested_call_reserved BIGINT NOT NULL DEFAULT 0 CHECK(nested_call_reserved >= 0),
    byte_reserved BIGINT NOT NULL DEFAULT 0 CHECK(byte_reserved >= 0),
    cost_unit_reserved BIGINT NOT NULL DEFAULT 0 CHECK(cost_unit_reserved >= 0),
    deadline_ts TIMESTAMPTZ NOT NULL,
    updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,ledger_id),
    UNIQUE(host_id,workflow_instance_id),
    FOREIGN KEY(host_id,workflow_instance_id) REFERENCES workflow_invocation_t(host_id,workflow_instance_id) ON DELETE RESTRICT,
    CHECK(task_attempt_used+task_attempt_reserved <= task_attempt_limit),
    CHECK(nested_call_used+nested_call_reserved <= nested_call_limit),
    CHECK(byte_used+byte_reserved <= byte_limit),
    CHECK(cost_unit_used+cost_unit_reserved <= cost_unit_limit)
);

CREATE TABLE workflow_invocation_budget_reservation_t (
    host_id UUID NOT NULL,
    reservation_id UUID NOT NULL,
    ledger_id UUID NOT NULL,
    generation BIGINT NOT NULL CHECK(generation > 0),
    fencing_token BIGINT NOT NULL CHECK(fencing_token > 0),
    task_attempts BIGINT NOT NULL CHECK(task_attempts >= 0),
    nested_calls BIGINT NOT NULL CHECK(nested_calls >= 0),
    reserved_bytes BIGINT NOT NULL CHECK(reserved_bytes >= 0),
    reserved_cost_units BIGINT NOT NULL CHECK(reserved_cost_units >= 0),
    actual_bytes BIGINT,
    actual_cost_units BIGINT,
    state VARCHAR(16) NOT NULL CHECK(state IN ('RESERVED','RECONCILED','RELEASED')),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reconciled_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,reservation_id),
    FOREIGN KEY(host_id,ledger_id) REFERENCES workflow_invocation_budget_t(host_id,ledger_id) ON DELETE RESTRICT,
    CHECK(actual_bytes IS NULL OR actual_bytes BETWEEN 0 AND reserved_bytes),
    CHECK(actual_cost_units IS NULL OR actual_cost_units BETWEEN 0 AND reserved_cost_units)
);

CREATE TABLE workflow_invocation_event_quarantine_t (
    host_id UUID NOT NULL,
    quarantine_id UUID NOT NULL,
    consumer_group VARCHAR(255) NOT NULL,
    partition_id INTEGER NOT NULL,
    source_offset BIGINT NOT NULL,
    aggregate_id VARCHAR(255) NOT NULL,
    aggregate_version BIGINT NOT NULL,
    transaction_id UUID,
    payload_digest VARCHAR(71) NOT NULL CHECK(payload_digest ~ '^sha256:[0-9a-f]{64}$'),
    encrypted_payload BYTEA,
    immutable_payload_reference TEXT,
    failure_code VARCHAR(126) NOT NULL,
    failure_detail TEXT NOT NULL,
    attempt_count INTEGER NOT NULL DEFAULT 0 CHECK(attempt_count >= 0),
    repaired_by VARCHAR(255),
    repair_reason TEXT,
    replay_state VARCHAR(16) NOT NULL DEFAULT 'BLOCKED' CHECK(replay_state IN ('BLOCKED','REPAIRED','REPLAYED','DISCARDED')),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,quarantine_id),
    UNIQUE(consumer_group,partition_id,source_offset),
    CHECK((encrypted_payload IS NOT NULL) <> (immutable_payload_reference IS NOT NULL))
);
CREATE INDEX workflow_invocation_quarantine_aggregate_idx
    ON workflow_invocation_event_quarantine_t(host_id,aggregate_id,aggregate_version);

CREATE TABLE workflow_invocation_audit_outbox_t (
    host_id UUID NOT NULL,
    event_id UUID NOT NULL,
    workflow_instance_id UUID NOT NULL,
    event_type VARCHAR(126) NOT NULL,
    payload JSONB NOT NULL CHECK(jsonb_typeof(payload)='object'),
    correlation_id VARCHAR(255) NOT NULL,
    event_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,event_id),
    UNIQUE(host_id,workflow_instance_id,event_type),
    FOREIGN KEY(host_id,workflow_instance_id) REFERENCES workflow_invocation_t(host_id,workflow_instance_id) ON DELETE RESTRICT
);
CREATE INDEX workflow_invocation_audit_pending_idx
    ON workflow_invocation_audit_outbox_t(event_ts,event_id) WHERE published_ts IS NULL;

CREATE OR REPLACE FUNCTION workflow_claim_idempotency_v1(
    p_host_id UUID, p_reservation_id UUID, p_scope_digest VARCHAR,
    p_idempotency_kind VARCHAR, p_stable_tool_ref UUID,
    p_principal_subject VARCHAR, p_end_user_subject VARCHAR,
    p_workflow_instance_id UUID, p_definition_digest VARCHAR,
    p_input_digest VARCHAR, p_in_flight_until TIMESTAMPTZ,
    p_result_replay_until TIMESTAMPTZ
) RETURNS TABLE(outcome VARCHAR, accepted_workflow_instance_id UUID, accepted_generation BIGINT)
LANGUAGE plpgsql AS $body$
DECLARE current_row workflow_invocation_idempotency_t%ROWTYPE;
BEGIN
    INSERT INTO workflow_invocation_idempotency_t(
        host_id,reservation_id,scope_digest,idempotency_kind,stable_tool_ref,
        principal_subject,end_user_subject,workflow_instance_id,
        definition_digest,input_digest,in_flight_until,result_replay_until
    ) VALUES(
        p_host_id,p_reservation_id,p_scope_digest,p_idempotency_kind,
        p_stable_tool_ref,p_principal_subject,p_end_user_subject,
        p_workflow_instance_id,p_definition_digest,p_input_digest,
        p_in_flight_until,p_result_replay_until
    ) ON CONFLICT(host_id,scope_digest) WHERE active DO NOTHING;
    IF FOUND THEN
        RETURN QUERY SELECT 'ACCEPTED'::VARCHAR,p_workflow_instance_id,1::BIGINT;
        RETURN;
    END IF;
    SELECT * INTO current_row FROM workflow_invocation_idempotency_t
     WHERE host_id=p_host_id AND scope_digest=p_scope_digest AND active FOR UPDATE;
    IF current_row.stable_tool_ref=p_stable_tool_ref
       AND current_row.principal_subject=p_principal_subject
       AND current_row.end_user_subject=p_end_user_subject
       AND current_row.definition_digest=p_definition_digest
       AND current_row.input_digest=p_input_digest THEN
        IF current_row.result_replay_until>CURRENT_TIMESTAMP THEN
            RETURN QUERY SELECT 'REPLAY'::VARCHAR,current_row.workflow_instance_id,current_row.generation;
            RETURN;
        END IF;
        UPDATE workflow_invocation_idempotency_t SET
            active=FALSE,updated_ts=CURRENT_TIMESTAMP
         WHERE host_id=p_host_id AND reservation_id=current_row.reservation_id;
        INSERT INTO workflow_invocation_idempotency_t(
            host_id,reservation_id,scope_digest,idempotency_kind,stable_tool_ref,
            principal_subject,end_user_subject,workflow_instance_id,
            definition_digest,input_digest,generation,in_flight_until,result_replay_until
        ) VALUES(
            p_host_id,p_reservation_id,p_scope_digest,p_idempotency_kind,
            p_stable_tool_ref,p_principal_subject,p_end_user_subject,
            p_workflow_instance_id,p_definition_digest,p_input_digest,
            current_row.generation+1,p_in_flight_until,p_result_replay_until
        );
        RETURN QUERY SELECT 'ACCEPTED'::VARCHAR,p_workflow_instance_id,current_row.generation+1;
    ELSE
        RETURN QUERY SELECT 'CONFLICT'::VARCHAR,current_row.workflow_instance_id,current_row.generation;
    END IF;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_reserve_budget_v1(
    p_host_id UUID, p_ledger_id UUID, p_reservation_id UUID,
    p_generation BIGINT, p_fencing_token BIGINT,
    p_task_attempts BIGINT, p_nested_calls BIGINT,
    p_bytes BIGINT, p_cost_units BIGINT
) RETURNS BOOLEAN LANGUAGE plpgsql AS $body$
DECLARE existing workflow_invocation_budget_reservation_t%ROWTYPE;
BEGIN
    IF p_task_attempts < 0 OR p_nested_calls < 0 OR p_bytes < 0 OR p_cost_units < 0
       OR p_fencing_token <= 0 THEN
        RAISE EXCEPTION 'WORKFLOW_BUDGET_INVALID_RESERVATION';
    END IF;
    SELECT * INTO existing FROM workflow_invocation_budget_reservation_t
     WHERE host_id=p_host_id AND reservation_id=p_reservation_id FOR UPDATE;
    IF FOUND THEN
        IF existing.ledger_id=p_ledger_id AND existing.generation=p_generation
           AND existing.fencing_token=p_fencing_token
           AND existing.task_attempts=p_task_attempts
           AND existing.nested_calls=p_nested_calls
           AND existing.reserved_bytes=p_bytes
           AND existing.reserved_cost_units=p_cost_units THEN
            RETURN existing.state IN ('RESERVED','RECONCILED');
        END IF;
        RAISE EXCEPTION 'WORKFLOW_BUDGET_RESERVATION_CONFLICT';
    END IF;
    UPDATE workflow_invocation_budget_t SET
        task_attempt_reserved=task_attempt_reserved+p_task_attempts,
        nested_call_reserved=nested_call_reserved+p_nested_calls,
        byte_reserved=byte_reserved+p_bytes,
        cost_unit_reserved=cost_unit_reserved+p_cost_units,
        updated_ts=CURRENT_TIMESTAMP
     WHERE host_id=p_host_id AND ledger_id=p_ledger_id
       AND generation=p_generation AND deadline_ts>CURRENT_TIMESTAMP
       AND task_attempt_used+task_attempt_reserved+p_task_attempts<=task_attempt_limit
       AND nested_call_used+nested_call_reserved+p_nested_calls<=nested_call_limit
       AND byte_used+byte_reserved+p_bytes<=byte_limit
       AND cost_unit_used+cost_unit_reserved+p_cost_units<=cost_unit_limit;
    IF NOT FOUND THEN RETURN FALSE; END IF;
    INSERT INTO workflow_invocation_budget_reservation_t(
        host_id,reservation_id,ledger_id,generation,fencing_token,
        task_attempts,nested_calls,reserved_bytes,reserved_cost_units,state
    ) VALUES(p_host_id,p_reservation_id,p_ledger_id,p_generation,p_fencing_token,
             p_task_attempts,p_nested_calls,p_bytes,p_cost_units,'RESERVED');
    RETURN TRUE;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_reconcile_budget_v1(
    p_host_id UUID, p_reservation_id UUID, p_fencing_token BIGINT,
    p_actual_bytes BIGINT, p_actual_cost_units BIGINT
) RETURNS BOOLEAN LANGUAGE plpgsql AS $body$
DECLARE reservation workflow_invocation_budget_reservation_t%ROWTYPE;
BEGIN
    SELECT * INTO reservation FROM workflow_invocation_budget_reservation_t
     WHERE host_id=p_host_id AND reservation_id=p_reservation_id FOR UPDATE;
    IF NOT FOUND OR reservation.fencing_token<>p_fencing_token THEN RETURN FALSE; END IF;
    IF reservation.state='RECONCILED' THEN
        RETURN reservation.actual_bytes=p_actual_bytes
           AND reservation.actual_cost_units=p_actual_cost_units;
    END IF;
    IF reservation.state<>'RESERVED' OR p_actual_bytes<0 OR p_actual_cost_units<0
       OR p_actual_bytes>reservation.reserved_bytes
       OR p_actual_cost_units>reservation.reserved_cost_units THEN RETURN FALSE; END IF;
    UPDATE workflow_invocation_budget_t SET
        task_attempt_reserved=task_attempt_reserved-reservation.task_attempts,
        nested_call_reserved=nested_call_reserved-reservation.nested_calls,
        byte_reserved=byte_reserved-reservation.reserved_bytes,
        cost_unit_reserved=cost_unit_reserved-reservation.reserved_cost_units,
        task_attempt_used=task_attempt_used+reservation.task_attempts,
        nested_call_used=nested_call_used+reservation.nested_calls,
        byte_used=byte_used+p_actual_bytes,
        cost_unit_used=cost_unit_used+p_actual_cost_units,
        updated_ts=CURRENT_TIMESTAMP
     WHERE host_id=p_host_id AND ledger_id=reservation.ledger_id
       AND generation=reservation.generation;
    IF NOT FOUND THEN RETURN FALSE; END IF;
    UPDATE workflow_invocation_budget_reservation_t SET
        state='RECONCILED',actual_bytes=p_actual_bytes,
        actual_cost_units=p_actual_cost_units,reconciled_ts=CURRENT_TIMESTAMP
     WHERE host_id=p_host_id AND reservation_id=p_reservation_id;
    RETURN TRUE;
END
$body$;

REVOKE ALL ON FUNCTION workflow_reserve_budget_v1(UUID,UUID,UUID,BIGINT,BIGINT,BIGINT,BIGINT,BIGINT,BIGINT) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_reconcile_budget_v1(UUID,UUID,BIGINT,BIGINT,BIGINT) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_claim_idempotency_v1(UUID,UUID,VARCHAR,VARCHAR,UUID,VARCHAR,VARCHAR,UUID,VARCHAR,VARCHAR,TIMESTAMPTZ,TIMESTAMPTZ) FROM PUBLIC;

COMMIT;
-- END WORKFLOW BACKED MCP PHASE 0 CONTRACT
-- BEGIN WORKFLOW BACKED MCP PHASE 1 RUNTIME
BEGIN;

ALTER TABLE workflow_tool_binding_t
    ADD COLUMN policy_digest VARCHAR(71)
        CHECK(policy_digest ~ '^sha256:[0-9a-f]{64}$');
UPDATE workflow_tool_binding_t
   SET policy_digest=response_policy_digest
 WHERE policy_digest IS NULL;
ALTER TABLE workflow_tool_binding_t ALTER COLUMN policy_digest SET NOT NULL;

ALTER TABLE workflow_invocation_t
    ADD COLUMN subject_claims JSONB NOT NULL DEFAULT '{}'::JSONB
        CHECK(jsonb_typeof(subject_claims)='object');

ALTER TABLE workflow_invocation_budget_t
    ADD COLUMN request_byte_limit BIGINT NOT NULL DEFAULT 1048576
        CHECK(request_byte_limit>0),
    ADD COLUMN result_byte_limit BIGINT NOT NULL DEFAULT 1048576
        CHECK(result_byte_limit>0);

ALTER TABLE task_info_t
    ADD COLUMN execution_class VARCHAR(16) NOT NULL DEFAULT 'standard',
    ADD COLUMN lease_owner UUID,
    ADD COLUMN lease_fencing_token BIGINT NOT NULL DEFAULT 0,
    ADD COLUMN lease_expires_ts TIMESTAMPTZ;
ALTER TABLE task_info_t ADD CONSTRAINT task_info_execution_class_v1_ck
    CHECK(execution_class IN ('interactive','standard','batch'));
ALTER TABLE task_info_t ADD CONSTRAINT task_info_host_lease_v1_ck CHECK(
    lease_fencing_token>=0 AND
    ((locked='N' AND lease_owner IS NULL AND lease_expires_ts IS NULL)
     OR (locked='Y' AND ((lease_owner IS NULL AND lease_expires_ts IS NULL)
                         OR (lease_owner IS NOT NULL AND lease_expires_ts IS NOT NULL))))
) NOT VALID;
CREATE INDEX task_info_host_fair_claim_v1_idx
    ON task_info_t(execution_class,priority DESC,started_ts,host_id,task_id)
    WHERE active AND execution_placement='host' AND status_code IN ('A','C');

CREATE TABLE workflow_executor_tenant_turn_t (
    host_id UUID PRIMARY KEY REFERENCES host_t(host_id) ON DELETE CASCADE,
    last_claim_ts TIMESTAMPTZ NOT NULL DEFAULT '-infinity',
    claim_count BIGINT NOT NULL DEFAULT 0 CHECK(claim_count>=0),
    updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION notify_workflow_task_ready_v1()
RETURNS TRIGGER LANGUAGE plpgsql AS $body$
BEGIN
    IF NEW.active AND NEW.execution_placement='host'
       AND (NEW.status_code='A' OR
            (NEW.status_code='C' AND NEW.task_type='ask' AND NEW.completed_ts IS NOT NULL
             AND (NEW.task_output IS NULL OR NEW.task_output->>'status'='waiting_for_input'))) THEN
        PERFORM pg_notify('workflow_task_ready_v1',
            json_build_object('hostId',NEW.host_id,'taskId',NEW.task_id,
                              'executionClass',NEW.execution_class)::text);
    END IF;
    RETURN NEW;
END
$body$;
CREATE TRIGGER workflow_task_ready_v1_trg
AFTER INSERT OR UPDATE OF status_code,completed_ts,task_output ON task_info_t
FOR EACH ROW EXECUTE FUNCTION notify_workflow_task_ready_v1();

CREATE OR REPLACE FUNCTION notify_workflow_invocation_state_v1()
RETURNS TRIGGER LANGUAGE plpgsql AS $body$
BEGIN
    IF NEW.state_version IS DISTINCT FROM OLD.state_version THEN
        PERFORM pg_notify('workflow_invocation_state_v1',
            json_build_object('hostId',NEW.host_id,
                              'workflowInstanceId',NEW.workflow_instance_id,
                              'stateVersion',NEW.state_version)::text);
    END IF;
    RETURN NEW;
END
$body$;
CREATE TRIGGER workflow_invocation_state_v1_trg
AFTER UPDATE OF state_version ON workflow_invocation_t
FOR EACH ROW EXECUTE FUNCTION notify_workflow_invocation_state_v1();

CREATE OR REPLACE FUNCTION guard_quarantined_workflow_outbox_v1()
RETURNS TRIGGER LANGUAGE plpgsql AS $body$
BEGIN
    IF EXISTS(
        SELECT 1 FROM workflow_invocation_event_quarantine_t quarantine
         WHERE quarantine.source_offset=OLD.c_offset
           AND quarantine.replay_state='BLOCKED'
    ) THEN
        RAISE EXCEPTION 'WORKFLOW_QUARANTINE_OUTBOX_RETENTION_REQUIRED';
    END IF;
    RETURN OLD;
END
$body$;
CREATE TRIGGER workflow_quarantined_outbox_retention_v1_trg
BEFORE DELETE ON outbox_message_t
FOR EACH ROW EXECUTE FUNCTION guard_quarantined_workflow_outbox_v1();

CREATE OR REPLACE FUNCTION workflow_claim_host_task_v1(
    p_worker_id UUID,
    p_lease_ms INTEGER
) RETURNS TABLE(
    host_id UUID,task_id UUID,task_type VARCHAR,process_id UUID,
    wf_instance_id VARCHAR,wf_task_id VARCHAR,status_code CHAR,result_code VARCHAR,
    lease_owner UUID,lease_fencing_token BIGINT,lease_expires_ts TIMESTAMPTZ
) LANGUAGE plpgsql AS $body$
DECLARE claimed_host UUID;
BEGIN
    IF p_lease_ms<100 OR p_lease_ms>30000 THEN
        RAISE EXCEPTION 'WORKFLOW_HOST_LEASE_MS_OUT_OF_RANGE';
    END IF;
    SELECT candidates.host_id INTO claimed_host
      FROM (
        SELECT t.host_id,
               MIN(CASE t.execution_class WHEN 'interactive' THEN 0 WHEN 'standard' THEN 1 ELSE 2 END) AS class_rank,
               MAX(t.priority) AS maximum_priority,
               MIN(t.started_ts) AS oldest_task
          FROM task_info_t t
         WHERE t.active AND t.execution_placement='host'
           AND ((t.status_code='A' AND t.task_type IN ('ask','assert','call','set','switch'))
             OR (t.status_code='C' AND t.task_type='ask' AND t.completed_ts IS NOT NULL
                 AND (t.task_output IS NULL OR t.task_output->>'status'='waiting_for_input')))
           AND (t.locked='N' OR (t.locked='Y' AND t.lease_expires_ts<=CURRENT_TIMESTAMP))
           AND (t.deadline_ts IS NULL OR t.deadline_ts>CURRENT_TIMESTAMP)
         GROUP BY t.host_id
      ) candidates
      LEFT JOIN workflow_executor_tenant_turn_t turn ON turn.host_id=candidates.host_id
     ORDER BY candidates.class_rank,
              COALESCE(turn.last_claim_ts,'-infinity'::timestamptz),
              candidates.maximum_priority DESC,candidates.oldest_task,candidates.host_id
     LIMIT 1;
    IF claimed_host IS NULL THEN RETURN; END IF;
    IF NOT pg_try_advisory_xact_lock(hashtext(claimed_host::text)) THEN RETURN; END IF;

    INSERT INTO workflow_executor_tenant_turn_t(host_id,last_claim_ts,claim_count)
    VALUES(claimed_host,CURRENT_TIMESTAMP,1)
    ON CONFLICT ON CONSTRAINT workflow_executor_tenant_turn_t_pkey DO UPDATE SET
        last_claim_ts=EXCLUDED.last_claim_ts,
        claim_count=workflow_executor_tenant_turn_t.claim_count+1,
        updated_ts=CURRENT_TIMESTAMP;

    RETURN QUERY
    WITH candidate AS (
        SELECT t.host_id,t.task_id
          FROM task_info_t t
         WHERE t.host_id=claimed_host AND t.active AND t.execution_placement='host'
           AND ((t.status_code='A' AND t.task_type IN ('ask','assert','call','set','switch'))
             OR (t.status_code='C' AND t.task_type='ask' AND t.completed_ts IS NOT NULL
                 AND (t.task_output IS NULL OR t.task_output->>'status'='waiting_for_input')))
           AND (t.locked='N' OR (t.locked='Y' AND t.lease_expires_ts<=CURRENT_TIMESTAMP))
           AND (t.deadline_ts IS NULL OR t.deadline_ts>CURRENT_TIMESTAMP)
         ORDER BY CASE t.execution_class WHEN 'interactive' THEN 0 WHEN 'standard' THEN 1 ELSE 2 END,
                  t.priority DESC,t.started_ts,t.task_id
         LIMIT 1 FOR UPDATE SKIP LOCKED
    )
    UPDATE task_info_t t SET
        locked='Y',lease_owner=p_worker_id,
        lease_fencing_token=t.lease_fencing_token+1,
        lease_expires_ts=LEAST(COALESCE(t.deadline_ts,'infinity'::timestamptz),
                               CURRENT_TIMESTAMP+make_interval(secs=>p_lease_ms::double precision/1000.0)),
        update_ts=CURRENT_TIMESTAMP
      FROM candidate c
     WHERE t.host_id=c.host_id AND t.task_id=c.task_id
    RETURNING t.host_id,t.task_id,t.task_type,t.process_id,t.wf_instance_id,
              t.wf_task_id,t.status_code,t.result_code,t.lease_owner,
              t.lease_fencing_token,t.lease_expires_ts;
END
$body$;

REVOKE ALL ON FUNCTION workflow_claim_host_task_v1(UUID,INTEGER) FROM PUBLIC;

COMMIT;
-- END WORKFLOW BACKED MCP PHASE 1 RUNTIME
-- BEGIN WORKFLOW BACKED MCP PHASE 2 ORCHESTRATION
BEGIN;

ALTER TABLE workflow_invocation_t
    ADD COLUMN cancellation_policy VARCHAR(32) NOT NULL DEFAULT 'BEFORE_EFFECTS_ONLY'
        CHECK(cancellation_policy IN ('BEFORE_EFFECTS_ONLY','COOPERATIVE','DISABLED')),
    ADD COLUMN cancel_requested_ts TIMESTAMPTZ,
    ADD COLUMN non_cancellable_reason TEXT,
    ADD COLUMN response_policy_snapshot JSONB NOT NULL DEFAULT '{}'::JSONB
        CHECK(jsonb_typeof(response_policy_snapshot)='object');
ALTER TABLE workflow_invocation_t DROP CONSTRAINT workflow_invocation_t_state_check;
ALTER TABLE workflow_invocation_t ADD CONSTRAINT workflow_invocation_state_v2_ck
    CHECK(state IN ('ACCEPTED','RUNNING','WAITING','COMPENSATING','COMPLETED','FAILED','CANCELLED'));

ALTER TABLE task_info_t
    ADD COLUMN attempt_no INTEGER NOT NULL DEFAULT 1 CHECK(attempt_no>0),
    ADD COLUMN maximum_attempts INTEGER NOT NULL DEFAULT 1 CHECK(maximum_attempts>0),
    ADD COLUMN next_attempt_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN effect_state VARCHAR(16) NOT NULL DEFAULT 'none'
        CHECK(effect_state IN ('none','possible','confirmed')),
    ADD COLUMN downstream_idempotency_key VARCHAR(255),
    ADD COLUMN compensation_task VARCHAR(255),
    ADD COLUMN is_compensation BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN fork_join_id UUID,
    ADD COLUMN branch_name VARCHAR(255);
CREATE INDEX task_info_phase2_claim_idx
    ON task_info_t(execution_class,next_attempt_ts,priority DESC,started_ts,host_id)
    WHERE active AND execution_placement='host' AND status_code IN ('A','C');

CREATE TABLE workflow_fork_join_t (
    host_id UUID NOT NULL,
    join_id UUID NOT NULL,
    workflow_instance_id UUID NOT NULL,
    process_id UUID NOT NULL,
    fork_task_id UUID NOT NULL,
    fork_task_name VARCHAR(255) NOT NULL,
    continuation_task VARCHAR(255),
    compete BOOLEAN NOT NULL DEFAULT FALSE,
    expected_branches INTEGER NOT NULL CHECK(expected_branches BETWEEN 1 AND 64),
    completed_branches INTEGER NOT NULL DEFAULT 0 CHECK(completed_branches>=0),
    failed_branches INTEGER NOT NULL DEFAULT 0 CHECK(failed_branches>=0),
    state VARCHAR(16) NOT NULL DEFAULT 'RUNNING'
        CHECK(state IN ('RUNNING','COMPLETED','FAILED','CANCELLED')),
    branch_results JSONB NOT NULL DEFAULT '{}'::JSONB CHECK(jsonb_typeof(branch_results)='object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,join_id),
    UNIQUE(host_id,fork_task_id),
    FOREIGN KEY(host_id,workflow_instance_id)
        REFERENCES workflow_invocation_t(host_id,workflow_instance_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,process_id) REFERENCES process_info_t(host_id,process_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,fork_task_id) REFERENCES task_info_t(host_id,task_id) ON DELETE RESTRICT
);

CREATE TABLE workflow_fork_branch_t (
    host_id UUID NOT NULL,
    join_id UUID NOT NULL,
    branch_name VARCHAR(255) NOT NULL,
    task_id UUID NOT NULL,
    state VARCHAR(16) NOT NULL DEFAULT 'RUNNING'
        CHECK(state IN ('RUNNING','COMPLETED','FAILED','CANCELLED')),
    result JSONB,
    completed_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,join_id,branch_name),
    UNIQUE(host_id,task_id),
    FOREIGN KEY(host_id,join_id) REFERENCES workflow_fork_join_t(host_id,join_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,task_id) REFERENCES task_info_t(host_id,task_id) ON DELETE RESTRICT
);

CREATE TABLE workflow_tool_approval_evidence_t (
    host_id UUID NOT NULL,
    binding_id UUID NOT NULL,
    task_name VARCHAR(255) NOT NULL,
    evidence_digest VARCHAR(71) NOT NULL CHECK(evidence_digest ~ '^sha256:[0-9a-f]{64}$'),
    approved_by VARCHAR(255) NOT NULL,
    approved_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY(host_id,binding_id,task_name,evidence_digest),
    FOREIGN KEY(host_id,binding_id)
        REFERENCES workflow_tool_binding_t(host_id,binding_id) ON DELETE RESTRICT
);


CREATE TABLE workflow_task_effect_t (
    host_id UUID NOT NULL,
    workflow_instance_id UUID NOT NULL,
    task_name VARCHAR(255) NOT NULL,
    idempotency_key VARCHAR(255) NOT NULL,
    request_digest VARCHAR(71) NOT NULL CHECK(request_digest ~ '^sha256:[0-9a-f]{64}$'),
    effect_state VARCHAR(16) NOT NULL DEFAULT 'possible'
        CHECK(effect_state IN ('possible','confirmed')),
    result JSONB,
    first_attempt_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    confirmed_ts TIMESTAMPTZ,
    PRIMARY KEY(host_id,workflow_instance_id,task_name,idempotency_key),
    FOREIGN KEY(host_id,workflow_instance_id)
        REFERENCES workflow_invocation_t(host_id,workflow_instance_id) ON DELETE RESTRICT
);

CREATE OR REPLACE FUNCTION workflow_claim_task_effect_v1(
    p_host_id UUID,p_workflow_instance_id UUID,p_task_name VARCHAR,
    p_idempotency_key VARCHAR,p_request_digest VARCHAR
) RETURNS TABLE(claimed BOOLEAN,replayed BOOLEAN,result JSONB,effect_state VARCHAR)
LANGUAGE plpgsql AS $body$
DECLARE existing workflow_task_effect_t%ROWTYPE;
BEGIN
    INSERT INTO workflow_task_effect_t(
        host_id,workflow_instance_id,task_name,idempotency_key,request_digest)
    VALUES(p_host_id,p_workflow_instance_id,p_task_name,p_idempotency_key,p_request_digest)
    ON CONFLICT DO NOTHING;
    SELECT * INTO existing FROM workflow_task_effect_t
     WHERE host_id=p_host_id AND workflow_instance_id=p_workflow_instance_id
       AND task_name=p_task_name AND idempotency_key=p_idempotency_key FOR UPDATE;
    IF existing.request_digest<>p_request_digest THEN
        RAISE EXCEPTION 'WORKFLOW_TASK_IDEMPOTENCY_CONFLICT';
    END IF;
    RETURN QUERY SELECT existing.confirmed_ts IS NULL,existing.confirmed_ts IS NOT NULL,
                        existing.result,existing.effect_state;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_confirm_task_effect_v1(
    p_host_id UUID,p_workflow_instance_id UUID,p_task_name VARCHAR,
    p_idempotency_key VARCHAR,p_request_digest VARCHAR,p_result JSONB
) RETURNS BOOLEAN LANGUAGE plpgsql AS $body$
BEGIN
    UPDATE workflow_task_effect_t SET effect_state='confirmed',result=p_result,
           confirmed_ts=COALESCE(confirmed_ts,CURRENT_TIMESTAMP)
     WHERE host_id=p_host_id AND workflow_instance_id=p_workflow_instance_id
       AND task_name=p_task_name AND idempotency_key=p_idempotency_key
       AND request_digest=p_request_digest;
    RETURN FOUND;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_claim_host_task_v1(
    p_worker_id UUID,p_lease_ms INTEGER
) RETURNS TABLE(
    host_id UUID,task_id UUID,task_type VARCHAR,process_id UUID,
    wf_instance_id VARCHAR,wf_task_id VARCHAR,status_code CHAR,result_code VARCHAR,
    lease_owner UUID,lease_fencing_token BIGINT,lease_expires_ts TIMESTAMPTZ
) LANGUAGE plpgsql AS $body$
DECLARE claimed_host UUID;
BEGIN
    IF p_lease_ms<100 OR p_lease_ms>30000 THEN RAISE EXCEPTION 'WORKFLOW_HOST_LEASE_MS_OUT_OF_RANGE'; END IF;
    SELECT candidates.host_id INTO claimed_host FROM (
        SELECT t.host_id,
               MIN(CASE t.execution_class WHEN 'interactive' THEN 0 WHEN 'standard' THEN 1 ELSE 2 END) class_rank,
               MAX(t.priority) maximum_priority,MIN(t.started_ts) oldest_task
          FROM task_info_t t
         WHERE t.active AND t.execution_placement='host'
           AND ((t.status_code='A' AND t.task_type IN ('ask','assert','call','set','switch','fork'))
             OR (t.status_code='C' AND t.task_type='ask' AND t.completed_ts IS NOT NULL
                 AND (t.task_output IS NULL OR t.task_output->>'status'='waiting_for_input')))
           AND t.next_attempt_ts<=CURRENT_TIMESTAMP
           AND (t.effect_state='none' OR t.downstream_idempotency_key IS NOT NULL)
           AND (t.locked='N' OR (t.locked='Y' AND t.lease_expires_ts<=CURRENT_TIMESTAMP))
           AND (t.deadline_ts IS NULL OR t.deadline_ts>CURRENT_TIMESTAMP)
         GROUP BY t.host_id
    ) candidates LEFT JOIN workflow_executor_tenant_turn_t turn ON turn.host_id=candidates.host_id
    ORDER BY candidates.class_rank,COALESCE(turn.last_claim_ts,'-infinity'::timestamptz),
             candidates.maximum_priority DESC,candidates.oldest_task,candidates.host_id LIMIT 1;
    IF claimed_host IS NULL THEN RETURN; END IF;
    IF NOT pg_try_advisory_xact_lock(hashtext(claimed_host::text)) THEN RETURN; END IF;
    INSERT INTO workflow_executor_tenant_turn_t(host_id,last_claim_ts,claim_count)
    VALUES(claimed_host,CURRENT_TIMESTAMP,1)
    ON CONFLICT ON CONSTRAINT workflow_executor_tenant_turn_t_pkey DO UPDATE SET
      last_claim_ts=EXCLUDED.last_claim_ts,claim_count=workflow_executor_tenant_turn_t.claim_count+1,
      updated_ts=CURRENT_TIMESTAMP;
    RETURN QUERY WITH candidate AS (
      SELECT t.host_id,t.task_id FROM task_info_t t
       WHERE t.host_id=claimed_host AND t.active AND t.execution_placement='host'
         AND ((t.status_code='A' AND t.task_type IN ('ask','assert','call','set','switch','fork'))
           OR (t.status_code='C' AND t.task_type='ask' AND t.completed_ts IS NOT NULL
               AND (t.task_output IS NULL OR t.task_output->>'status'='waiting_for_input')))
         AND t.next_attempt_ts<=CURRENT_TIMESTAMP
         AND (t.effect_state='none' OR t.downstream_idempotency_key IS NOT NULL)
         AND (t.locked='N' OR (t.locked='Y' AND t.lease_expires_ts<=CURRENT_TIMESTAMP))
         AND (t.deadline_ts IS NULL OR t.deadline_ts>CURRENT_TIMESTAMP)
       ORDER BY CASE t.execution_class WHEN 'interactive' THEN 0 WHEN 'standard' THEN 1 ELSE 2 END,
                t.priority DESC,t.started_ts,t.task_id LIMIT 1 FOR UPDATE SKIP LOCKED
    ) UPDATE task_info_t t SET locked='Y',lease_owner=p_worker_id,
      lease_fencing_token=t.lease_fencing_token+1,
      lease_expires_ts=LEAST(COALESCE(t.deadline_ts,'infinity'::timestamptz),
        CURRENT_TIMESTAMP+make_interval(secs=>p_lease_ms::double precision/1000.0)),update_ts=CURRENT_TIMESTAMP
      FROM candidate c WHERE t.host_id=c.host_id AND t.task_id=c.task_id
    RETURNING t.host_id,t.task_id,t.task_type,t.process_id,t.wf_instance_id,t.wf_task_id,
              t.status_code,t.result_code,t.lease_owner,t.lease_fencing_token,t.lease_expires_ts;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_promote_tool_binding_v1(
    p_host_id UUID,p_tool_id UUID,p_binding_id UUID
) RETURNS BOOLEAN LANGUAGE plpgsql AS $body$
DECLARE current_mode VARCHAR; target_mode VARCHAR; affected BIGINT;
BEGIN
    PERFORM pg_advisory_xact_lock(hashtext(p_host_id::text||':'||p_tool_id::text));
    SELECT invocation_mode INTO current_mode FROM workflow_tool_binding_t
     WHERE host_id=p_host_id AND tool_id=p_tool_id AND active FOR UPDATE;
    SELECT invocation_mode INTO target_mode FROM workflow_tool_binding_t
     WHERE host_id=p_host_id AND tool_id=p_tool_id AND binding_id=p_binding_id FOR UPDATE;
    IF target_mode IS NULL THEN RAISE EXCEPTION 'WORKFLOW_BINDING_NOT_FOUND'; END IF;
    IF current_mode IS NOT NULL AND current_mode<>target_mode THEN
        RAISE EXCEPTION 'WORKFLOW_BINDING_MODE_CHANGE_REQUIRES_NEW_TOOL';
    END IF;
    UPDATE workflow_tool_binding_t SET active=FALSE,aggregate_version=aggregate_version+1,
           update_ts=CURRENT_TIMESTAMP WHERE host_id=p_host_id AND tool_id=p_tool_id AND active;
    UPDATE workflow_tool_binding_t SET active=TRUE,aggregate_version=aggregate_version+1,
           update_ts=CURRENT_TIMESTAMP WHERE host_id=p_host_id AND binding_id=p_binding_id;
    GET DIAGNOSTICS affected=ROW_COUNT;
    RETURN affected=1;
END
$body$;

CREATE OR REPLACE FUNCTION workflow_set_nested_target_lifecycle_v1(
    p_host_id UUID,p_nested_tool_id UUID,p_nested_tool_version VARCHAR,
    p_lifecycle_status VARCHAR,p_emergency_revocation BOOLEAN,p_impact_report_digest VARCHAR
) RETURNS BIGINT LANGUAGE plpgsql AS $body$
DECLARE active_references BIGINT; affected BIGINT;
BEGIN
    IF p_lifecycle_status NOT IN ('active','superseded','retirement-candidate','revoked') THEN
        RAISE EXCEPTION 'WORKFLOW_NESTED_TARGET_LIFECYCLE_INVALID';
    END IF;
    IF p_impact_report_digest !~ '^sha256:[0-9a-f]{64}$' THEN
        RAISE EXCEPTION 'WORKFLOW_IMPACT_REPORT_DIGEST_INVALID';
    END IF;
    PERFORM pg_advisory_xact_lock(hashtext(p_host_id::text||':'||p_nested_tool_id::text));
    SELECT count(*) INTO active_references FROM workflow_tool_dependency_t dependency
      JOIN workflow_tool_binding_t binding ON binding.host_id=dependency.host_id
       AND binding.binding_id=dependency.outer_binding_id
     WHERE dependency.host_id=p_host_id AND dependency.nested_tool_id=p_nested_tool_id
       AND dependency.nested_tool_version=p_nested_tool_version
       AND dependency.active AND binding.active;
    IF p_lifecycle_status='retirement-candidate' AND active_references>0 THEN
        RAISE EXCEPTION 'WORKFLOW_NESTED_TARGET_STILL_REFERENCED:%',active_references;
    END IF;
    IF p_lifecycle_status='revoked' AND NOT p_emergency_revocation THEN
        RAISE EXCEPTION 'WORKFLOW_EMERGENCY_REVOCATION_CONFIRMATION_REQUIRED';
    END IF;
    UPDATE workflow_tool_dependency_t SET lifecycle_status=p_lifecycle_status,
           dispatch_target=jsonb_set(dispatch_target,'{impactReportDigest}',to_jsonb(p_impact_report_digest),TRUE),
           update_ts=CURRENT_TIMESTAMP
     WHERE host_id=p_host_id AND nested_tool_id=p_nested_tool_id
       AND nested_tool_version=p_nested_tool_version;
    GET DIAGNOSTICS affected=ROW_COUNT;
    RETURN affected;
END
$body$;

REVOKE ALL ON FUNCTION workflow_claim_task_effect_v1(UUID,UUID,VARCHAR,VARCHAR,VARCHAR) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_confirm_task_effect_v1(UUID,UUID,VARCHAR,VARCHAR,VARCHAR,JSONB) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_claim_host_task_v1(UUID,INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_promote_tool_binding_v1(UUID,UUID,UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION workflow_set_nested_target_lifecycle_v1(UUID,UUID,VARCHAR,VARCHAR,BOOLEAN,VARCHAR) FROM PUBLIC;

COMMIT;
-- END WORKFLOW BACKED MCP PHASE 2 ORCHESTRATION
-- BEGIN WORKFLOW BACKED MCP PHASE 4 SKILL INTEGRATION
BEGIN;

ALTER TABLE workflow_tool_binding_t
    ADD CONSTRAINT workflow_tool_binding_skill_target_uq
        UNIQUE(host_id,binding_id,wf_def_id,tool_id);

ALTER TABLE skill_workflow_t
    ADD COLUMN workflow_binding_id UUID,
    ADD COLUMN workflow_tool_id UUID,
    ADD CONSTRAINT skill_workflow_binding_pair_ck
        CHECK((workflow_binding_id IS NULL)=(workflow_tool_id IS NULL)),
    ADD CONSTRAINT skill_workflow_binding_target_fk
        FOREIGN KEY(host_id,workflow_binding_id,wf_def_id,workflow_tool_id)
        REFERENCES workflow_tool_binding_t(host_id,binding_id,wf_def_id,tool_id)
        ON DELETE RESTRICT,
    ADD CONSTRAINT skill_workflow_disclosed_tool_fk
        FOREIGN KEY(host_id,skill_id,workflow_tool_id)
        REFERENCES skill_tool_t(host_id,skill_id,tool_id)
        ON DELETE RESTRICT;

CREATE INDEX skill_workflow_binding_idx
    ON skill_workflow_t(host_id,workflow_binding_id)
    WHERE workflow_binding_id IS NOT NULL;

COMMIT;
-- END WORKFLOW BACKED MCP PHASE 4 SKILL INTEGRATION
-- BEGIN INLINED patch_20260813_02_gateway_tool_publication.sql
BEGIN;

CREATE TABLE gateway_tool_publication_t (
    host_id UUID NOT NULL,
    publication_id UUID NOT NULL,
    instance_id UUID NOT NULL,
    property_id UUID NOT NULL,
    publication_version BIGINT NOT NULL CHECK(publication_version > 0),
    publication_mode VARCHAR(32) NOT NULL
        CHECK(publication_mode IN ('ADD_OR_UPDATE','REPLACE_API_SCOPE')),
    scope_api_version_id UUID,
    candidate_digest VARCHAR(71) NOT NULL
        CHECK(candidate_digest ~ '^sha256:[0-9a-f]{64}$'),
    compiled_tools JSONB NOT NULL CHECK(jsonb_typeof(compiled_tools)='array'),
    bindings JSONB NOT NULL CHECK(jsonb_typeof(bindings)='array'),
    aggregate_version BIGINT NOT NULL DEFAULT 1 CHECK(aggregate_version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,publication_id),
    UNIQUE(host_id,instance_id,publication_version),
    FOREIGN KEY(host_id,instance_id)
        REFERENCES instance_t(host_id,instance_id) ON DELETE RESTRICT,
    FOREIGN KEY(property_id)
        REFERENCES config_property_t(property_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,scope_api_version_id)
        REFERENCES api_version_t(host_id,api_version_id) ON DELETE RESTRICT,
    CHECK((publication_mode='REPLACE_API_SCOPE')=(scope_api_version_id IS NOT NULL))
);
CREATE INDEX gateway_tool_publication_instance_idx
    ON gateway_tool_publication_t(host_id,instance_id,publication_version DESC);

CREATE TABLE gateway_tool_binding_t (
    host_id UUID NOT NULL,
    instance_id UUID NOT NULL,
    tool_id UUID NOT NULL,
    publication_id UUID NOT NULL,
    publication_version BIGINT NOT NULL CHECK(publication_version > 0),
    source_type VARCHAR(16) NOT NULL CHECK(source_type IN ('ENDPOINT','WORKFLOW')),
    source_aggregate_version BIGINT NOT NULL CHECK(source_aggregate_version > 0),
    source_tool_version VARCHAR(20),
    api_version_id UUID,
    endpoint_id UUID,
    stable_tool_ref UUID,
    workflow_binding_id UUID,
    workflow_definition_id UUID,
    workflow_version VARCHAR(64),
    definition_digest VARCHAR(71),
    schema_digest VARCHAR(71),
    policy_digest VARCHAR(71),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    delete_user VARCHAR(126),
    delete_ts TIMESTAMPTZ,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(host_id,instance_id,tool_id),
    FOREIGN KEY(host_id,instance_id)
        REFERENCES instance_t(host_id,instance_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,publication_id)
        REFERENCES gateway_tool_publication_t(host_id,publication_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,tool_id)
        REFERENCES tool_t(host_id,tool_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,api_version_id)
        REFERENCES api_version_t(host_id,api_version_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,endpoint_id)
        REFERENCES api_endpoint_t(host_id,endpoint_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,workflow_binding_id)
        REFERENCES workflow_tool_binding_t(host_id,binding_id) ON DELETE RESTRICT,
    FOREIGN KEY(host_id,workflow_definition_id,workflow_version)
        REFERENCES wf_definition_version_t(host_id,wf_def_id,version) ON DELETE RESTRICT,
    CHECK(
        (source_type='ENDPOINT' AND api_version_id IS NOT NULL AND endpoint_id IS NOT NULL
            AND stable_tool_ref IS NULL AND workflow_binding_id IS NULL)
        OR
        (source_type='WORKFLOW' AND api_version_id IS NULL AND endpoint_id IS NULL
            AND stable_tool_ref IS NOT NULL AND workflow_binding_id IS NOT NULL
            AND workflow_definition_id IS NOT NULL AND workflow_version IS NOT NULL
            AND definition_digest ~ '^sha256:[0-9a-f]{64}$'
            AND schema_digest ~ '^sha256:[0-9a-f]{64}$'
            AND policy_digest ~ '^sha256:[0-9a-f]{64}$')
    )
);
CREATE INDEX gateway_tool_binding_source_idx
    ON gateway_tool_binding_t(host_id,instance_id,source_type,api_version_id,active);

COMMIT;
-- END INLINED patch_20260813_02_gateway_tool_publication.sql
-- BEGIN WORKFLOW EVENT FORK COMPATIBILITY
BEGIN;

-- Event-started workflows own a process_info_t row but intentionally do not
-- fabricate a workflow-backed MCP invocation. The existing process FK remains
-- the durable ownership boundary for both invocation and event entry points.
ALTER TABLE workflow_fork_join_t
    DROP CONSTRAINT IF EXISTS workflow_fork_join_t_host_id_workflow_instance_id_fkey;

COMMIT;
-- END WORKFLOW EVENT FORK COMPATIBILITY
-- BEGIN WORKFLOW USER AUTHORIZATION PASS THROUGH
BEGIN;

-- The current end-user bearer credential is kept separate from workflow
-- definitions, inputs, events, and snapshots. It is used only by a
-- workflow-backed invocation when dispatching a protected API request.
-- An active pre-upgrade invocation cannot be backfilled safely because its
-- original user credential was never persisted. Drain or cancel it first.
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
          FROM workflow_invocation_t
         WHERE state NOT IN ('CANCELLED','COMPLETED','FAILED')
    ) THEN
        RAISE EXCEPTION
            'active workflow invocations must be drained or cancelled before adding user authorization pass-through';
    END IF;
END $$;

ALTER TABLE workflow_invocation_t
    ADD COLUMN user_authorization TEXT
        CHECK(user_authorization IS NULL OR user_authorization ~ '^Bearer [^[:space:]]+$'),
    ADD COLUMN user_authorization_exp BIGINT
        CHECK(user_authorization_exp IS NULL OR user_authorization_exp > 0);

COMMENT ON COLUMN workflow_invocation_t.user_authorization IS
    'Ephemeral initiating-user bearer credential for workflow HTTP calls; cleared at terminal state';
COMMENT ON COLUMN workflow_invocation_t.user_authorization_exp IS
    'JWT expiration used to prevent an older lifecycle credential from replacing a newer one';

COMMIT;
-- END WORKFLOW USER AUTHORIZATION PASS THROUGH

-- BEGIN LIGHT KNOWLEDGE SINGLE CONTAINER
BEGIN;

ALTER TABLE knowledge_embedding_profile_t
    ADD COLUMN alias_name VARCHAR(255) NOT NULL DEFAULT 'kb-index',
    ADD CONSTRAINT knowledge_embedding_profile_alias_name_ck
        CHECK(length(trim(alias_name)) > 0);

CREATE TABLE IF NOT EXISTS knowledge_projection_source_cursor_t (
    consumer_group VARCHAR(160) PRIMARY KEY,
    last_event_ts TIMESTAMPTZ NOT NULL,
    last_event_id UUID NOT NULL,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK(length(trim(consumer_group)) > 0)
);

CREATE OR REPLACE FUNCTION notify_knowledge_job_eligible()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.state = 'QUEUED'
       AND (NEW.next_attempt_ts IS NULL OR NEW.next_attempt_ts <= CURRENT_TIMESTAMP)
       AND (TG_OP = 'INSERT'
            OR OLD.state IS DISTINCT FROM NEW.state
            OR OLD.next_attempt_ts IS DISTINCT FROM NEW.next_attempt_ts) THEN
        PERFORM pg_notify('knowledge_job_channel', NEW.job_id::text);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER knowledge_job_eligible_notify_trg
AFTER INSERT OR UPDATE OF state, next_attempt_ts ON knowledge_job_t
FOR EACH ROW EXECUTE FUNCTION notify_knowledge_job_eligible();

GRANT SELECT, INSERT, UPDATE ON TABLE knowledge_projection_source_cursor_t
    TO light_knowledge_portal_projector_role;

COMMIT;
-- END LIGHT KNOWLEDGE SINGLE CONTAINER

-- BEGIN INLINED patch_20260819_01_light_agent_policy_snapshot_pointer.sql
BEGIN;

ALTER TABLE agent_definition_t
    ADD COLUMN IF NOT EXISTS policy_snapshot_id UUID;

UPDATE agent_definition_t definition
   SET policy_snapshot_id = snapshot.policy_snapshot_id
  FROM agent_policy_snapshot_t snapshot
 WHERE definition.policy_snapshot_id IS NULL
   AND definition.policy_digest IS NOT NULL
   AND snapshot.host_id = definition.host_id
   AND snapshot.agent_def_id = definition.agent_def_id
   AND snapshot.policy_digest = definition.policy_digest
   AND snapshot.revoked_ts IS NULL;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
          FROM agent_definition_t definition
         WHERE definition.policy_digest IS NOT NULL
           AND definition.policy_snapshot_id IS NULL
    ) THEN
        RAISE EXCEPTION
            'agent definitions with a policy digest must resolve to one active policy snapshot before upgrade';
    END IF;
END $$;

ALTER TABLE agent_definition_t
    DROP CONSTRAINT IF EXISTS agent_definition_policy_snapshot_fk;
ALTER TABLE agent_policy_snapshot_t
    DROP CONSTRAINT IF EXISTS agent_policy_snapshot_agent_identity_uk;
ALTER TABLE agent_policy_snapshot_t
    ADD CONSTRAINT agent_policy_snapshot_agent_identity_uk
    UNIQUE(host_id, agent_def_id, policy_snapshot_id);

ALTER TABLE agent_definition_t
    ADD CONSTRAINT agent_definition_policy_snapshot_fk
    FOREIGN KEY(host_id, agent_def_id, policy_snapshot_id)
    REFERENCES agent_policy_snapshot_t(host_id, agent_def_id, policy_snapshot_id)
    ON DELETE RESTRICT;

COMMIT;
-- END INLINED patch_20260819_01_light_agent_policy_snapshot_pointer.sql


\set ON_ERROR_STOP on

-- Policy-driven cascade deletion.
--
-- Every relationship is explicitly classified in cascade_relationship_policy_t.
-- The generic trigger contains no domain table names.

BEGIN;

CREATE TABLE IF NOT EXISTS cascade_relationship_policy_t (
    parent_schema       VARCHAR(63) NOT NULL DEFAULT 'public',
    parent_table        VARCHAR(63) NOT NULL,
    child_schema        VARCHAR(63) NOT NULL DEFAULT 'public',
    child_table         VARCHAR(63) NOT NULL,
    constraint_name     VARCHAR(63) NOT NULL,
    delete_action       VARCHAR(16) NOT NULL,
    restore_action      VARCHAR(16) NOT NULL DEFAULT 'NONE',
    policy_description  VARCHAR(1024),
    update_user         VARCHAR(255) NOT NULL DEFAULT SESSION_USER,
    update_ts           TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (
        parent_schema,
        parent_table,
        child_schema,
        child_table,
        constraint_name
    ),
    CHECK (delete_action IN ('SOFT_DELETE', 'HARD_DELETE', 'IGNORE')),
    CHECK (restore_action IN ('RESTORE', 'NONE')),
    CHECK (
        (delete_action = 'SOFT_DELETE' AND restore_action = 'RESTORE')
        OR (delete_action IN ('HARD_DELETE', 'IGNORE') AND restore_action = 'NONE')
    )
);

DROP VIEW IF EXISTS cascade_relationships_v;

ALTER TABLE cascade_relationship_policy_t
    DROP COLUMN IF EXISTS enabled;

CREATE TEMP TABLE cascade_relationship_policy_seed_t
(LIKE cascade_relationship_policy_t INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
ON COMMIT DROP;

INSERT INTO cascade_relationship_policy_seed_t (
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    constraint_name,
    delete_action,
    restore_action,
    policy_description
)
VALUES
('public', 'api_endpoint_scope_t', 'public', 'app_api_t', 'app_api_t_host_id_endpoint_id_scope_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'api_endpoint_rule_t', 'endpoint_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'api_endpoint_scope_t', 'api_ver_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'attribute_col_filter_t', 'attribute_col_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'attribute_permission_t', 'attribute_permission_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'attribute_row_filter_t', 'attribute_row_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'gateway_tool_binding_t', 'gateway_tool_binding_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'group_col_filter_t', 'group_col_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'group_permission_t', 'group_permission_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'group_row_filter_t', 'group_row_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'position_col_filter_t', 'position_col_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'position_permission_t', 'position_permission_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'position_row_filter_t', 'position_row_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'role_col_filter_t', 'role_col_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'role_permission_t', 'role_permission_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'role_row_filter_t', 'role_row_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'user_col_filter_t', 'user_col_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'user_permission_t', 'user_permission_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'user_row_filter_t', 'user_row_filter_t_host_id_endpoint_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_endpoint_t', 'public', 'tool_t', 'tool_t_host_id_endpoint_id_fkey', 'IGNORE', 'NONE', 'Tool lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'api_t', 'public', 'api_version_t', 'api_version_t_host_id_api_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_t', 'public', 'auth_provider_api_t', 'auth_provider_api_t_host_id_api_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_version_t', 'public', 'api_endpoint_t', 'api_endpoint_t_host_id_api_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_version_t', 'public', 'agent_definition_t', 'agent_definition_api_version_fk', 'IGNORE', 'NONE', 'Agent definition lifecycle is command-owned and independently audited'),
    ('public', 'api_version_t', 'public', 'auth_client_owner_t', 'auth_client_owner_t_host_id_api_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_version_t', 'public', 'auth_client_t', 'auth_client_t_host_id_api_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_version_t', 'public', 'gateway_tool_binding_t', 'gateway_tool_binding_t_host_id_api_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'api_version_t', 'public', 'gateway_tool_publication_t', 'gateway_tool_publication_t_host_id_scope_api_version_id_fkey', 'IGNORE', 'NONE', 'Publication lifecycle is immutable and command-owned'),
    ('public', 'api_version_t', 'public', 'instance_api_t', 'instance_api_t_host_id_api_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'app_t', 'public', 'app_api_t', 'app_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'app_t', 'public', 'auth_client_owner_t', 'auth_client_owner_t_host_id_app_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'app_t', 'public', 'auth_client_t', 'auth_client_t_host_id_app_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'app_t', 'public', 'instance_app_t', 'instance_app_t_host_id_app_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'attribute_t', 'public', 'attribute_col_filter_t', 'attribute_col_filter_t_host_id_attribute_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'attribute_t', 'public', 'attribute_permission_t', 'attribute_permission_t_host_id_attribute_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'attribute_t', 'public', 'attribute_row_filter_t', 'attribute_row_filter_t_host_id_attribute_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'attribute_t', 'public', 'attribute_user_t', 'attribute_user_t_host_id_attribute_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'auth_client_owner_t', 'public', 'auth_client_t', 'auth_client_t_host_id_owner_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'auth_client_t', 'public', 'auth_client_token_t', 'auth_client_token_t_host_id_client_id_fkey', 'HARD_DELETE', 'NONE', 'Non-restorable authentication runtime state'),
    ('public', 'auth_client_t', 'public', 'auth_provider_client_t', 'auth_provider_client_t_host_id_client_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'auth_client_t', 'public', 'auth_ref_token_t', 'auth_ref_token_t_host_id_client_id_fkey', 'HARD_DELETE', 'NONE', 'Client deactivation revokes stored bearer JWT reference tokens'),
    ('public', 'auth_provider_client_t', 'public', 'auth_code_t', 'auth_code_t_auth_host_id_client_id_provider_id_fkey', 'HARD_DELETE', 'NONE', 'Non-restorable authentication runtime state'),
    ('public', 'auth_provider_client_t', 'public', 'auth_refresh_token_t', 'auth_refresh_token_t_auth_host_id_client_id_provider_id_fkey', 'HARD_DELETE', 'NONE', 'Non-restorable authentication runtime state'),
    ('public', 'auth_provider_client_t', 'public', 'auth_session_t', 'auth_session_t_auth_host_id_client_id_provider_id_fkey', 'HARD_DELETE', 'NONE', 'Provider-client retirement revokes non-restorable authorization sessions'),
    ('public', 'auth_provider_t', 'public', 'auth_provider_api_t', 'auth_provider_api_t_host_id_provider_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'auth_provider_t', 'public', 'auth_provider_client_t', 'auth_provider_client_t_host_id_provider_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'auth_provider_t', 'public', 'auth_provider_key_t', 'auth_provider_key_t_host_id_provider_id_fkey', 'IGNORE', 'NONE', 'Preserve keys across parent-driven provider retirement; runtime requires an active provider'),
    ('public', 'category_t', 'public', 'category_t', 'category_t_parent_category_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'category_t', 'public', 'entity_category_t', 'entity_category_t_category_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_profile_t', 'public', 'config_profile_config_t', 'config_profile_config_t_profile_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_profile_t', 'public', 'config_profile_property_t', 'config_profile_property_t_profile_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_profile_t', 'public', 'product_version_config_profile_t', 'product_version_config_profile_t_profile_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'config_profile_property_t', 'config_profile_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'deployment_instance_property_t', 'deployment_instance_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'environment_property_t', 'environment_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'gateway_tool_publication_t', 'gateway_tool_publication_t_property_id_fkey', 'IGNORE', 'NONE', 'Publication lifecycle is immutable and command-owned'),
    ('public', 'config_property_t', 'public', 'instance_api_property_t', 'instance_api_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'instance_app_api_property_t', 'config_property_fk1', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'instance_app_property_t', 'instance_app_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'instance_property_t', 'config_property_fkv1', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'llm_gateway_instance_property_ownership_t', 'llm_gateway_instance_property_ownership_t_property_id_fkey', 'IGNORE', 'NONE', 'Ownership lifecycle is release-managed and lacks the soft-delete audit contract'),
    ('public', 'config_property_t', 'public', 'product_property_t', 'config_property_fkv2', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'product_version_config_property_t', 'product_version_config_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_property_t', 'public', 'product_version_property_t', 'product_version_property_t_property_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_t', 'public', 'chain_handler_t', 'configuration_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_t', 'public', 'config_profile_config_t', 'config_profile_config_t_config_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_t', 'public', 'config_property_t', 'config_fkv2', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'config_t', 'public', 'product_version_config_t', 'product_version_config_t_config_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'customer_t', 'public', 'customer_t', 'customer_t_host_id_referral_id_fkey', 'IGNORE', 'NONE', 'Referral topology does not own customer identity lifecycle'),
    ('public', 'deployment_instance_t', 'public', 'deployment_instance_property_t', 'deployment_instance_property__host_id_deployment_instance__fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'deployment_instance_t', 'public', 'deployment_t', 'deployment_t_host_id_deployment_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'deployment_t', 'public', 'config_snapshot_t', 'config_snapshot_t_host_id_deployment_id_fkey', 'IGNORE', 'NONE', 'Immutable configuration snapshots are retained independently'),
    ('public', 'employee_t', 'public', 'employee_t', 'employee_t_host_id_manager_id_fkey', 'IGNORE', 'NONE', 'Management topology does not own employee identity lifecycle'),
    ('public', 'group_t', 'public', 'group_col_filter_t', 'group_col_filter_t_host_id_group_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'group_t', 'public', 'group_permission_t', 'group_permission_t_host_id_group_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'group_t', 'public', 'group_row_filter_t', 'group_row_filter_t_host_id_group_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'group_t', 'public', 'group_user_t', 'group_user_t_host_id_group_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'auth_client_owner_t', 'auth_client_owner_t_host_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'auth_client_t', 'auth_client_t_host_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'auth_code_t', 'auth_code_t_host_id_fkey', 'HARD_DELETE', 'NONE', 'Tenant host deactivation revokes authorization codes even when auth_host_id differs'),
    ('public', 'host_t', 'public', 'auth_provider_t', 'auth_provider_t_host_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'auth_ref_token_t', 'auth_ref_token_t_host_id_fkey', 'HARD_DELETE', 'NONE', 'Host deactivation revokes stored bearer JWT reference tokens'),
    ('public', 'host_t', 'public', 'auth_refresh_token_t', 'auth_refresh_token_t_host_id_fkey', 'HARD_DELETE', 'NONE', 'Tenant host deactivation revokes refresh tokens even when auth_host_id differs'),
    ('public', 'host_t', 'public', 'agent_memory_bank_t', 'agent_memory_bank_t_host_id_fkey', 'IGNORE', 'NONE', 'Memory-bank lifecycle is independently retained and lacks the soft-delete audit contract'),
    ('public', 'host_t', 'public', 'agent_model_rate_t', 'agent_model_rate_t_host_id_fkey', 'IGNORE', 'NONE', 'Immutable agent model rate history is retained independently'),
    ('public', 'host_t', 'public', 'agent_policy_snapshot_t', 'agent_policy_snapshot_t_host_id_fkey', 'IGNORE', 'NONE', 'Immutable agent policy snapshots are retained independently'),
    ('public', 'host_t', 'public', 'agent_session_t', 'agent_session_t_host_id_fkey', 'IGNORE', 'NONE', 'Agent session lifecycle is command-owned and status-driven'),
    ('public', 'host_t', 'public', 'auth_session_audit_t', 'auth_session_audit_t_auth_host_id_fkey', 'IGNORE', 'NONE', 'Authentication audit history is retained independently'),
    ('public', 'host_t', 'public', 'auth_session_audit_t', 'auth_session_audit_t_host_id_fkey', 'IGNORE', 'NONE', 'Authentication audit history is retained independently'),
    ('public', 'host_t', 'public', 'auth_session_t', 'auth_session_t_host_id_fkey', 'HARD_DELETE', 'NONE', 'Tenant host deactivation revokes non-restorable authorization sessions'),
    ('public', 'host_t', 'public', 'config_snapshot_t', 'config_snapshot_t_host_id_fkey', 'IGNORE', 'NONE', 'Immutable configuration snapshots are retained independently'),
    ('public', 'host_t', 'public', 'environment_property_t', 'host_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'event_failure_transaction_t', 'event_failure_transaction_host_fk', 'IGNORE', 'NONE', 'Failure evidence is retained independently'),
    ('public', 'host_t', 'public', 'event_projection_worker_t', 'event_projection_worker_host_fk', 'IGNORE', 'NONE', 'Projection worker lifecycle is operationally managed'),
    ('public', 'host_t', 'public', 'event_replay_action_request_t', 'event_replay_action_request_host_fk', 'IGNORE', 'NONE', 'Replay action audit history is retained independently'),
    ('public', 'host_t', 'public', 'event_replay_audit_t', 'event_replay_audit_host_fk', 'IGNORE', 'NONE', 'Replay audit history is retained independently'),
    ('public', 'host_t', 'public', 'event_replay_request_t', 'event_replay_request_host_fk', 'IGNORE', 'NONE', 'Replay request lifecycle is operationally managed'),
    ('public', 'host_t', 'public', 'event_replay_retention_log_t', 'event_replay_retention_log_host_fk', 'IGNORE', 'NONE', 'Retention audit history is retained independently'),
    ('public', 'host_t', 'public', 'instance_clone_request_t', 'instance_clone_request_host_fk', 'IGNORE', 'NONE', 'Clone request lifecycle is command-owned and status-driven'),
    ('public', 'host_t', 'public', 'instance_graph_revision_t', 'instance_graph_revision_host_fk', 'IGNORE', 'NONE', 'Graph revision coordination state is retained independently'),
    ('public', 'host_t', 'public', 'knowledge_base_import_t', 'knowledge_base_import_t_host_id_fkey', 'IGNORE', 'NONE', 'Knowledge import lifecycle is command-owned and status-driven'),
    ('public', 'host_t', 'public', 'knowledge_base_manifest_export_t', 'knowledge_base_manifest_export_t_host_id_fkey', 'IGNORE', 'NONE', 'Knowledge export history is retained independently'),
    ('public', 'host_t', 'public', 'knowledge_base_t', 'knowledge_base_t_host_id_fkey', 'IGNORE', 'NONE', 'Knowledge base lifecycle is command-owned'),
    ('public', 'host_t', 'public', 'knowledge_embedding_artifact_t', 'knowledge_embedding_artifact_t_owner_host_id_fkey', 'IGNORE', 'NONE', 'Embedding artifacts are immutable and retained independently'),
    ('public', 'host_t', 'public', 'knowledge_query_audit_t', 'knowledge_query_audit_t_consumer_host_id_fkey', 'IGNORE', 'NONE', 'Knowledge query audit history is retained independently'),
    ('public', 'host_t', 'public', 'knowledge_consumer_quota_t', 'knowledge_consumer_quota_t_consumer_host_id_fkey', 'IGNORE', 'NONE', 'Quota lifecycle is independently retained and lacks the soft-delete audit contract'),
    ('public', 'host_t', 'public', 'knowledge_embedding_profile_t', 'knowledge_embedding_profile_t_host_id_fkey', 'IGNORE', 'NONE', 'Embedding profile lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'knowledge_ingestion_policy_t', 'knowledge_ingestion_policy_t_host_id_fkey', 'IGNORE', 'NONE', 'Ingestion policy lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'knowledge_retrieval_profile_t', 'knowledge_retrieval_profile_t_host_id_fkey', 'IGNORE', 'NONE', 'Retrieval profile lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'knowledge_runtime_authorization_t', 'knowledge_runtime_authorization_t_consumer_host_id_fkey', 'IGNORE', 'NONE', 'Runtime authorization lifecycle is independently enforced and lacks the soft-delete audit contract'),
    ('public', 'host_t', 'public', 'llm_gateway_publication_t', 'llm_gateway_publication_t_host_id_fkey', 'IGNORE', 'NONE', 'Publication lifecycle is immutable and command-owned'),
    ('public', 'host_t', 'public', 'llm_model_policy_t', 'llm_model_policy_t_host_id_fkey', 'IGNORE', 'NONE', 'Model policy lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'llm_model_registration_t', 'llm_model_registration_t_host_id_fkey', 'IGNORE', 'NONE', 'Model registration lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'llm_network_zone_t', 'llm_network_zone_t_host_id_fkey', 'IGNORE', 'NONE', 'Network-zone lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'llm_projection_resource_t', 'llm_projection_resource_t_host_id_fkey', 'IGNORE', 'NONE', 'Projection resources are immutable and release-owned'),
    ('public', 'host_t', 'public', 'llm_provider_account_t', 'llm_provider_account_t_host_id_fkey', 'IGNORE', 'NONE', 'Provider-account lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'llm_public_alias_t', 'llm_public_alias_t_host_id_fkey', 'IGNORE', 'NONE', 'Public-alias lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'message_t', 'message_host_fk', 'IGNORE', 'NONE', 'Message history is retained independently'),
    ('public', 'host_t', 'public', 'notification_t', 'notification_t_host_id_fkey', 'IGNORE', 'NONE', 'Notification history is retained independently'),
    ('public', 'host_t', 'public', 'pii_token_vault_t', 'pii_token_vault_t_host_id_fkey', 'IGNORE', 'NONE', 'PII vault records remain retained and access-controlled while a host is inactive'),
    ('public', 'host_t', 'public', 'private_conversation_t', 'private_conversation_t_host_id_fkey', 'IGNORE', 'NONE', 'Conversation history is retained independently'),
    ('public', 'host_t', 'public', 'product_version_t', 'host_id_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'role_t', 'role_t_host_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'runner_session_t', 'runner_session_t_host_id_fkey', 'IGNORE', 'NONE', 'Runner session lifecycle is operationally managed'),
    ('public', 'host_t', 'public', 'skill_package_t', 'skill_package_t_host_id_fkey', 'IGNORE', 'NONE', 'Skill package lifecycle is command-owned'),
    ('public', 'host_t', 'public', 'user_host_t', 'user_host_t_host_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'host_t', 'public', 'workflow_endpoint_target_t', 'workflow_endpoint_target_t_host_id_fkey', 'IGNORE', 'NONE', 'Workflow endpoint lifecycle is command-owned until it implements the complete soft-delete audit contract'),
    ('public', 'host_t', 'public', 'workflow_execution_policy_t', 'workflow_execution_policy_t_host_id_fkey', 'IGNORE', 'NONE', 'Workflow execution policy lifecycle is command-owned'),
    ('public', 'host_t', 'public', 'workflow_executor_tenant_turn_t', 'workflow_executor_tenant_turn_t_host_id_fkey', 'IGNORE', 'NONE', 'Workflow executor turn history is retained independently'),
    ('public', 'instance_api_t', 'public', 'instance_api_path_prefix_t', 'instance_api_path_prefix_t_host_id_instance_api_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_api_t', 'public', 'instance_api_property_t', 'instance_api_property_t_host_id_instance_api_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_api_t', 'public', 'instance_app_api_t', 'instance_app_api_t_host_id_instance_api_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_app_api_t', 'public', 'instance_app_api_property_t', 'instance_app_api_property_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_app_t', 'public', 'instance_app_api_t', 'instance_app_api_t_host_id_instance_app_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_app_t', 'public', 'instance_app_property_t', 'instance_app_property_t_host_id_instance_app_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'auth_client_owner_t', 'auth_client_owner_t_host_id_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'config_snapshot_t', 'config_snapshot_t_host_id_instance_id_fkey', 'IGNORE', 'NONE', 'Immutable configuration snapshots are retained independently'),
    ('public', 'instance_t', 'public', 'deployment_instance_t', 'deployment_instance_t_host_id_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'gateway_tool_binding_t', 'gateway_tool_binding_t_host_id_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'gateway_tool_publication_t', 'gateway_tool_publication_t_host_id_instance_id_fkey', 'IGNORE', 'NONE', 'Publication lifecycle is immutable and command-owned'),
    ('public', 'instance_t', 'public', 'instance_api_t', 'instance_api_t_host_id_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'instance_app_t', 'instance_app_t_host_id_instance_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'instance_file_t', 'instance_file_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'instance_property_t', 'instance_fkv2', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'instance_t', 'public', 'llm_gateway_instance_property_ownership_t', 'llm_gateway_instance_property_ownershi_host_id_instance_id_fkey', 'IGNORE', 'NONE', 'Ownership lifecycle is release-managed and lacks the soft-delete audit contract'),
    ('public', 'instance_t', 'public', 'llm_gateway_instance_publication_t', 'llm_gateway_instance_publication_t_host_id_instance_id_fkey', 'IGNORE', 'NONE', 'Instance publication lifecycle is immutable and command-owned'),
    ('public', 'org_t', 'public', 'host_t', 'host_t_domain_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'pipeline_t', 'public', 'product_version_pipeline_t', 'product_version_pipeline_t_host_id_pipeline_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'platform_t', 'public', 'pipeline_t', 'pipeline_t_host_id_platform_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'position_t', 'public', 'position_col_filter_t', 'position_col_filter_t_host_id_position_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'position_t', 'public', 'position_permission_t', 'position_permission_t_host_id_position_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'position_t', 'public', 'position_row_filter_t', 'position_row_filter_t_host_id_position_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'position_t', 'public', 'user_position_t', 'user_position_t_host_id_position_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'instance_t', 'product_version_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_config_profile_t', 'product_version_config_profile__host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_config_property_t', 'product_version_config_property_host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_config_t', 'product_version_config_t_host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_environment_t', 'product_version_environment_t_host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_pipeline_t', 'product_version_pipeline_t_host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'product_version_t', 'public', 'product_version_property_t', 'product_version_property_t_host_id_product_version_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'ref_table_t', 'public', 'ref_value_t', 'ref_value_t_table_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'ref_value_t', 'public', 'relation_t', 'relation_t_value_id_from_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'ref_value_t', 'public', 'relation_t', 'relation_t_value_id_to_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'ref_value_t', 'public', 'value_locale_t', 'value_locale_t_value_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'relation_type_t', 'public', 'relation_t', 'relation_t_relation_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'role_t', 'public', 'role_col_filter_t', 'role_col_filter_t_host_id_role_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'role_t', 'public', 'role_permission_t', 'role_permission_t_host_id_role_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'role_t', 'public', 'role_row_filter_t', 'role_row_filter_t_host_id_role_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'role_t', 'public', 'role_user_t', 'role_user_t_host_id_role_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'rule_t', 'public', 'api_endpoint_rule_t', 'rule_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'rule_t', 'public', 'rule_test_case_t', 'rule_test_case_rule_fk', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'tag_t', 'public', 'entity_tag_t', 'entity_tag_t_tag_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_host_t', 'public', 'customer_t', 'customer_t_host_id_user_id_fkey', 'IGNORE', 'NONE', 'Preserve recoverable customer identity while host membership is inactive'),
    ('public', 'user_host_t', 'public', 'employee_t', 'employee_t_host_id_user_id_fkey', 'IGNORE', 'NONE', 'Preserve recoverable employee identity while host membership is inactive'),
    ('public', 'user_t', 'public', 'attribute_user_t', 'attribute_user_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'agent_memory_bank_t', 'agent_memory_bank_t_user_id_fkey', 'IGNORE', 'NONE', 'Memory-bank lifecycle is independently retained and lacks the soft-delete audit contract'),
    ('public', 'user_t', 'public', 'agent_memory_entity_t', 'agent_memory_entity_t_user_id_fkey', 'IGNORE', 'NONE', 'Memory-entity lifecycle is independently retained and lacks the soft-delete audit contract'),
    ('public', 'user_t', 'public', 'auth_code_t', 'auth_code_t_user_id_fkey', 'HARD_DELETE', 'NONE', 'User deactivation revokes non-restorable authorization codes'),
    ('public', 'user_t', 'public', 'auth_refresh_token_t', 'auth_refresh_token_t_user_id_fkey', 'HARD_DELETE', 'NONE', 'User deactivation revokes non-restorable refresh tokens'),
    ('public', 'user_t', 'public', 'auth_session_t', 'auth_session_t_user_id_fkey', 'HARD_DELETE', 'NONE', 'User deactivation revokes non-restorable authorization sessions'),
    ('public', 'user_t', 'public', 'config_snapshot_t', 'config_snapshot_t_user_id_fkey', 'IGNORE', 'NONE', 'Immutable configuration snapshots are retained independently'),
    ('public', 'user_t', 'public', 'group_user_t', 'group_user_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'role_user_t', 'role_user_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'user_col_filter_t', 'user_col_filter_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'user_crypto_wallet_t', 'user_crypto_wallet_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'user_host_t', 'user_host_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'user_permission_t', 'user_permission_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship'),
    ('public', 'user_t', 'public', 'user_row_filter_t', 'user_row_filter_t_user_id_fkey', 'SOFT_DELETE', 'RESTORE', 'Recoverable projection relationship')
;

INSERT INTO cascade_relationship_policy_t (
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    constraint_name,
    delete_action,
    restore_action,
    policy_description
)
SELECT
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    constraint_name,
    delete_action,
    restore_action,
    policy_description
FROM cascade_relationship_policy_seed_t
ON CONFLICT (
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    constraint_name
) DO UPDATE
SET delete_action = EXCLUDED.delete_action,
    restore_action = EXCLUDED.restore_action,
    policy_description = EXCLUDED.policy_description,
    update_user = SESSION_USER,
    update_ts = CURRENT_TIMESTAMP;

DELETE FROM cascade_relationship_policy_t policy
WHERE policy.parent_schema = 'public'
  AND policy.child_schema = 'public'
  AND NOT EXISTS (
    SELECT 1
    FROM cascade_relationship_policy_seed_t seed
    WHERE seed.parent_schema = policy.parent_schema
      AND seed.parent_table = policy.parent_table
      AND seed.child_schema = policy.child_schema
      AND seed.child_table = policy.child_table
      AND seed.constraint_name = policy.constraint_name
);

DROP VIEW IF EXISTS cascade_relationships_v;

CREATE VIEW cascade_relationships_v AS
WITH fk_details AS (
    SELECT
        pn.nspname::text AS parent_schema,
        pc.relname::text AS parent_table,
        cn.nspname::text AS child_schema,
        cc.relname::text AS child_table,
        c.conname::text AS constraint_name,
        c.oid AS constraint_id,
        cc.oid AS child_table_oid,
        pc.oid AS parent_table_oid,
        c.confdeltype,
        array_agg(pa.attname::text ORDER BY keys.ord) AS parent_columns,
        array_agg(ca.attname::text ORDER BY keys.ord) AS child_columns,
        count(*)::integer AS column_count
    FROM pg_constraint c
    JOIN pg_class pc ON pc.oid = c.confrelid
    JOIN pg_namespace pn ON pn.oid = pc.relnamespace
    JOIN pg_class cc ON cc.oid = c.conrelid
    JOIN pg_namespace cn ON cn.oid = cc.relnamespace
    JOIN LATERAL unnest(c.confkey, c.conkey)
        WITH ORDINALITY AS keys(parent_attnum, child_attnum, ord) ON TRUE
    JOIN pg_attribute pa
      ON pa.attrelid = pc.oid
     AND pa.attnum = keys.parent_attnum
     AND NOT pa.attisdropped
    JOIN pg_attribute ca
      ON ca.attrelid = cc.oid
     AND ca.attnum = keys.child_attnum
     AND NOT ca.attisdropped
    WHERE c.contype = 'f'
    GROUP BY
        pn.nspname,
        pc.relname,
        cn.nspname,
        cc.relname,
        c.conname,
        c.oid,
        cc.oid,
        pc.oid,
        c.confdeltype
)
SELECT
    fk.parent_schema,
    fk.parent_table,
    fk.child_schema,
    fk.child_table,
    fk.constraint_name,
    fk.constraint_id,
    fk.parent_columns,
    fk.child_columns,
    fk.column_count,
    fk.child_table_oid,
    fk.parent_table_oid,
    CASE fk.confdeltype
        WHEN 'a' THEN 'NO ACTION'
        WHEN 'r' THEN 'RESTRICT'
        WHEN 'c' THEN 'CASCADE'
        WHEN 'n' THEN 'SET NULL'
        WHEN 'd' THEN 'SET DEFAULT'
        ELSE 'UNKNOWN'
    END AS foreign_key_delete_action,
    policy.delete_action,
    policy.restore_action,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.parent_table_oid
          AND a.attname = 'active'
          AND NOT a.attisdropped
    ) AS parent_has_active,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.parent_table_oid
          AND a.attname = 'delete_ts'
          AND NOT a.attisdropped
    ) AS parent_has_delete_ts,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.parent_table_oid
          AND a.attname = 'delete_user'
          AND NOT a.attisdropped
    ) AS parent_has_delete_user,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.parent_table_oid
          AND a.attname = 'update_ts'
          AND NOT a.attisdropped
    ) AS parent_has_update_ts,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.parent_table_oid
          AND a.attname = 'update_user'
          AND NOT a.attisdropped
    ) AS parent_has_update_user,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.child_table_oid
          AND a.attname = 'active'
          AND NOT a.attisdropped
    ) AS child_has_active,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.child_table_oid
          AND a.attname = 'delete_ts'
          AND NOT a.attisdropped
    ) AS child_has_delete_ts,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.child_table_oid
          AND a.attname = 'delete_user'
          AND NOT a.attisdropped
    ) AS child_has_delete_user,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.child_table_oid
          AND a.attname = 'update_ts'
          AND NOT a.attisdropped
    ) AS child_has_update_ts,
    EXISTS (
        SELECT 1
        FROM pg_attribute a
        WHERE a.attrelid = fk.child_table_oid
          AND a.attname = 'update_user'
          AND NOT a.attisdropped
    ) AS child_has_update_user
FROM fk_details fk
JOIN cascade_relationship_policy_t policy
  ON policy.parent_schema = fk.parent_schema
 AND policy.parent_table = fk.parent_table
 AND policy.child_schema = fk.child_schema
 AND policy.child_table = fk.child_table
 AND policy.constraint_name = fk.constraint_name;

CREATE OR REPLACE FUNCTION validate_cascade_relationship_policies()
RETURNS void AS $$
DECLARE
    invalid_policy RECORD;
    invalid_width RECORD;
    unclassified_relationship RECORD;
BEGIN
    SELECT policy.*
      INTO invalid_policy
      FROM cascade_relationship_policy_t policy
      LEFT JOIN pg_namespace pn
        ON pn.nspname = policy.parent_schema
      LEFT JOIN pg_class pc
        ON pc.relnamespace = pn.oid
       AND pc.relname = policy.parent_table
      LEFT JOIN pg_namespace cn
        ON cn.nspname = policy.child_schema
      LEFT JOIN pg_class cc
        ON cc.relnamespace = cn.oid
       AND cc.relname = policy.child_table
      LEFT JOIN pg_constraint constraint_row
        ON constraint_row.contype = 'f'
       AND constraint_row.conname = policy.constraint_name
       AND constraint_row.confrelid = pc.oid
       AND constraint_row.conrelid = cc.oid
     WHERE constraint_row.oid IS NULL
     ORDER BY
        policy.parent_schema,
        policy.parent_table,
        policy.child_schema,
        policy.child_table,
        policy.constraint_name
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'cascade policy references missing or mismatched foreign key: %.% -> %.% (%)',
            invalid_policy.parent_schema,
            invalid_policy.parent_table,
            invalid_policy.child_schema,
            invalid_policy.child_table,
            invalid_policy.constraint_name;
    END IF;

    SELECT *
      INTO invalid_policy
      FROM cascade_relationships_v
     WHERE delete_action IN ('SOFT_DELETE', 'HARD_DELETE')
       AND NOT (
           parent_has_active
           AND parent_has_delete_ts
           AND parent_has_delete_user
           AND parent_has_update_ts
           AND parent_has_update_user
       )
     ORDER BY parent_schema, parent_table, child_schema, child_table, constraint_name
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'cascade parent %.% does not implement the complete soft-delete contract for constraint %',
            invalid_policy.parent_schema,
            invalid_policy.parent_table,
            invalid_policy.constraint_name;
    END IF;

    SELECT *
      INTO invalid_policy
      FROM cascade_relationships_v
     WHERE delete_action = 'SOFT_DELETE'
       AND NOT (
           child_has_active
           AND child_has_delete_ts
           AND child_has_delete_user
           AND child_has_update_ts
           AND child_has_update_user
       )
     ORDER BY parent_schema, parent_table, child_schema, child_table, constraint_name
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'soft-delete child %.% does not implement the complete contract for constraint %',
            invalid_policy.child_schema,
            invalid_policy.child_table,
            invalid_policy.constraint_name;
    END IF;

    WITH soft_child_requirements AS (
        SELECT
            child_schema,
            child_table,
            count(*)::integer AS relationship_count,
            (14 + 33 * count(*))::integer AS required_length
        FROM cascade_relationships_v
        WHERE delete_action = 'SOFT_DELETE'
        GROUP BY child_schema, child_table
    )
    SELECT
        requirement.child_schema,
        requirement.child_table,
        requirement.relationship_count,
        requirement.required_length,
        (attribute_row.atttypmod - 4)::integer AS actual_length
      INTO invalid_width
      FROM soft_child_requirements requirement
      JOIN pg_namespace namespace_row
        ON namespace_row.nspname = requirement.child_schema
      JOIN pg_class class_row
        ON class_row.relnamespace = namespace_row.oid
       AND class_row.relname = requirement.child_table
      JOIN pg_attribute attribute_row
        ON attribute_row.attrelid = class_row.oid
       AND attribute_row.attname = 'delete_user'
       AND NOT attribute_row.attisdropped
     WHERE attribute_row.atttypid IN ('varchar'::regtype, 'bpchar'::regtype)
       AND attribute_row.atttypmod >= 0
       AND attribute_row.atttypmod - 4 < requirement.required_length
     ORDER BY requirement.child_schema, requirement.child_table
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'soft-delete child %.% delete_user width % is smaller than required % for % cascade relationships',
            invalid_width.child_schema,
            invalid_width.child_table,
            invalid_width.actual_length,
            invalid_width.required_length,
            invalid_width.relationship_count;
    END IF;

    SELECT *
      INTO invalid_policy
      FROM cascade_relationships_v
     WHERE delete_action = 'HARD_DELETE'
       AND foreign_key_delete_action <> 'CASCADE'
     ORDER BY parent_schema, parent_table, child_schema, child_table, constraint_name
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'hard-delete policy requires ON DELETE CASCADE for constraint %',
            invalid_policy.constraint_name;
    END IF;

    SELECT
        relationship.child_schema,
        relationship.child_table,
        downstream_namespace.nspname::text AS downstream_schema,
        downstream_table.relname::text AS downstream_table,
        downstream_constraint.conname::text AS downstream_constraint
      INTO invalid_policy
      FROM cascade_relationships_v relationship
      JOIN pg_constraint downstream_constraint
        ON downstream_constraint.contype = 'f'
       AND downstream_constraint.confrelid = relationship.child_table_oid
      JOIN pg_class downstream_table
        ON downstream_table.oid = downstream_constraint.conrelid
      JOIN pg_namespace downstream_namespace
        ON downstream_namespace.oid = downstream_table.relnamespace
     WHERE relationship.delete_action = 'HARD_DELETE'
       AND downstream_constraint.confdeltype <> 'c'
     ORDER BY
        relationship.child_schema,
        relationship.child_table,
        downstream_namespace.nspname,
        downstream_table.relname,
        downstream_constraint.conname
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'hard-delete child %.% is referenced by non-cascading constraint %.% (%)',
            invalid_policy.child_schema,
            invalid_policy.child_table,
            invalid_policy.downstream_schema,
            invalid_policy.downstream_table,
            invalid_policy.downstream_constraint;
    END IF;

    WITH candidate_relationships AS (
        SELECT
            pn.nspname::text AS parent_schema,
            pc.relname::text AS parent_table,
            cn.nspname::text AS child_schema,
            cc.relname::text AS child_table,
            constraint_row.conname::text AS constraint_name
        FROM pg_constraint constraint_row
        JOIN pg_class pc ON pc.oid = constraint_row.confrelid
        JOIN pg_namespace pn ON pn.oid = pc.relnamespace
        JOIN pg_class cc ON cc.oid = constraint_row.conrelid
        JOIN pg_namespace cn ON cn.oid = cc.relnamespace
        WHERE constraint_row.contype = 'f'
          AND pn.nspname = 'public'
          AND cn.nspname = 'public'
          AND EXISTS (
              SELECT 1
              FROM pg_attribute a
              WHERE a.attrelid = pc.oid
                AND a.attname = 'delete_ts'
                AND NOT a.attisdropped
          )
          AND EXISTS (
              SELECT 1
              FROM pg_attribute a
              WHERE a.attrelid = pc.oid
                AND a.attname = 'active'
                AND NOT a.attisdropped
          )
    )
    SELECT candidate.*
      INTO unclassified_relationship
      FROM candidate_relationships candidate
      LEFT JOIN cascade_relationship_policy_t policy
        ON policy.parent_schema = candidate.parent_schema
       AND policy.parent_table = candidate.parent_table
       AND policy.child_schema = candidate.child_schema
       AND policy.child_table = candidate.child_table
       AND policy.constraint_name = candidate.constraint_name
     WHERE policy.constraint_name IS NULL
     ORDER BY
        candidate.parent_schema,
        candidate.parent_table,
        candidate.child_schema,
        candidate.child_table,
        candidate.constraint_name
     LIMIT 1;

    IF FOUND THEN
        RAISE EXCEPTION
            'unclassified cascade relationship: %.% -> %.% (%)',
            unclassified_relationship.parent_schema,
            unclassified_relationship.parent_table,
            unclassified_relationship.child_schema,
            unclassified_relationship.child_table,
            unclassified_relationship.constraint_name;
    END IF;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION smart_cascade_delete()
RETURNS TRIGGER AS $$
DECLARE
    relationship RECORD;
    where_clause TEXT;
    query_text TEXT;
    column_index INTEGER;
    deletion_context_token TEXT;
    delete_timestamp TIMESTAMP WITH TIME ZONE;
BEGIN
    IF NEW.active = FALSE AND OLD.active = TRUE THEN
        delete_timestamp := CURRENT_TIMESTAMP;
        FOR relationship IN
            SELECT *
            FROM cascade_relationships_v
            WHERE parent_schema = TG_TABLE_SCHEMA
              AND parent_table = TG_TABLE_NAME
            ORDER BY constraint_name
            LOOP
            where_clause := '';

            FOR column_index IN 1..relationship.column_count LOOP
                IF column_index > 1 THEN
                    where_clause := where_clause || ' AND ';
                END IF;

                where_clause := where_clause || format(
                    '%I = ($1).%I',
                    relationship.child_columns[column_index],
                    relationship.parent_columns[column_index]
                );
            END LOOP;

            deletion_context_token := md5(format(
                '%s.%s:%s',
                relationship.parent_schema,
                relationship.parent_table,
                relationship.constraint_name
            ));

            IF relationship.delete_action = 'SOFT_DELETE' THEN
                query_text := format(
                    'UPDATE %I.%I
                        SET active = FALSE,
                            delete_ts = CASE WHEN active THEN $2 ELSE delete_ts END,
                            delete_user = CASE
                                WHEN active THEN ''PARENT_CASCADE:'' || $3
                                WHEN NOT ($3 = ANY(string_to_array(substring(delete_user FROM 16), '','')))
                                    THEN delete_user || '','' || $3
                                ELSE delete_user
                            END,
                            update_ts = $2,
                            update_user = $4
                      WHERE %s
                        AND (
                            active = TRUE
                            OR left(delete_user, 15) = ''PARENT_CASCADE:''
                        )',
                    relationship.child_schema,
                    relationship.child_table,
                    where_clause
                );

                EXECUTE query_text
                    USING OLD, delete_timestamp, deletion_context_token, current_user;
            ELSIF relationship.delete_action = 'HARD_DELETE' THEN
                query_text := format(
                    'DELETE FROM %I.%I WHERE %s',
                    relationship.child_schema,
                    relationship.child_table,
                    where_clause
                );

                EXECUTE query_text USING OLD;
            END IF;
        END LOOP;
    ELSIF NEW.active = TRUE AND OLD.active = FALSE THEN
        FOR relationship IN
            SELECT *
            FROM cascade_relationships_v
            WHERE parent_schema = TG_TABLE_SCHEMA
              AND parent_table = TG_TABLE_NAME
              AND delete_action = 'SOFT_DELETE'
              AND restore_action = 'RESTORE'
            ORDER BY constraint_name
            LOOP
            where_clause := '';

            FOR column_index IN 1..relationship.column_count LOOP
                IF column_index > 1 THEN
                    where_clause := where_clause || ' AND ';
                END IF;

                where_clause := where_clause || format(
                    '%I = ($1).%I',
                    relationship.child_columns[column_index],
                    relationship.parent_columns[column_index]
                );
            END LOOP;

            deletion_context_token := md5(format(
                '%s.%s:%s',
                relationship.parent_schema,
                relationship.parent_table,
                relationship.constraint_name
            ));

            query_text := format(
                'UPDATE %I.%I
                    SET active = CASE
                            WHEN left(delete_user, 15) = ''PARENT_CASCADE:''
                                THEN cardinality(array_remove(
                                    string_to_array(substring(delete_user FROM 16), '',''), $2
                                )) = 0
                            ELSE TRUE
                        END,
                        delete_ts = CASE
                            WHEN left(delete_user, 15) = ''PARENT_CASCADE:''
                             AND cardinality(array_remove(
                                    string_to_array(substring(delete_user FROM 16), '',''), $2
                                 )) > 0
                                THEN delete_ts
                            ELSE NULL
                        END,
                        delete_user = CASE
                            WHEN left(delete_user, 15) = ''PARENT_CASCADE:''
                             AND cardinality(array_remove(
                                    string_to_array(substring(delete_user FROM 16), '',''), $2
                                 )) > 0
                                THEN ''PARENT_CASCADE:'' || array_to_string(
                                    array_remove(string_to_array(substring(delete_user FROM 16), '',''), $2), '',''
                                )
                            ELSE NULL
                        END,
                        update_ts = CURRENT_TIMESTAMP,
                        update_user = $3
                  WHERE %s
                    AND active = FALSE
                    AND (
                        (
                            left(delete_user, 15) = ''PARENT_CASCADE:''
                            AND $2 = ANY(string_to_array(substring(delete_user FROM 16), '',''))
                        )
                        OR left(delete_user, length($4)) = $4
                    )',
                relationship.child_schema,
                relationship.child_table,
                where_clause
            );

            EXECUTE query_text
                USING OLD, deletion_context_token, current_user,
                    'PARENT_CASCADE_' || TG_TABLE_NAME || '_';
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    trigger_record RECORD;
    table_record RECORD;
BEGIN
    -- Validation and trigger replacement are part of the surrounding
    -- transaction. Any failure aborts installation and preserves the prior
    -- committed policy, function, and trigger set.
    PERFORM validate_cascade_relationship_policies();

    FOR trigger_record IN
        SELECT
            trigger_namespace.nspname AS schema_name,
            trigger_table.relname AS table_name,
            trigger_row.tgname AS trigger_name
        FROM pg_trigger trigger_row
        JOIN pg_class trigger_table ON trigger_table.oid = trigger_row.tgrelid
        JOIN pg_namespace trigger_namespace ON trigger_namespace.oid = trigger_table.relnamespace
        WHERE NOT trigger_row.tgisinternal
          AND trigger_row.tgname = 'trg_cascade_soft_ops'
    LOOP
        EXECUTE format(
            'DROP TRIGGER %I ON %I.%I',
            trigger_record.trigger_name,
            trigger_record.schema_name,
            trigger_record.table_name
        );
    END LOOP;

    FOR table_record IN
        SELECT DISTINCT parent_schema AS schema_name, parent_table AS table_name
        FROM cascade_relationships_v
        WHERE delete_action <> 'IGNORE'
        ORDER BY parent_schema, parent_table
    LOOP
        EXECUTE format(
            'CREATE TRIGGER trg_cascade_soft_ops
             AFTER UPDATE OF active ON %I.%I
             FOR EACH ROW
             EXECUTE FUNCTION smart_cascade_delete()',
            table_record.schema_name,
            table_record.table_name
        );
    END LOOP;
END $$;

DROP FUNCTION IF EXISTS smart_cascade_soft_delete();

COMMIT;

-- DDL for the Stored Procedure (Requires PostgreSQL 11+ for PROCEDURE support)
CREATE OR REPLACE PROCEDURE create_snapshot(
    p_host_id UUID,
    p_instance_id UUID,
    p_snapshot_type VARCHAR(32),
    p_description TEXT,
    p_user_id UUID,
    p_deployment_id UUID,
    p_snapshot_id UUID
)
LANGUAGE plpgsql
AS $$
DECLARE
    -- Variables to hold scope data derived from instance_t
    v_product_version_id UUID;
    v_service_id VARCHAR(512);
    v_environment VARCHAR(16);
    v_instance_app_id_list UUID[];
    v_instance_api_id_list UUID[];
    v_deployment_instance_id UUID;
    v_product_id VARCHAR(8);
BEGIN

    -- 1. Get essential scope data from instance_t
    SELECT
        t.product_version_id,
        t.service_id,
        COALESCE(NULLIF(t.env_tag, ''), t.environment)
    INTO
        v_product_version_id,
        v_service_id,
        v_environment
    FROM
        instance_t t
    WHERE
        t.host_id = p_host_id
        AND t.instance_id = p_instance_id
        AND t.active = TRUE; -- Only snapshot an active instance

    -- If instance not found or inactive, raise exception (or simply return if non-critical)
    IF v_product_version_id IS NULL THEN
        RAISE EXCEPTION 'Instance with host_id % and instance_id % not found or is inactive.', p_host_id, p_instance_id;
    END IF;

    -- 2. Get additional IDs for cascading copies
    -- Get deployment_instance_id
    SELECT deployment_instance_id INTO v_deployment_instance_id
    FROM deployment_instance_t
    WHERE host_id = p_host_id AND instance_id = p_instance_id AND active = TRUE
    LIMIT 1;
    
    -- Get product_id (Needed for product_property_t)
    SELECT product_id INTO v_product_id
    FROM product_version_t
    WHERE host_id = p_host_id AND product_version_id = v_product_version_id AND active = TRUE
    LIMIT 1;

    -- Get instance_app_id list (used for multiple snapshot tables)
    SELECT ARRAY_AGG(instance_app_id) INTO v_instance_app_id_list
    FROM instance_app_t
    WHERE host_id = p_host_id AND instance_id = p_instance_id AND active = TRUE;

    -- Get instance_api_id list (used for multiple snapshot tables)
    SELECT ARRAY_AGG(instance_api_id) INTO v_instance_api_id_list
    FROM instance_api_t
    WHERE host_id = p_host_id AND instance_id = p_instance_id AND active = TRUE;

    RAISE NOTICE 'Debugging Snapshot: host_id=%, instance_id=%', p_host_id, p_instance_id;
    RAISE NOTICE 'Found instance_api_id count: %', array_length(v_instance_api_id_list, 1);
    RAISE NOTICE 'instance_api_id list: %', v_instance_api_id_list;


    -- 3. Insert into config_snapshot_t (Snapshot Header)
    INSERT INTO config_snapshot_t (
        snapshot_id, snapshot_type, host_id, instance_id, description, user_id, deployment_id,
        environment, product_id, product_version, service_id
    ) VALUES (
        p_snapshot_id, p_snapshot_type, p_host_id, p_instance_id, p_description, p_user_id, p_deployment_id,
        v_environment, v_product_id, (
            SELECT product_version
            FROM product_version_t
            WHERE product_version_id = v_product_version_id
              AND host_id = p_host_id
              AND active = TRUE
        ), v_service_id
    );

    -- 4. Copy data to all relevant RAW snapshot tables (STEPS A-I)
    -- This data will be used by the MERGE step (Step J)
    
    -- A. snapshot_instance_property_t (Instance Overrides)
    INSERT INTO snapshot_instance_property_t (
        snapshot_id, host_id, instance_id, property_id, property_value,
        aggregate_version, update_user, update_ts
    )
    SELECT
        p_snapshot_id, t.host_id, t.instance_id, t.property_id, t.property_value,
        t.aggregate_version, t.update_user, t.update_ts
    FROM
        instance_property_t t
    WHERE
        t.host_id = p_host_id AND t.instance_id = p_instance_id AND t.active = TRUE;


    -- B. snapshot_deployment_instance_property_t (Deployment Instance Overrides)
    IF v_deployment_instance_id IS NOT NULL THEN
        INSERT INTO snapshot_deployment_instance_property_t (
            snapshot_id, host_id, deployment_instance_id, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.host_id, t.deployment_instance_id, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            deployment_instance_property_t t
        WHERE
            t.host_id = p_host_id AND t.deployment_instance_id = v_deployment_instance_id AND t.active = TRUE;
    END IF;


    -- C. snapshot_instance_file_t (Instance Files)
    INSERT INTO snapshot_instance_file_t (
        snapshot_id, host_id, instance_file_id, instance_id, config_phase, file_type, file_name, file_value, file_desc, expiration_ts,
        aggregate_version, active, update_user, update_ts
    )
    SELECT
        p_snapshot_id, t.host_id, t.instance_file_id, t.instance_id, t.config_phase, t.file_type, t.file_name, t.file_value, t.file_desc, t.expiration_ts,
        t.aggregate_version, t.active, t.update_user, t.update_ts
    FROM
        instance_file_t t
    WHERE
        t.host_id = p_host_id AND t.instance_id = p_instance_id AND t.active = TRUE;


    -- D. snapshot_instance_api_property_t (Instance API Overrides)
    IF v_instance_api_id_list IS NOT NULL AND array_length(v_instance_api_id_list, 1) > 0 THEN
        RAISE NOTICE 'Step D: Copying % instance_api_property_t records...', array_length(v_instance_api_id_list, 1);
        INSERT INTO snapshot_instance_api_property_t (
            snapshot_id, host_id, instance_api_id, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.host_id, t.instance_api_id, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            instance_api_property_t t
        WHERE
            t.host_id = p_host_id AND t.instance_api_id = ANY(v_instance_api_id_list) AND t.active = TRUE;
    ELSE
        RAISE NOTICE 'Step D: Skipped (v_instance_api_id_list is empty or NULL)';
    END IF;


    -- E. snapshot_instance_app_property_t (Instance App Overrides)
    IF v_instance_app_id_list IS NOT NULL AND array_length(v_instance_app_id_list, 1) > 0 THEN
        RAISE NOTICE 'Step E: Copying % instance_app_property_t records...', array_length(v_instance_app_id_list, 1);
        INSERT INTO snapshot_instance_app_property_t (
            snapshot_id, host_id, instance_app_id, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.host_id, t.instance_app_id, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            instance_app_property_t t
        WHERE
            t.host_id = p_host_id AND t.instance_app_id = ANY(v_instance_app_id_list) AND t.active = TRUE;
    ELSE
        RAISE NOTICE 'Step E: Skipped (v_instance_app_id_list is empty or NULL)';
    END IF;


    -- F. snapshot_instance_app_api_property_t (Instance App API Overrides)
    IF v_instance_app_id_list IS NOT NULL AND array_length(v_instance_app_id_list, 1) > 0 AND v_instance_api_id_list IS NOT NULL AND array_length(v_instance_api_id_list, 1) > 0 THEN
        RAISE NOTICE 'Step F: Copying instance_app_api_property_t for % apps and % apis...', array_length(v_instance_app_id_list, 1), array_length(v_instance_api_id_list, 1);
        INSERT INTO snapshot_instance_app_api_property_t (
            snapshot_id, host_id, instance_app_id, instance_api_id, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.host_id, t.instance_app_id, t.instance_api_id, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            instance_app_api_property_t t
        WHERE
            t.host_id = p_host_id
            AND t.instance_app_id = ANY(v_instance_app_id_list)
            AND t.instance_api_id = ANY(v_instance_api_id_list)
            AND t.active = TRUE;
    ELSE
        RAISE NOTICE 'Step F: Skipped (v_instance_app_id_list or v_instance_api_id_list is empty or NULL)';
    END IF;


    -- G. snapshot_product_version_property_t (Product Version Overrides)
    INSERT INTO snapshot_product_version_property_t (
        snapshot_id, host_id, product_version_id, property_id, property_value,
        aggregate_version, update_user, update_ts
    )
    SELECT
        p_snapshot_id, t.host_id, t.product_version_id, t.property_id, t.property_value,
        t.aggregate_version, t.update_user, t.update_ts
    FROM
        product_version_property_t t
    WHERE
        t.host_id = p_host_id AND t.product_version_id = v_product_version_id AND t.active = TRUE;


    -- H. snapshot_product_property_t (Product Overrides)
    IF v_product_id IS NOT NULL THEN
        INSERT INTO snapshot_product_property_t (
            snapshot_id, product_id, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.product_id, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            product_property_t t
        WHERE
            t.product_id = v_product_id AND t.active = TRUE;
    END IF;


    -- I. snapshot_environment_property_t (Environment Overrides)
    IF v_environment IS NOT NULL THEN
        INSERT INTO snapshot_environment_property_t (
            snapshot_id, host_id, environment, property_id, property_value,
            aggregate_version, update_user, update_ts
        )
        SELECT
            p_snapshot_id, t.host_id, t.environment, t.property_id, t.property_value,
            t.aggregate_version, t.update_user, t.update_ts
        FROM
            environment_property_t t
        WHERE
            t.host_id = p_host_id AND t.environment = v_environment AND t.active = TRUE;
    END IF;


-- J. MERGE: Insert merged, effective properties into config_snapshot_property_t
    INSERT INTO config_snapshot_property_t (
        snapshot_property_id,
        snapshot_id,
        config_phase,
        config_id,
        property_id,
        property_name,
        property_type,
        property_value,
        value_type,
        source_level
    )
    WITH 
    -- 1. Deployment Override (Highest Priority - No Merge)
    DeploymentOverride AS (
        SELECT t.property_id, t.property_value, 1 AS priority_rank, 'deployment_instance' AS source_level
        FROM snapshot_deployment_instance_property_t t
        WHERE t.snapshot_id = p_snapshot_id
    ),
    -- 2. Instance Level Merge Pool
    -- Gather all potential contributors to the instance-level config
    InstancePool AS (
        SELECT property_id, property_value, update_ts FROM snapshot_instance_property_t WHERE snapshot_id = p_snapshot_id
        UNION ALL
        SELECT property_id, property_value, update_ts FROM snapshot_instance_api_property_t WHERE snapshot_id = p_snapshot_id
        UNION ALL
        SELECT property_id, property_value, update_ts FROM snapshot_instance_app_property_t WHERE snapshot_id = p_snapshot_id
        UNION ALL
        SELECT property_id, property_value, update_ts FROM snapshot_instance_app_api_property_t WHERE snapshot_id = p_snapshot_id
    ),
    -- Perform the Merge for the Instance Pool
    MergedInstanceLevel AS (
        SELECT 
            ip.property_id,
            CASE cp.value_type
                WHEN 'list' THEN COALESCE((
                    -- Explode arrays from all matching rows and re-aggregate into one list
                    -- Handles non-JSON strings gracefully by treating them as single-item lists
                    SELECT jsonb_agg(elem ORDER BY sub.update_ts ASC)
                    FROM InstancePool sub
                    CROSS JOIN LATERAL (
                        SELECT jsonb_array_elements(sub.property_value::jsonb) AS elem
                        WHERE sub.property_value ~ '^\s*\[.*\]\s*$'
                        UNION ALL
                        SELECT to_jsonb(sub.property_value) AS elem
                        WHERE sub.property_value !~ '^\s*\[.*\]\s*$' 
                          AND sub.property_value != ''
                    ) q
                    WHERE sub.property_id = ip.property_id
                ), (
                    SELECT '[]'::jsonb
                    FROM InstancePool empty_source
                    WHERE empty_source.property_id = ip.property_id
                      AND empty_source.property_value ~ '^\s*\[\s*\]\s*$'
                    LIMIT 1
                ))::text
                WHEN 'map' THEN COALESCE((
                    -- Explode objects from all matching rows and re-aggregate into one map
                    -- Ignores non-JSON strings to avoid crashing
                    SELECT jsonb_object_agg(kv.key, kv.value)
                    FROM InstancePool sub
                    CROSS JOIN LATERAL (
                        SELECT key, value FROM jsonb_each(sub.property_value::jsonb)
                        WHERE sub.property_value ~ '^\s*\{.*\}\s*$'
                        UNION ALL
                        SELECT NULL, NULL
                        WHERE sub.property_value !~ '^\s*\{.*\}\s*$' OR sub.property_value IS NULL
                    ) kv
                    WHERE sub.property_id = ip.property_id AND kv.key IS NOT NULL
                ), (
                    SELECT '{}'::jsonb
                    FROM InstancePool empty_source
                    WHERE empty_source.property_id = ip.property_id
                      AND empty_source.property_value ~ '^\s*\{\s*\}\s*$'
                    LIMIT 1
                ))::text
                ELSE (
                    -- For simple types (e.g. boolean/string), the latest update wins
                    SELECT sub.property_value
                    FROM InstancePool sub
                    WHERE sub.property_id = ip.property_id
                    ORDER BY sub.update_ts DESC
                    LIMIT 1
                )
            END AS property_value,
            2 AS priority_rank,
            'instance_merged' AS source_level
        FROM InstancePool ip
        JOIN config_property_t cp ON ip.property_id = cp.property_id
        GROUP BY ip.property_id, cp.value_type
    ),
    -- 3. Lower Priority Inheritance Layers
    InheritanceLayers AS (
        -- Product Version
        SELECT t.property_id, t.property_value, 3 AS priority_rank, 'product_version' AS source_level
        FROM snapshot_product_version_property_t t
        WHERE t.snapshot_id = p_snapshot_id
        UNION ALL
        -- Environment
        SELECT t.property_id, t.property_value, 4 AS priority_rank, 'environment' AS source_level
        FROM snapshot_environment_property_t t
        WHERE t.snapshot_id = p_snapshot_id
        UNION ALL
        -- Product
        SELECT t.property_id, t.property_value, 5 AS priority_rank, 'product' AS source_level
        FROM snapshot_product_property_t t
        WHERE t.snapshot_id = p_snapshot_id
    ),
    -- 4. Combine All Levels
    AllLevels AS (
        SELECT * FROM DeploymentOverride
        UNION ALL
        SELECT * FROM MergedInstanceLevel
        UNION ALL
        SELECT * FROM InheritanceLayers
    ),
    -- 5. Determine Final Winner
    ResolvedProperties AS (
        SELECT
            ap.property_id,
            ap.property_value,
            ap.source_level,
            -- Assign rank 1 to the highest priority available for each property
            ROW_NUMBER() OVER (PARTITION BY ap.property_id ORDER BY ap.priority_rank ASC) as rn
        FROM AllLevels ap
        WHERE ap.property_value IS NOT NULL
    )
    -- Final Select
    SELECT
        gen_random_uuid(),
        p_snapshot_id,
        c.config_phase,
        cp.config_id,
        rp.property_id,
        cp.property_name,
        cp.property_type,
        rp.property_value,
        cp.value_type,
        rp.source_level
    FROM ResolvedProperties rp
    JOIN config_property_t cp ON rp.property_id = cp.property_id
    JOIN config_t c ON cp.config_id = c.config_id
    WHERE rp.rn = 1;

END;
$$;

-- LISTEN/NOTIFY for low-latency pub/sub
CREATE OR REPLACE FUNCTION notify_event() RETURNS TRIGGER AS $$
BEGIN
  PERFORM pg_notify('event_channel', 'new_event');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS event_trigger ON outbox_message_t;
CREATE TRIGGER event_trigger
AFTER INSERT ON outbox_message_t
FOR EACH STATEMENT
EXECUTE FUNCTION notify_event();

CREATE OR REPLACE FUNCTION revoke_auth_session_by_refresh_token(
    p_host_id UUID,
    p_refresh_token UUID,
    p_admin_user VARCHAR,
    p_reason TEXT DEFAULT 'ADMIN_REVOKED'
) RETURNS UUID AS $$
DECLARE
    v_session_id UUID;
    v_auth_host_id UUID;
    v_user_id UUID;
    v_client_id UUID;
    v_provider_id VARCHAR(22);
BEGIN
    SELECT session_id, auth_host_id, user_id, client_id, provider_id
      INTO v_session_id, v_auth_host_id, v_user_id, v_client_id, v_provider_id
      FROM auth_refresh_token_t
     WHERE host_id = p_host_id
       AND refresh_token = p_refresh_token;

    IF v_session_id IS NULL THEN
        DELETE FROM auth_refresh_token_t
         WHERE host_id = p_host_id
           AND refresh_token = p_refresh_token;
        RETURN NULL;
    END IF;

    DELETE FROM auth_refresh_token_t
     WHERE host_id = p_host_id
       AND refresh_token = p_refresh_token;

    UPDATE auth_session_t
       SET status = 'REVOKED',
           logout_ts = CURRENT_TIMESTAMP,
           end_reason = p_reason,
           update_user = COALESCE(p_admin_user, SESSION_USER),
           update_ts = CURRENT_TIMESTAMP
     WHERE host_id = p_host_id
       AND session_id = v_session_id;

    INSERT INTO auth_session_audit_t (
        audit_id, host_id, auth_host_id, session_id, user_id, client_id, provider_id,
        event_type, result, failure_reason, metadata, update_user
    ) VALUES (
        gen_random_uuid(), p_host_id, v_auth_host_id, v_session_id, v_user_id, v_client_id, v_provider_id,
        'SESSION_REVOKED', 'SUCCESS', p_reason,
        jsonb_build_object('source', 'admin', 'refreshTokenId', p_refresh_token::text),
        COALESCE(p_admin_user, SESSION_USER)
    );

    RETURN v_session_id;
END;
$$ LANGUAGE plpgsql;


INSERT INTO user_t (user_id, language, first_name, last_name, email, user_type, verified, password)
VALUES ('01964b05-5532-7c79-8cde-191dcbd421b8', 'en', 'Steve', 'Hu', 'steve.hu@lightapi.net', 'E', true, '1000:5b39342c202d37372c203132302c202d3132302c2034372c2032332c2034352c202d34342c202d31362c2034372c202d35392c202d35362c2039302c202d352c202d38322c202d32385d:949e6fcf9c4bb8a3d6a8c141a3a9182a572fb95fe8ccdc93b54ba53df8ef2e930f7b0348590df0d53f242ccceeae03aef6d273a34638b49c559ada110ec06992');

INSERT INTO org_t (domain, org_name, org_desc, org_owner) VALUES ('lightapi.net', 'Light Api Portal', 'Light Api Portal', '01964b05-5532-7c79-8cde-191dcbd421b8');

INSERT INTO host_t (host_id, domain, sub_domain, host_owner) VALUES ('01964b05-552a-7c4b-9184-6857e7f3dc5f', 'lightapi.net', 'dev', '01964b05-5532-7c79-8cde-191dcbd421b8');

INSERT INTO user_host_t (host_id, user_id, current)  values ('01964b05-552a-7c4b-9184-6857e7f3dc5f', '01964b05-5532-7c79-8cde-191dcbd421b8', true);

INSERT INTO employee_t (host_id, employee_id, user_id, title, manager_id, hire_date) VALUES ('01964b05-552a-7c4b-9184-6857e7f3dc5f', 'sh35', '01964b05-5532-7c79-8cde-191dcbd421b8', 'Consulant API Platform', null, '2023-06-18');
