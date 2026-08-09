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
