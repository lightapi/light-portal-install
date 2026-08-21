#!/bin/sh
set -eu

knowledge_database_exists="$(psql -U "$POSTGRES_USER" -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname='knowledge'")"
if [ "$knowledge_database_exists" = "1" ]; then
    knowledge_database_ready="$(psql -U "$POSTGRES_USER" -d knowledge -tAc \
        "SELECT to_regclass('knowledge_job_t') IS NOT NULL
             AND (to_regclass('knowledge_control_snapshot_t') IS NOT NULL
                  OR to_regclass('knowledge_projection_source_cursor_t') IS NOT NULL)
             AND to_regclass('knowledge_embedding_profile_runtime_v') IS NOT NULL
             AND to_regclass('event_store_t') IS NULL")"
    [ "$knowledge_database_ready" = "t" ] || {
        echo "existing knowledge database failed the boundary contract" >&2
        exit 1
    }
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
        -f /docker-entrypoint-initdb.d/knowledge/roles.sql
    phase2_ready="$(psql -U "$POSTGRES_USER" -d knowledge -tAc \
        "SELECT to_regclass('knowledge_control_snapshot_t') IS NOT NULL")"
    if [ "$phase2_ready" != "t" ]; then
        psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
            -f /docker-entrypoint-initdb.d/knowledge/patch_20260821_02_canonical_knowledge_boundary.sql
        psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
            -f /docker-entrypoint-initdb.d/knowledge/patch_20260821_03_snapshot_command_boundary.sql
    fi
    phase3_ready="$(psql -U "$POSTGRES_USER" -d knowledge -tAc \
        "SELECT to_regclass('knowledge_admin_audit_t') IS NOT NULL")"
    if [ "$phase3_ready" != "t" ]; then
        psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
            -f /docker-entrypoint-initdb.d/knowledge/patch_20260821_05_admin_api.sql
    fi
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d configserver \
        -f /docker-entrypoint-initdb.d/knowledge/patch_20260821_04_configserver_knowledge_control_only.sql
    exit 0
fi

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres \
    -c "CREATE DATABASE knowledge"
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
    -f /docker-entrypoint-initdb.d/knowledge/roles.sql
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
    -f /docker-entrypoint-initdb.d/knowledge/ddl.sql

# Preserve Knowledge state when upgrading a single-database installation. The
# schema always comes from the canonical Knowledge DDL; this is an explicit
# one-time data migration for owned and transitional relations only.
pg_dump -U "$POSTGRES_USER" -d configserver --data-only --no-owner \
  --disable-triggers --table='public.knowledge_*' \
  --table='public.agent_knowledge_base_t' \
  --exclude-table='public.knowledge_base_import_identity_map_t' \
  --exclude-table='public.knowledge_base_import_t' \
  --exclude-table='public.knowledge_base_manifest_export_t' \
  --exclude-table='public.knowledge_qualified_embedding_alias_v' \
  --exclude-table='public.knowledge_projection_ack_t' \
  --exclude-table='public.knowledge_projection_heartbeat_t' \
  --exclude-table='public.knowledge_projection_inbox_t' \
  --exclude-table='public.knowledge_projection_source_cursor_t' \
  --exclude-table='public.knowledge_promotion_ack_t' \
  --exclude-table='public.knowledge_promotion_outbox_t' \
  | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge >/dev/null

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d configserver   -c "COPY cascade_relationship_policy_t TO STDOUT"   | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge       -c "COPY cascade_relationship_policy_t FROM STDIN"

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge <<'SQL'
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
       OR to_regclass('knowledge_control_snapshot_t') IS NULL
       OR to_regclass('knowledge_embedding_profile_runtime_v') IS NULL THEN
        RAISE EXCEPTION 'Knowledge database is missing required data-plane relations';
    END IF;
END
$$;
SQL

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d configserver \
    -f /docker-entrypoint-initdb.d/knowledge/patch_20260821_04_configserver_knowledge_control_only.sql
