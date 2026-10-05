#!/usr/bin/env bash
set -euo pipefail

database_user="${POSTGRES_USER:-postgres}"
bundle_root="${OPERATIONAL_BUNDLE_ROOT:-/opt/operational-store/bundle}"
manifest="${OPERATIONAL_DATABASE_MANIFEST:-/opt/operational-store/operational-databases.tsv}"
secret_root="${OPERATIONAL_HOST_SECRET_ROOT:-/run/secrets/operational-hosts}"
database_host="${OPERATIONAL_DATABASE_HOST:-postgres}"
database_port="${OPERATIONAL_DATABASE_PORT:-5432}"
bundle_version="${OPERATIONAL_BUNDLE_VERSION:-2.7.0}"
contract_generation="${OPERATIONAL_CONTRACT_GENERATION:-2}"
python3 "$(dirname "$bundle_root")/bin/bundle_contract.py" "$bundle_root" >/dev/null
actual_bundle_version="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["bundleVersion"])' "$bundle_root/manifest.json")"
[[ "$bundle_version" == "$actual_bundle_version" ]] || { echo "operational-databases-bootstrap: bundle version mismatch" >&2; exit 1; }

fail() {
  echo "operational-databases-bootstrap: $*" >&2
  exit 1
}

[[ -f "$manifest" ]] || fail "database manifest is missing"
[[ -f "$bundle_root/migration-order.tsv" ]] || fail "migration order is missing"
[[ "$database_host" =~ ^[A-Za-z0-9._-]+$ ]] || fail "invalid database host"
[[ "$database_port" =~ ^[0-9]{1,5}$ ]] || fail "invalid database port"
[[ "$bundle_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail "invalid bundle version"
[[ "$contract_generation" =~ ^[1-9][0-9]*$ ]] || fail "invalid contract generation"
if ! (cd "$bundle_root" && sha256sum -c bundle.sha256 >/dev/null); then
  fail "bundle checksum verification failed"
fi

# W7 preparation and startup share this local lock. External placement
# quiescence is separately owner-enforced; this lock is not distributed proof.
operations_root="$(cd -- "$bundle_root/.." && pwd)"
state_dir="$operations_root/.runtime/w7"
[[ -d "$state_dir" ]] || fail "W7 preparation is missing"
exec 9>"$state_dir/w7.lock"
flock -n 9 || fail "W7 preparation or startup is in progress"
local_fresh_init="${E04_LOCAL_FRESH_INIT:-false}"
if [[ "$local_fresh_init" == true ]]; then
  # Local owner-authorized fresh databases only. Never initialize configserver,
  # another deployment, a populated database, or a partially installed schema.
  [[ "$operations_root" == /opt/operational-store && "${PORTAL_DB_TOPOLOGY:-}" == separate ]] || fail "fresh init is local separate topology only"
  [[ "$(awk -F '\t' 'NF && $1 !~ /^#/ {print $1}' "$manifest" | sort | paste -sd , -)" == operations,operations_networknt,operations_taiji ]] || fail "fresh init database allowlist mismatch"
  for fresh_database in operations operations_networknt operations_taiji; do
    fresh_empty="$(psql -U "$database_user" -d "$fresh_database" -X -tAc "SELECT NOT EXISTS(SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname NOT IN ('pg_catalog','information_schema') AND n.nspname NOT LIKE 'pg_%' AND c.relkind IN ('r','p','v','m','f','S') AND NOT EXISTS(SELECT 1 FROM pg_depend d JOIN pg_extension e ON e.oid=d.refobjid WHERE d.classid='pg_class'::regclass AND d.objid=c.oid AND d.refclassid='pg_extension'::regclass AND d.deptype='e'))")"
    [[ "$fresh_empty" == t ]] || fail "fresh init requires all operational databases empty"
  done
else
  bash "$operations_root/bin/w7-startup-guard.sh" "$operations_root" --lock-held || fail "W7 preparation changed"
fi
# Preparation must finish in EVERY database before any startup copy/apply,
# identity update or credential rotation. A stale ready file cannot authorize
# replay of a missing migration. Normal startup below therefore only skips
# existing accepted entries; it never enables admission.
if [[ "$local_fresh_init" != true ]]; then
while IFS=$'\t' read -r db_name _host _scope _binding _digest extra; do
  [[ -n "$db_name" && "$db_name" != \#* ]] || continue
  [[ "$db_name" =~ ^[a-z][a-z0-9_]{0,62}$ && -z "${extra:-}" ]] || fail "invalid prepared database manifest"
  while IFS=$'\t' read -r order owner schema migration _path digest; do
    [[ -n "$order" && "$order" != \#* ]] || continue
    [[ "$owner" =~ ^[a-z][a-z0-9-]*$ && "$schema" =~ ^[a-z][a-z0-9_]*$ && "$migration" =~ ^[0-9]{4}_[a-z0-9_]+$ ]] || fail "invalid prepared migration"
    recorded="$(psql -U "$database_user" -d "$db_name" -X -tAc "SELECT migration_digest FROM operational_meta.operational_schema_migration_t WHERE migration_owner='$owner' AND schema_name='$schema' AND migration_id='$migration'")"
    [[ "$recorded" == "sha256:$digest" ]] || fail "W7 schema preparation incomplete or changed"
  done < "$bundle_root/migration-order.tsv"
  ready="$(psql -U "$database_user" -d "$db_name" -X -tAc "SELECT to_regprocedure('workflow_ops.workflow_claim_host_task_v2(uuid,integer,text[])') IS NOT NULL AND to_regclass('workflow_ops.workflow_operation_receipt_t') IS NOT NULL")"
  [[ "$ready" == t ]] || fail "W7 reactivation requires reviewed schema restoration"
done < "$manifest"
fi

umask 077
mkdir -p "$secret_root"
chmod 700 "$secret_root"

service_contracts=(
  "agent|agent_runtime|OPERATIONAL_DATABASE_URL|operational-database-url"
  "execution|execution_runtime|EXECUTION_DATABASE_URL|execution-database-url"
  "workflow|workflow_runtime|WORKFLOW_DATABASE_URL|workflow-database-url"
  "a2a|a2a_runtime|A2A_DATABASE_URL|a2a-database-url"
  "gateway|gateway_runtime|GATEWAY_DATABASE_URL|gateway-database-url"
  "audit|audit_publisher|AUDIT_DATABASE_URL|audit-database-url"
  "artifact|artifact_runtime|ARTIFACT_DATABASE_URL|artifact-database-url"
  "deployer|deployer_runtime|DEPLOYER_DATABASE_URL|deployer-database-url"
)

prepare_database_urls() {
  local database_name="$1"
  local host_fqdn="$2"
  local host_secret_dir="$secret_root/$host_fqdn"
  local service role_suffix environment_name url_name role_name password_file url_file
  local candidate_url password temporary_file url_pattern

  mkdir -p "$host_secret_dir"
  chmod 700 "$host_secret_dir"

  for contract in "${service_contracts[@]}"; do
    IFS='|' read -r service role_suffix environment_name url_name <<<"$contract"
    role_name="${database_name}_${role_suffix}"
    password_file="$host_secret_dir/.${service}-runtime-password"
    url_file="$host_secret_dir/$url_name"
    candidate_url=""

    if [[ "$database_name" == "operations" ]]; then
      candidate_url="${!environment_name:-}"
      if [[ -z "$candidate_url" && -s "/run/secrets/$url_name" ]]; then
        candidate_url="$(<"/run/secrets/$url_name")"
      fi
    fi
    if [[ -z "$candidate_url" && -s "$url_file" ]]; then
      candidate_url="$(<"$url_file")"
    fi

    url_pattern="^postgres://${role_name}:([0-9a-f]{64})@([A-Za-z0-9._-]+):([0-9]{1,5})/${database_name}$"
    if [[ -n "$candidate_url" ]]; then
      [[ "$candidate_url" =~ $url_pattern ]] || fail "invalid $service URL contract for $host_fqdn"
      [[ "${BASH_REMATCH[2]}" == "$database_host" && "${BASH_REMATCH[3]}" == "$database_port" ]] ||
        fail "$service URL target mismatch for $host_fqdn"
      password="${BASH_REMATCH[1]}"
    elif [[ -s "$password_file" ]]; then
      password="$(<"$password_file")"
      [[ "$password" =~ ^[0-9a-f]{64}$ ]] || fail "invalid stored $service credential for $host_fqdn"
      candidate_url="postgres://${role_name}:${password}@${database_host}:${database_port}/${database_name}"
    else
      password="$(od -An -N32 -tx1 /dev/urandom | tr -d ' \n')"
      candidate_url="postgres://${role_name}:${password}@${database_host}:${database_port}/${database_name}"
    fi

    temporary_file="$(mktemp "$host_secret_dir/.${service}.XXXXXX")"
    printf '%s' "$password" >"$temporary_file"
    mv -f "$temporary_file" "$password_file"
    temporary_file="$(mktemp "$host_secret_dir/.${service}-url.XXXXXX")"
    printf '%s' "$candidate_url" >"$temporary_file"
    mv -f "$temporary_file" "$url_file"
    chmod 600 "$password_file" "$url_file"
    printf -v "$environment_name" '%s' "$candidate_url"
    export "$environment_name"
  done
}

apply_database() {
  local database_name="$1"
  local host_fqdn="$2"
  local scope_root_id="$3"
  local binding_id="$4"
  local binding_digest="$5"
  local database_exists migration_count=0 ledger_exists existing_digest actual_sha256
  local order migration_owner schema_name migration_id migration_path migration_sha256
  local temporary_dir rendered_migration actual_identity expected_identity legacy_scope_root_id
  local contract service role_suffix environment_name url_name role_name database_url password url_pattern

  database_exists="$(psql -U "$database_user" -d postgres -X -tAc     "SELECT 1 FROM pg_database WHERE datname = '$database_name'")"
  if [[ "$database_exists" != "1" ]]; then
    createdb -U "$database_user" "$database_name"
  fi
  psql -U "$database_user" -d postgres -X --quiet --set=ON_ERROR_STOP=1 \
    -c "REVOKE CONNECT ON DATABASE $database_name FROM PUBLIC" >/dev/null

  temporary_dir="$(mktemp -d)"
  while IFS=$'\t' read -r order migration_owner schema_name migration_id migration_path migration_sha256; do
    [[ -n "$order" && "$order" != \#* ]] || continue
    [[ "$order" =~ ^[1-9][0-9]*$ ]] || fail "invalid migration order"
    [[ "$migration_owner" =~ ^[a-z][a-z0-9-]*$ ]] || fail "invalid migration owner"
    [[ "$schema_name" =~ ^[a-z][a-z0-9_]*$ ]] || fail "invalid migration schema"
    [[ "$migration_id" =~ ^[0-9]{4}_[a-z0-9_]+$ ]] || fail "invalid migration ID"
    [[ "$migration_path" =~ ^crates/[a-z0-9-]+/migrations/[a-z0-9-]+-postgres/[0-9]{4}_[a-z0-9_]+\.sql$ ]] ||
      fail "invalid migration path"
    [[ "$migration_sha256" =~ ^[0-9a-f]{64}$ ]] || fail "invalid migration checksum"
    [[ -f "$bundle_root/$migration_path" ]] || fail "migration file is missing"
    actual_sha256="$(sha256sum "$bundle_root/$migration_path" | awk '{print $1}')"
    [[ "$actual_sha256" == "$migration_sha256" ]] || fail "migration checksum mismatch for $migration_id"

    ledger_exists="$(psql -U "$database_user" -d "$database_name" -X -tAc       "SELECT to_regclass('operational_meta.operational_schema_migration_t') IS NOT NULL")"
    existing_digest=""
    if [[ "$ledger_exists" == "t" ]]; then
      existing_digest="$(psql -U "$database_user" -d "$database_name" -X -tAc         "SELECT migration_digest FROM operational_meta.operational_schema_migration_t WHERE migration_owner = '$migration_owner' AND schema_name = '$schema_name' AND migration_id = '$migration_id'")"
    fi
    if [[ -n "$existing_digest" ]]; then
      [[ "$existing_digest" == "sha256:$migration_sha256" ]] ||
        fail "applied migration checksum drift for $database_name/$migration_id"
    else
      rendered_migration="$temporary_dir/$migration_id.sql"
      sed         -e "s/operations_/${database_name}_/g"         -e "s/ON DATABASE operations/ON DATABASE ${database_name}/g"         -e "s/IN DATABASE operations/IN DATABASE ${database_name}/g"         -e "s/database_identity = 'operations'/database_identity = '${database_name}'/g"         "$bundle_root/$migration_path" >"$rendered_migration"
      {
        printf 'BEGIN;\n'
        if [[ "$local_fresh_init" == true && "$migration_owner" == workflow-store ]]; then
          printf 'SET LOCAL ROLE %s_workflow_migrator;\n' "$database_name"
        fi
        sed -e '/^BEGIN;$/d' -e '/^COMMIT;$/d' "$rendered_migration"
        if [[ "$local_fresh_init" == true && "$migration_owner" == workflow-store ]]; then
          printf '\nRESET ROLE;\n'
        fi
        printf "\nINSERT INTO operational_meta.operational_schema_migration_t (migration_owner, schema_name, migration_id, migration_digest, bundle_version, contract_generation) VALUES ('%s', '%s', '%s', 'sha256:%s', '%s', %s);\n"           "$migration_owner" "$schema_name" "$migration_id" "$migration_sha256" "$bundle_version" "$contract_generation"
        printf 'COMMIT;\n'
      } | psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1 >/dev/null
    fi
    migration_count=$((migration_count + 1))
  done <"$bundle_root/migration-order.tsv"
  rm -rf -- "$temporary_dir"
  (( migration_count > 0 )) || fail "bundle has no ordered migrations"

  psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1     --set=scope_root_id="$scope_root_id"     --set=database_identity="$database_name"     --set=host_fqdn="$host_fqdn"     --set=meta_role="${database_name}_meta_migrator" <<'SQL' >/dev/null
CREATE TABLE IF NOT EXISTS operational_meta.operational_database_identity_t (
    singleton BOOLEAN PRIMARY KEY DEFAULT TRUE CHECK (singleton),
    scope_root_id UUID NOT NULL UNIQUE,
    database_identity VARCHAR(63) NOT NULL UNIQUE,
    host_fqdn VARCHAR(253) NOT NULL UNIQUE,
    initialized_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE operational_meta.operational_database_identity_t OWNER TO :"meta_role";
REVOKE ALL ON operational_meta.operational_database_identity_t FROM PUBLIC;
INSERT INTO operational_meta.operational_database_identity_t (
    singleton, scope_root_id, database_identity, host_fqdn
)
SELECT TRUE, :'scope_root_id'::uuid, :'database_identity', :'host_fqdn'
WHERE NOT EXISTS (
    SELECT 1 FROM operational_meta.operational_database_identity_t
);
SQL

  actual_identity="$(psql -U "$database_user" -d "$database_name" -X -tA -F '|' -c     "SELECT scope_root_id, database_identity, host_fqdn FROM operational_meta.operational_database_identity_t")"
  expected_identity="$scope_root_id|$database_name|$host_fqdn"
  legacy_scope_root_id=""
  case "$database_name" in
    operations_networknt) legacy_scope_root_id="6b1c2a42-b8dc-4d5f-8c94-188b58559001" ;;
    operations_taiji) legacy_scope_root_id="6b1c2a42-b8dc-4d5f-8c94-188b58559002" ;;
  esac
  if [[ -n "$legacy_scope_root_id" && "$actual_identity" == "$legacy_scope_root_id|$database_name|$host_fqdn" ]]; then
    psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1 \
      --set=legacy_scope_root_id="$legacy_scope_root_id" \
      --set=scope_root_id="$scope_root_id" \
      --set=database_identity="$database_name" \
      --set=host_fqdn="$host_fqdn" <<'SQL' >/dev/null
UPDATE operational_meta.operational_database_identity_t
   SET scope_root_id = :'scope_root_id'::uuid
 WHERE scope_root_id = :'legacy_scope_root_id'::uuid
   AND database_identity = :'database_identity'
   AND host_fqdn = :'host_fqdn';
SQL
    actual_identity="$(psql -U "$database_user" -d "$database_name" -X -tA -F '|' -c       "SELECT scope_root_id, database_identity, host_fqdn FROM operational_meta.operational_database_identity_t")"
  fi
  [[ "$actual_identity" == "$expected_identity" ]] ||
    fail "immutable database identity mismatch for $database_name"

  psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1 \
    --set=deployer_role="${database_name}_deployer_runtime" \
    --set=database_name="$database_name" <<'SQL' >/dev/null
SELECT format('CREATE ROLE %I LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION NOBYPASSRLS', :'deployer_role')
WHERE NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = :'deployer_role') \gexec
SELECT format('GRANT CONNECT ON DATABASE %I TO %I', :'database_name', :'deployer_role') \gexec
GRANT USAGE ON SCHEMA operational_meta TO :"deployer_role";
GRANT SELECT ON operational_meta.operational_store_binding_t,
                operational_meta.operational_database_identity_t
             TO :"deployer_role";
SQL

  psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1 \
    --set=binding_id="$binding_id" --set=binding_digest="$binding_digest" \
    --set=host_id="$scope_root_id" --set=database_identity="$database_name" \
    --set=schema_generation="$contract_generation" <<'SQL' >/dev/null
BEGIN;
UPDATE operational_meta.operational_store_binding_t
   SET active = FALSE
 WHERE active AND binding_id <> :'binding_id'::uuid;
INSERT INTO operational_meta.operational_store_binding_t (
    binding_id, binding_version, binding_digest, scope_kind, scope_id, host_id,
    environment, database_identity, deployment_profile,
    schema_contract_generation, activated_ts, active
) VALUES (
    :'binding_id'::uuid, 2, :'binding_digest', 'HOST', :'host_id'::uuid,
    :'host_id'::uuid, NULL, :'database_identity', 'CUSTOMER_MANAGED',
    :'schema_generation'::bigint, CURRENT_TIMESTAMP, TRUE
)
ON CONFLICT (binding_id) DO UPDATE SET
    binding_version = EXCLUDED.binding_version,
    binding_digest = EXCLUDED.binding_digest,
    schema_contract_generation = EXCLUDED.schema_contract_generation,
    activated_ts = CURRENT_TIMESTAMP,
    active = TRUE;
COMMIT;
SQL

  for contract in "${service_contracts[@]}"; do
    IFS='|' read -r service role_suffix environment_name url_name <<<"$contract"
    role_name="${database_name}_${role_suffix}"
    database_url="${!environment_name}"
    url_pattern="^postgres://${role_name}:([0-9a-f]{64})@([A-Za-z0-9._-]+):([0-9]{1,5})/${database_name}$"
    [[ "$database_url" =~ $url_pattern ]] || fail "invalid prepared $service URL for $host_fqdn"
    password="${BASH_REMATCH[1]}"
    psql -U "$database_user" -d "$database_name" -X --quiet --set=ON_ERROR_STOP=1       --set=runtime_role="$role_name" --set=runtime_password="$password" <<'SQL' >/dev/null
SELECT format(
    'ALTER ROLE %I LOGIN PASSWORD %L NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION NOBYPASSRLS',
    :'runtime_role', :'runtime_password'
) \gexec
GRANT SELECT ON operational_meta.operational_database_identity_t TO :"runtime_role";
SQL
  done
  echo "Operational database '$database_name' is ready for $host_fqdn (credentials redacted)."
}

declare -A seen_databases=()
declare -A seen_hosts=()
database_count=0
while IFS=$'\t' read -r database_name host_fqdn scope_root_id binding_id binding_digest extra; do
  [[ -n "$database_name" && "$database_name" != \#* ]] || continue
  [[ -z "${extra:-}" ]] || fail "unexpected manifest column for $database_name"
  [[ "$database_name" =~ ^[a-z][a-z0-9_]{0,62}$ ]] || fail "invalid database name '$database_name'"
  [[ "$host_fqdn" =~ ^[a-z0-9][a-z0-9.-]{0,252}$ && "$host_fqdn" =~ [a-z0-9]$ ]] || fail "invalid Host name '$host_fqdn'"
  [[ "$scope_root_id" =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]] ||
    fail "invalid scope root for $database_name"
  [[ "$binding_id" =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]] ||
    fail "invalid binding ID for $database_name"
  [[ "$binding_digest" =~ ^sha256:[0-9a-f]{64}$ ]] || fail "invalid binding digest for $database_name"
  [[ -z "${seen_databases[$database_name]:-}" ]] || fail "duplicate database '$database_name'"
  [[ -z "${seen_hosts[$host_fqdn]:-}" ]] || fail "duplicate Host '$host_fqdn'"
  seen_databases["$database_name"]=1
  seen_hosts["$host_fqdn"]=1
  database_count=$((database_count + 1))
  prepare_database_urls "$database_name" "$host_fqdn"
  apply_database "$database_name" "$host_fqdn" "$scope_root_id" "$binding_id" "$binding_digest"
done <"$manifest"

[[ "$database_count" == 3 ]] || fail "manifest must define exactly three operational databases"
