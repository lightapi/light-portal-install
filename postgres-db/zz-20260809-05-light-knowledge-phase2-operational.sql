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
