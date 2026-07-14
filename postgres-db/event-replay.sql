\connect configserver

BEGIN;

-- Event replay Phase 1 is additive and remains dormant while every runtime
-- feature gate is disabled. Existing DLQ, notification, outbox, and consumer
-- offset tables are deliberately untouched.

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
    payload_ciphertext       BYTEA,
    payload_object_uri       VARCHAR(2048),
    payload_object_version   VARCHAR(255),
    payload_key_id           VARCHAR(255) NOT NULL,
    payload_wrapped_key      BYTEA NOT NULL,
    payload_iv               BYTEA NOT NULL,
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
        (payload_storage = 'DATABASE'
            AND payload_ciphertext IS NOT NULL
            AND payload_object_uri IS NULL
            AND payload_object_version IS NULL)
        OR (payload_storage = 'OBJECT'
            AND payload_ciphertext IS NULL
            AND payload_object_uri IS NOT NULL
            AND payload_object_version IS NOT NULL)
    ),
    CONSTRAINT event_projection_deferred_crypto_ck CHECK(
        octet_length(payload_iv) = 12 AND octet_length(payload_wrapped_key) > 0
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

CREATE TABLE IF NOT EXISTS event_replay_backfill_checkpoint_t (
    job_name VARCHAR(128) NOT NULL, source_processor VARCHAR(16) NOT NULL,
    cursor_offset BIGINT NOT NULL DEFAULT -1,
    cursor_host_id UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',
    cursor_consumer_group VARCHAR(255) NOT NULL DEFAULT '', cursor_transaction_id VARCHAR(255) NOT NULL DEFAULT '',
    status VARCHAR(16) NOT NULL DEFAULT 'READY', examined_transactions BIGINT NOT NULL DEFAULT 0,
    indexed_transactions BIGINT NOT NULL DEFAULT 0, unresolved_transactions BIGINT NOT NULL DEFAULT 0,
    change_ticket VARCHAR(255) NOT NULL, scope_digest CHAR(64) NOT NULL,
    last_worker_id VARCHAR(255), last_error_code VARCHAR(128),
    last_error_message VARCHAR(2048), created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, completed_ts TIMESTAMPTZ,
    CONSTRAINT event_replay_backfill_checkpoint_pk PRIMARY KEY(job_name),
    CONSTRAINT event_replay_backfill_checkpoint_source_ck CHECK(source_processor IN ('DATABASE','KAFKA')),
    CONSTRAINT event_replay_backfill_checkpoint_status_ck CHECK(status IN ('READY','RUNNING','COMPLETED','FAILED')),
    CONSTRAINT event_replay_backfill_checkpoint_counts_ck CHECK(examined_transactions>=0 AND indexed_transactions>=0 AND unresolved_transactions>=0 AND indexed_transactions+unresolved_transactions<=examined_transactions),
    CONSTRAINT event_replay_backfill_checkpoint_ticket_ck CHECK(length(btrim(change_ticket))>0),
    CONSTRAINT event_replay_backfill_checkpoint_scope_ck CHECK(scope_digest~'^[0-9a-f]{64}$'),
    CONSTRAINT event_replay_backfill_checkpoint_error_ck CHECK((status<>'FAILED' AND last_error_code IS NULL AND last_error_message IS NULL) OR (status='FAILED' AND last_error_code IS NOT NULL AND last_error_message IS NOT NULL))
);
CREATE TABLE IF NOT EXISTS event_replay_backfill_issue_t (
    job_name VARCHAR(128) NOT NULL, issue_id UUID NOT NULL, host_id UUID NOT NULL,
    source_processor VARCHAR(16) NOT NULL, consumer_group VARCHAR(255) NOT NULL,
    transaction_id VARCHAR(255) NOT NULL, error_code VARCHAR(128) NOT NULL,
    error_message VARCHAR(2048) NOT NULL, observation_count INTEGER NOT NULL DEFAULT 1,
    first_observed_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_observed_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_ts TIMESTAMPTZ, resolution VARCHAR(2048),
    CONSTRAINT event_replay_backfill_issue_pk PRIMARY KEY(job_name,issue_id),
    CONSTRAINT event_replay_backfill_issue_job_fk FOREIGN KEY(job_name) REFERENCES event_replay_backfill_checkpoint_t(job_name) ON DELETE RESTRICT,
    CONSTRAINT event_replay_backfill_issue_host_fk FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_backfill_issue_source_ck CHECK(source_processor IN ('DATABASE','KAFKA')),
    CONSTRAINT event_replay_backfill_issue_count_ck CHECK(observation_count>0),
    CONSTRAINT event_replay_backfill_issue_resolution_ck CHECK((resolved_ts IS NULL AND resolution IS NULL) OR (resolved_ts IS NOT NULL AND length(btrim(resolution))>0)),
    CONSTRAINT event_replay_backfill_issue_uk UNIQUE(job_name,source_processor,host_id,consumer_group,transaction_id,error_code)
);
CREATE TABLE IF NOT EXISTS event_replay_rollout_audit_t (
    host_id UUID, rollout_audit_id UUID NOT NULL, stage VARCHAR(32) NOT NULL,
    outcome VARCHAR(32) NOT NULL, change_ticket VARCHAR(255) NOT NULL,
    actor_id VARCHAR(255) NOT NULL, config_digest VARCHAR(64) NOT NULL,
    evidence JSONB NOT NULL DEFAULT '{}'::jsonb, created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT event_replay_rollout_audit_pk PRIMARY KEY(rollout_audit_id),
    CONSTRAINT event_replay_rollout_audit_host_fk FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    CONSTRAINT event_replay_rollout_audit_stage_ck CHECK(stage IN ('SCHEMA','DATABASE_CAPTURE','KAFKA_CAPTURE','BACKFILL','READ_ONLY','DRY_RUN','NON_PROD_EXECUTION','PRODUCTION_CANARY','EXPANDED','ROLLBACK')),
    CONSTRAINT event_replay_rollout_audit_outcome_ck CHECK(outcome IN ('PRECHECK_PASSED','ENABLED','VERIFIED','ROLLED_BACK','FAILED')),
    CONSTRAINT event_replay_rollout_audit_text_ck CHECK(length(btrim(change_ticket))>0 AND length(btrim(actor_id))>0 AND config_digest ~ '^[0-9a-f]{64}$'),
    CONSTRAINT event_replay_rollout_audit_evidence_ck CHECK(jsonb_typeof(evidence)='object')
);

CREATE OR REPLACE FUNCTION protect_event_replay_rollout_audit_v1()
RETURNS trigger LANGUAGE plpgsql AS $body$
BEGIN
    RAISE EXCEPTION 'event replay rollout evidence is append-only';
END $body$;
CREATE TRIGGER event_replay_rollout_audit_append_guard_v1
BEFORE UPDATE OR DELETE ON event_replay_rollout_audit_t
FOR EACH ROW EXECUTE FUNCTION protect_event_replay_rollout_audit_v1();

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
CREATE INDEX IF NOT EXISTS event_replay_backfill_checkpoint_status_idx
    ON event_replay_backfill_checkpoint_t(status,updated_ts);
CREATE INDEX IF NOT EXISTS event_replay_backfill_issue_open_idx
    ON event_replay_backfill_issue_t(job_name,last_observed_ts) WHERE resolved_ts IS NULL;
CREATE INDEX IF NOT EXISTS event_replay_rollout_audit_ticket_idx
    ON event_replay_rollout_audit_t(change_ticket,created_ts DESC);
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

COMMIT;
