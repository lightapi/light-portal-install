#!/bin/sh
set -eu

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d configserver \
    -c "CREATE INDEX IF NOT EXISTS idx_event_store_event_ts_id ON event_store_t(event_ts,id) WHERE event_type LIKE 'Knowledge%' OR event_type LIKE 'AgentKnowledgeBase%'"

knowledge_database_exists="$(psql -U "$POSTGRES_USER" -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname='knowledge'")"
if [ "$knowledge_database_exists" = "1" ]; then
    knowledge_database_ready="$(psql -U "$POSTGRES_USER" -d knowledge -tAc \
        "SELECT to_regclass('knowledge_job_t') IS NOT NULL
             AND to_regclass('knowledge_projection_source_cursor_t') IS NOT NULL
             AND to_regclass('knowledge_embedding_profile_runtime_v') IS NOT NULL
             AND to_regclass('event_store_t') IS NULL")"
    [ "$knowledge_database_ready" = "t" ] || {
        echo "existing knowledge database failed the boundary contract" >&2
        exit 1
    }
    exit 0
fi

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres   -c "CREATE DATABASE knowledge"

pg_dump -U "$POSTGRES_USER" -d configserver --schema-only --no-owner   | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge >/dev/null

# Preserve existing Knowledge state on upgrade/recreation.  The selector is
# intentionally limited to the local projection and data-plane tables.
pg_dump -U "$POSTGRES_USER" -d configserver --data-only --no-owner \
  --disable-triggers --table='public.knowledge_*' \
  --table='public.agent_knowledge_base_t' \
  | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge >/dev/null

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d configserver   -c "COPY cascade_relationship_policy_t TO STDOUT"   | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge       -c "COPY cascade_relationship_policy_t FROM STDIN"

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge <<'SQL'
DROP VIEW IF EXISTS knowledge_embedding_profile_runtime_v;
DROP TRIGGER IF EXISTS knowledge_embedding_profile_qualification_trg
    ON knowledge_embedding_profile_t;
ALTER TABLE knowledge_embedding_profile_t
    ADD COLUMN IF NOT EXISTS alias_name VARCHAR(255);
UPDATE knowledge_embedding_profile_t
   SET alias_name = 'kb-index'
 WHERE alias_name IS NULL;
ALTER TABLE knowledge_embedding_profile_t
    ALTER COLUMN alias_name SET DEFAULT 'kb-index',
    ALTER COLUMN alias_name SET NOT NULL;

DO $$
DECLARE relation RECORD;
BEGIN
    FOR relation IN
        SELECT tablename AS name, 'TABLE' AS kind
          FROM pg_tables
         WHERE schemaname = 'public'
           AND tablename NOT LIKE 'knowledge\_%' ESCAPE '\'
           AND tablename NOT IN ('agent_knowledge_base_t',
                                 'cascade_relationship_policy_t')
        UNION ALL
        SELECT viewname AS name, 'VIEW' AS kind
          FROM pg_views
         WHERE schemaname = 'public'
           AND viewname NOT LIKE 'knowledge\_%' ESCAPE '\'
           AND viewname <> 'cascade_relationships_v'
    LOOP
        EXECUTE format('DROP %s IF EXISTS %I CASCADE', relation.kind, relation.name);
    END LOOP;
END
$$;

CREATE VIEW knowledge_embedding_profile_runtime_v
WITH (security_barrier = true) AS
SELECT profile.profile_id, profile.profile_revision,
       profile.expected_space_id, profile.expected_space_revision,
       profile.dimension, profile.document_input_transform_version,
       profile.query_input_transform_version, profile.alias_name
  FROM knowledge_embedding_profile_t profile
 WHERE profile.active = TRUE;

GRANT SELECT ON TABLE knowledge_embedding_profile_runtime_v
    TO light_knowledge_api_role,
       light_knowledge_portal_projector_role,
       light_knowledge_worker_role;

DELETE FROM cascade_relationship_policy_t policy
 WHERE NOT EXISTS (
    SELECT 1
      FROM pg_constraint constraint_row
      JOIN pg_class child ON child.oid = constraint_row.conrelid
     WHERE constraint_row.contype = 'f'
       AND constraint_row.conname = policy.constraint_name
       AND child.relname = policy.child_table
 );

DO $$
BEGIN
    IF to_regclass('event_store_t') IS NOT NULL THEN
        RAISE EXCEPTION 'Knowledge database retained Config Server event_store_t';
    END IF;
    IF to_regclass('knowledge_job_t') IS NULL
       OR to_regclass('knowledge_projection_source_cursor_t') IS NULL
       OR to_regclass('knowledge_embedding_profile_runtime_v') IS NULL THEN
        RAISE EXCEPTION 'Knowledge database is missing required data-plane relations';
    END IF;
END
$$;
SQL
