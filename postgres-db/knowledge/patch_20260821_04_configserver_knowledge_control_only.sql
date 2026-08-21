BEGIN;

DROP INDEX IF EXISTS idx_event_store_event_ts_id;

DO $$
DECLARE relation_name text;
BEGIN
    FOR relation_name IN
        SELECT c.relname
          FROM pg_class c
          JOIN pg_namespace n ON n.oid=c.relnamespace
         WHERE n.nspname='public' AND c.relkind IN ('r','p')
           AND (c.relname LIKE 'knowledge\_%' ESCAPE '\'
                OR c.relname='agent_knowledge_base_t')
           AND c.relname NOT IN (
             'knowledge_embedding_profile_t','knowledge_ingestion_policy_t',
             'knowledge_retrieval_profile_t','knowledge_base_t',
             'knowledge_source_t','agent_knowledge_base_t',
             'knowledge_base_import_identity_map_t','knowledge_base_import_t',
             'knowledge_base_manifest_export_t')
         ORDER BY c.relname
    LOOP
        EXECUTE format('DROP TABLE public.%I CASCADE',relation_name);
    END LOOP;
END
$$;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles
                WHERE rolname='light_knowledge_portal_projector_role') THEN
        REVOKE ALL ON event_store_t FROM light_knowledge_portal_projector_role;
        REVOKE USAGE ON SCHEMA public FROM light_knowledge_portal_projector_role;
    END IF;
END
$$;

COMMIT;
