#!/bin/sh
set -eu

knowledge_database_exists="$(psql -U "$POSTGRES_USER" -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname='knowledge'")"
if [ "$knowledge_database_exists" = "1" ]; then
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres \
        -c "REVOKE CONNECT ON DATABASE knowledge FROM PUBLIC"
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
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres \
    -c "REVOKE CONNECT ON DATABASE knowledge FROM PUBLIC"
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
    -f /docker-entrypoint-initdb.d/knowledge/roles.sql
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge \
    -f /docker-entrypoint-initdb.d/knowledge/ddl.sql

# Preserve Knowledge state when upgrading a co-located installation. Selection
# is closed over the versioned allowlist; relation-name discovery and wildcard
# export are forbidden because new Config Server control tables must never
# become operational state by accident.
set --
while IFS= read -r relation_name; do
    case "$relation_name" in
        ''|'#'*) continue ;;
        *[!a-z0-9_]*)
            echo "invalid Knowledge migration relation: $relation_name" >&2
            exit 1
            ;;
    esac
    relation_exists="$(psql -U "$POSTGRES_USER" -d configserver -tAc \
        "SELECT to_regclass('public.$relation_name') IS NOT NULL")"
    if [ "$relation_exists" = "t" ]; then
        set -- "$@" "--table=public.$relation_name"
    fi
done < /docker-entrypoint-initdb.d/knowledge/data-migration-relations-v1.txt

if [ "$#" -gt 0 ]; then
    pg_dump -U "$POSTGRES_USER" -d configserver --data-only --no-owner \
        --disable-triggers "$@" \
        | psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d knowledge >/dev/null
fi

# Prove exact row-count parity before the Config Server runtime tables are
# removed. Legacy projection and promotion rows are intentionally retained only
# by the rollback-evidence capture in the cleanup patch.
while IFS= read -r relation_name; do
    case "$relation_name" in ''|'#'*) continue ;; esac
    source_exists="$(psql -U "$POSTGRES_USER" -d configserver -tAc \
        "SELECT to_regclass('public.$relation_name') IS NOT NULL")"
    [ "$source_exists" = "t" ] || continue
    source_count="$(psql -U "$POSTGRES_USER" -d configserver -tAc \
        "SELECT count(*) FROM public.$relation_name")"
    target_count="$(psql -U "$POSTGRES_USER" -d knowledge -tAc \
        "SELECT count(*) FROM public.$relation_name")"
    [ "$source_count" = "$target_count" ] || {
        echo "Knowledge migration count mismatch for $relation_name: $source_count != $target_count" >&2
        exit 1
    }
done < /docker-entrypoint-initdb.d/knowledge/data-migration-relations-v1.txt

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
