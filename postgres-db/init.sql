CREATE DATABASE configserver;
\c configserver;

-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

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

DROP TABLE IF EXISTS agent_definition_t CASCADE;

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
    transaction_id UUID NOT NULL           -- Generated UUID to group all events belong the same transaction
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
    tool_metadata        TEXT,                    -- JSON tool metadata. {"destructive": true, "read_only": false}
    routing_domain       VARCHAR(128),
    semantic_namespace   VARCHAR(128),
    sensitivity_tier     VARCHAR(64),
    semantic_weight      REAL DEFAULT 1.0,
    source_protocol      VARCHAR(50),
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

CREATE INDEX idx_api_endpoint_routing ON api_endpoint_t(host_id, active, routing_domain, semantic_namespace, sensitivity_tier);
CREATE INDEX idx_api_endpoint_source_protocol ON api_endpoint_t(host_id, source_protocol);
CREATE INDEX idx_api_endpoint_version_active ON api_endpoint_t(host_id, api_version_id, active);


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
    REFERENCES auth_session_t(host_id, session_id);

ALTER TABLE auth_code_t
    ADD CONSTRAINT auth_code_session_fk
    FOREIGN KEY (host_id, session_id)
    REFERENCES auth_session_t(host_id, session_id);

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
    script_content      TEXT,                  -- Source code if 'python'/'javascript'
    response_schema     JSONB,                 -- Strict output schema for tool results
    routing_domain      VARCHAR(128),          -- Macro-filtering domain for semantic routing
    semantic_namespace  VARCHAR(128),          -- Semantic namespace/owner of the tool
    sensitivity_tier    VARCHAR(64),           -- Safety/routing sensitivity tier
    semantic_weight     REAL DEFAULT 1.0,      -- Search/routing weight
    source_protocol     VARCHAR(50),           -- Source protocol such as openapi, mcp, or lightapi
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

CREATE INDEX idx_tool_host_endpoint ON tool_t(host_id, endpoint_id);
CREATE INDEX idx_tool_active ON tool_t(active);
CREATE INDEX idx_tool_name ON tool_t(name);
CREATE INDEX idx_tool_routing ON tool_t(host_id, active, routing_domain, semantic_namespace, sensitivity_tier);
CREATE INDEX idx_tool_source_protocol ON tool_t(host_id, source_protocol);
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


-- create a view to simplify the foreign key relationship.

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
        unnest.parent_col,
        unnest.child_col,
        unnest.ord
    FROM pg_constraint c
    JOIN pg_class pc ON c.confrelid = pc.oid
    JOIN pg_namespace pn ON pc.relnamespace = pn.oid
    JOIN pg_class cc ON c.conrelid = cc.oid
    JOIN pg_namespace cn ON cc.relnamespace = cn.oid
    CROSS JOIN LATERAL (
        SELECT
            unnest(c.confkey) AS parent_col,
            unnest(c.conkey) AS child_col,
            generate_series(1, array_length(c.conkey, 1)) AS ord
    ) unnest
    WHERE c.contype = 'f'
)
SELECT
    fd.parent_schema,
    fd.parent_table,
    fd.child_schema,
    fd.child_table,
    fd.constraint_name,
    -- Human readable mapping
    string_agg(
        format('%I → %I', 
            (SELECT attname FROM pg_attribute 
             WHERE attrelid = fd.parent_table_oid
               AND attnum = fd.parent_col),
            (SELECT attname FROM pg_attribute 
             WHERE attrelid = fd.child_table_oid
               AND attnum = fd.child_col)
        ), 
        ', ' ORDER BY fd.ord
    ) AS foreign_key_mapping,
    -- Structured data for trigger
    jsonb_object_agg(
        (SELECT attname FROM pg_attribute 
         WHERE attrelid = fd.parent_table_oid
           AND attnum = fd.parent_col),
        (SELECT attname FROM pg_attribute 
         WHERE attrelid = fd.child_table_oid
           AND attnum = fd.child_col)
    ) AS foreign_key_json,
    -- Arrays for easier processing
    array_agg(
        (SELECT attname FROM pg_attribute 
         WHERE attrelid = fd.parent_table_oid
           AND attnum = fd.parent_col)
        ORDER BY fd.ord
    ) AS parent_columns,
    array_agg(
        (SELECT attname FROM pg_attribute 
         WHERE attrelid = fd.child_table_oid
           AND attnum = fd.child_col)
        ORDER BY fd.ord
    ) AS child_columns,
    COUNT(*) AS column_count,
    fd.child_table_oid,
    fd.parent_table_oid,
    -- Check for required columns
    EXISTS (
        SELECT 1 FROM pg_attribute a
        WHERE a.attrelid = fd.parent_table_oid
          AND a.attname = 'delete_ts'
          AND NOT a.attisdropped
    ) AS parent_has_delete_ts,
    EXISTS (
        SELECT 1 FROM pg_attribute a
        WHERE a.attrelid = fd.child_table_oid
          AND a.attname = 'delete_ts'
          AND NOT a.attisdropped
    ) AS child_has_delete_ts,
    EXISTS (
        SELECT 1 FROM pg_attribute a
        WHERE a.attrelid = fd.parent_table_oid
          AND a.attname = 'delete_user'
          AND NOT a.attisdropped
    ) AS parent_has_delete_user,
    EXISTS (
        SELECT 1 FROM pg_attribute a
        WHERE a.attrelid = fd.child_table_oid
          AND a.attname = 'delete_user'
          AND NOT a.attisdropped
    ) AS child_has_delete_user
FROM fk_details fd
-- Only include relationships where both tables have deletion tracking
WHERE EXISTS (
    SELECT 1 FROM pg_attribute a
    WHERE a.attrelid = fd.parent_table_oid
      AND a.attname = 'delete_ts'
      AND NOT a.attisdropped
) AND EXISTS (
    SELECT 1 FROM pg_attribute a
    WHERE a.attrelid = fd.child_table_oid
      AND a.attname = 'delete_ts'
      AND NOT a.attisdropped
)
GROUP BY 
    fd.parent_schema, fd.parent_table,
    fd.child_schema, fd.child_table,
    fd.constraint_name, fd.constraint_id, 
    fd.child_table_oid, fd.parent_table_oid
ORDER BY fd.parent_schema, fd.parent_table, fd.child_schema, fd.child_table;

CREATE OR REPLACE FUNCTION smart_cascade_soft_delete()
RETURNS TRIGGER AS $$
DECLARE
    fk_record RECORD;
    where_clause TEXT;
    query_text TEXT;
    column_index INT;
    current_user_name TEXT;
    deletion_context TEXT;
    deletion_context_pattern TEXT;
    delete_timestamp TIMESTAMP;
BEGIN
    -- Get current user
    current_user_name := current_user;
    
    -- Handle SOFT DELETE (active = false)
    IF NEW.active = FALSE AND OLD.active = TRUE THEN
        -- Generate deletion timestamp
        delete_timestamp := CURRENT_TIMESTAMP;
        
        -- Set deletion context
        deletion_context := format('PARENT_CASCADE_%s_%s', 
            TG_TABLE_NAME, 
            to_char(delete_timestamp, 'YYYYMMDD_HH24MISSMS')
        );
        
        -- Update parent with deletion context if columns exist
        IF EXISTS (
            SELECT 1 FROM information_schema.columns 
            WHERE table_schema = TG_TABLE_SCHEMA 
              AND table_name = TG_TABLE_NAME 
              AND column_name = 'delete_user'
        ) THEN
            NEW.delete_user := deletion_context;
        END IF;
        
        IF EXISTS (
            SELECT 1 FROM information_schema.columns 
            WHERE table_schema = TG_TABLE_SCHEMA 
              AND table_name = TG_TABLE_NAME 
              AND column_name = 'delete_ts'
        ) THEN
            NEW.delete_ts := delete_timestamp;
        END IF;
        
        -- Update parent's update columns
        NEW.update_ts := delete_timestamp;
        NEW.update_user := current_user_name;
        
        FOR fk_record IN
            SELECT *
            FROM cascade_relationships_v
            WHERE parent_schema = TG_TABLE_SCHEMA
              AND parent_table = TG_TABLE_NAME
        LOOP
            -- Build WHERE clause
            where_clause := '';
            FOR column_index IN 1..fk_record.column_count LOOP
                IF column_index > 1 THEN
                    where_clause := where_clause || ' AND ';
                END IF;
                where_clause := where_clause || format(
                    '%I = ($1).%I',
                    fk_record.child_columns[column_index],
                    fk_record.parent_columns[column_index]
                );
            END LOOP;
            
            -- Add condition to only update currently active records
            where_clause := where_clause || ' AND active = TRUE';
            
            -- Cascade the soft delete with context
            query_text := format(
                'UPDATE %I.%I 
                 SET active = FALSE,
                     delete_ts = $2, 
                     delete_user = $3,
                     update_ts = $2,
                     update_user = $4
                 WHERE %s',
                fk_record.child_schema,
                fk_record.child_table,
                where_clause
            );
            
            EXECUTE query_text USING OLD, delete_timestamp, deletion_context, current_user_name;
        END LOOP;
        
    -- Handle RESTORE (active = true)
    ELSIF NEW.active = TRUE AND OLD.active = FALSE THEN
        -- Only restore children that were deleted by parent cascade
        
        FOR fk_record IN
            SELECT *
            FROM cascade_relationships_v
            WHERE parent_schema = TG_TABLE_SCHEMA
              AND parent_table = TG_TABLE_NAME
        LOOP
            -- Pattern to match cascade deletions
            deletion_context_pattern := format('PARENT_CASCADE_%s_%%', TG_TABLE_NAME);
            
            -- Build WHERE clause
            where_clause := '';
            FOR column_index IN 1..fk_record.column_count LOOP
                IF column_index > 1 THEN
                    where_clause := where_clause || ' AND ';
                END IF;
                where_clause := where_clause || format(
                    '%I = ($1).%I',
                    fk_record.child_columns[column_index],
                    fk_record.parent_columns[column_index]
                );
            END LOOP;
            
            -- Only restore cascade-deleted records
            where_clause := where_clause || 
                ' AND delete_user LIKE $2 AND active = FALSE';
            
            -- Restore the records
            query_text := format(
                'UPDATE %I.%I 
                 SET active = TRUE,
                     delete_ts = NULL, 
                     delete_user = NULL,
                     update_ts = CURRENT_TIMESTAMP,
                     update_user = $3
                 WHERE %s',
                fk_record.child_schema,
                fk_record.child_table,
                where_clause
            );
            
            EXECUTE query_text USING OLD, deletion_context_pattern, current_user_name;
        END LOOP;
        
        -- Clear parent's deletion context
        IF EXISTS (
            SELECT 1 FROM information_schema.columns 
            WHERE table_schema = TG_TABLE_SCHEMA 
              AND table_name = TG_TABLE_NAME 
              AND column_name = 'delete_user'
        ) THEN
            NEW.delete_user := NULL;
        END IF;
        
        IF EXISTS (
            SELECT 1 FROM information_schema.columns 
            WHERE table_schema = TG_TABLE_SCHEMA 
              AND table_name = TG_TABLE_NAME 
              AND column_name = 'delete_ts'
        ) THEN
            NEW.delete_ts := NULL;
        END IF;
        
        -- Update parent's update columns
        NEW.update_ts := CURRENT_TIMESTAMP;
        NEW.update_user := current_user_name;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



-- Apply cascade triggers only to tables that have BOTH active AND delete_ts columns
DO $$
DECLARE
    table_record RECORD;
    has_active_column BOOLEAN;
    has_delete_ts_column BOOLEAN;
BEGIN
    FOR table_record IN
        SELECT 
            n.nspname AS schema_name,
            c.relname AS table_name,
            c.oid AS table_oid
        FROM pg_class c
        JOIN pg_namespace n ON c.relnamespace = n.oid
        WHERE c.relkind = 'r'  -- Regular tables only
          AND n.nspname NOT IN ('pg_catalog', 'information_schema')
          AND EXISTS (
              SELECT 1 FROM pg_constraint con
              JOIN pg_class ref ON con.confrelid = ref.oid
              WHERE con.contype = 'f'
                AND ref.oid = c.oid
          )
    LOOP
        -- Check if table has required columns
        SELECT EXISTS (
            SELECT 1 FROM pg_attribute a
            WHERE a.attrelid = table_record.table_oid
              AND a.attname = 'active'
              AND NOT a.attisdropped
        ) INTO has_active_column;
        
        SELECT EXISTS (
            SELECT 1 FROM pg_attribute a
            WHERE a.attrelid = table_record.table_oid
              AND a.attname = 'delete_ts'
              AND NOT a.attisdropped
        ) INTO has_delete_ts_column;
        
        IF NOT (has_active_column AND has_delete_ts_column) THEN
            RAISE NOTICE 'Skipping %.% - missing required columns (active: %, delete_ts: %)', 
                table_record.schema_name, table_record.table_name,
                has_active_column, has_delete_ts_column;
            CONTINUE;
        END IF;
        
        -- Drop existing trigger if it exists
        EXECUTE format(
            'DROP TRIGGER IF EXISTS trg_cascade_soft_ops ON %I.%I',
            table_record.schema_name, table_record.table_name
        );
        
        -- Create new trigger
        EXECUTE format(
            'CREATE TRIGGER trg_cascade_soft_ops
             AFTER UPDATE OF active ON %I.%I
             FOR EACH ROW
             EXECUTE FUNCTION smart_cascade_soft_delete()',
            table_record.schema_name, table_record.table_name
        );
        
        RAISE NOTICE 'Created cascade trigger on %.%', 
            table_record.schema_name, table_record.table_name;
    END LOOP;
END $$;


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
                WHEN 'list' THEN (
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
                )::text
                WHEN 'map' THEN (
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
                )::text
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
