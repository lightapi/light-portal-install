-- Keep fresh local installs aligned with the additive Portal DB lifecycle patch.
ALTER TABLE knowledge_sync_run_t
    DROP CONSTRAINT knowledge_sync_run_t_state_check,
    ADD CONSTRAINT knowledge_sync_run_state_v2_ck CHECK(state IN (
        'ACCEPTED', 'QUEUED', 'RUNNING', 'SUCCEEDED', 'FAILED',
        'PAUSED_BUDGET', 'CANCELLED'
    )),
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
