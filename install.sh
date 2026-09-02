#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh [command]

Commands:
  install    Download R2 assets and start the local stack. Default.
  update     Refresh R2 assets and docker-images.env, then restart.
  assets     Download R2 assets and docker-images.env only.
  start      Start Docker Compose.
  stop       Stop Docker Compose.
  status     Show Docker Compose status.
  logs       Follow Docker Compose logs.
  uninstall  Stop the stack and optionally delete volumes.

Environment:
  LIGHT_PORTAL_VERSION       Default: VERSION file, usually latest.
  LIGHT_PORTAL_ASSET_BASE_URL
                             Default: https://cdn.networknt.com
  LIGHT_PORTAL_RELEASE_BASE_URL
                             Default: $LIGHT_PORTAL_ASSET_BASE_URL/light-portal/releases
  LIGHT_PORTAL_INSTALL_DIR   Optional target directory. If set, the script
                             copies repo files there before running.
  LIGHT_PORTAL_ENV_FILE      Optional Compose env file. Default:
                             ~/.config/lightapi/light-portal.env
  LIGHT_PORTAL_REPO_ARCHIVE  Default:
                             https://github.com/lightapi/light-portal-install/archive/refs/heads/master.tar.gz
  LLM_GATEWAY_HOST_PORT      Dedicated LLM gateway port. Default: 8444.
  LLM_GATEWAY_IMAGE          Optional dedicated llm-gateway image override.
  LLM_GATEWAY_ENVIRONMENT    Config snapshot tag. Default: dev.
  LLM_GATEWAY_RUST_LOG       Optional llm-gateway log filter override.
  GROQ_API_KEY               Optional Groq provider key for llm-gateway.
  GEMINI_API_KEY             Optional Gemini provider key for llm-gateway.
  LLM_GATEWAY_LIGHT_PORTAL_AUTHORIZATION
                             Optional override for the bundled development
                             llm-gateway Portal service token.
  IMPORT_EVENTS              Default: auto. Use false to skip event import.
  EVENT_IMPORTER_IMAGE       Default: networknt/event-importer:latest
  EVENT_IMPORT_PHYSICAL_CHUNK_EVENTS
                             Events per physical bootstrap commit. Default and
                             hard maximum: 500.
  EVENT_PROJECTION_CURSOR_ATTEMPTS
                             Maximum async projection cursor checks. Default: 300.
  EVENT_PROJECTION_CURSOR_INTERVAL
                             Seconds between projection cursor checks. Default: 1.
  PORTAL_BOOTSTRAP_ARCHIVE   Default: auto. Use false to bypass archive restore.
  LIGHT_PORTAL_BOOTSTRAP_PUBLIC_KEY
                             Release public key used to verify manifest.sig.
  EVENT_BUNDLE_KEY_DIR       Trusted event-bundle public keys named
                             <keyId>.pem. Default: release-keys.
  LIGHT_PORTAL_BOOTSTRAP_CREDENTIAL_ROTATION_HOOK
                             Executable pre-listener credential rotation hook.
  LIGHT_PORTAL_CLIENT_REDIRECT_URI
                             Default: https://local.localhost/authorization
  LIGHT_PORTAL_ASSET_CACHE_BUST
                             Optional cache-busting token for events.zip. A UTC
                             timestamp is generated for each asset refresh by
                             default.
  CLEAN_VOLUMES=true         Stop the stack and delete Docker volumes before
                             install, update, or start.
  APPLY_RELEASE_DELTAS       Default: true for update, false for install/start.
USAGE
}

log() {
  printf '[light-portal-install] %s\n' "$*"
}

die() {
  printf '[light-portal-install] error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "$1 is required but was not found in PATH"
}

command_name="${1:-install}"

if [[ "$command_name" == "-h" || "$command_name" == "--help" ]]; then
  usage
  exit 0
fi

repo_archive="${LIGHT_PORTAL_REPO_ARCHIVE:-https://github.com/lightapi/light-portal-install/archive/refs/heads/master.tar.gz}"
script_path="${BASH_SOURCE[0]:-}"
script_dir=""

if [[ -n "$script_path" && -f "$script_path" ]]; then
  script_dir="$(cd -- "$(dirname -- "$script_path")" && pwd)"
fi

if [[ -n "$script_dir" && -f "$script_dir/docker-compose.yml" ]]; then
  source_dir="$script_dir"
else
  require_command curl
  require_command tar
  source_dir="${LIGHT_PORTAL_INSTALL_DIR:-$HOME/.light-portal}"
  mkdir -p "$source_dir"
  log "bootstrapping install repo into $source_dir"
  curl -fsSL "$repo_archive" | tar -xz --strip-components=1 -C "$source_dir"
fi

if [[ -n "${LIGHT_PORTAL_INSTALL_DIR:-}" ]]; then
  mkdir -p "$LIGHT_PORTAL_INSTALL_DIR"
  if [[ "$source_dir" != "$(cd "$LIGHT_PORTAL_INSTALL_DIR" && pwd)" ]]; then
    log "copying install repo files to $LIGHT_PORTAL_INSTALL_DIR"
    cp -a "$source_dir"/. "$LIGHT_PORTAL_INSTALL_DIR"/
  fi
  cd "$LIGHT_PORTAL_INSTALL_DIR"
else
  cd "$source_dir"
fi

version="${LIGHT_PORTAL_VERSION:-}"
if [[ -z "$version" && -f VERSION ]]; then
  version="$(tr -d '[:space:]' < VERSION)"
fi
version="${version:-latest}"

asset_base_url="${LIGHT_PORTAL_ASSET_BASE_URL:-https://cdn.networknt.com}"
asset_base_url="${asset_base_url%/}"
release_base_url="${LIGHT_PORTAL_RELEASE_BASE_URL:-$asset_base_url/light-portal/releases}"
release_base_url="${release_base_url%/}"
light_portal_env_file="${LIGHT_PORTAL_ENV_FILE:-${XDG_CONFIG_HOME:-$HOME/.config}/lightapi/light-portal.env}"

compose() {
  local env_args=(--env-file .env)

  if [[ -f docker-images.env ]]; then
    env_args=(--env-file docker-images.env "${env_args[@]}")
  fi

  if [[ -f "$light_portal_env_file" ]]; then
    env_args+=(--env-file "$light_portal_env_file")
  fi

  docker compose "${env_args[@]}" "$@"
}

load_env_file_var() {
  local name="$1"
  local value

  if [[ -n "${!name:-}" || ! -f docker-images.env ]]; then
    return 0
  fi

  value="$(awk -F= -v key="$name" '$1 == key { sub(/^[^=]*=/, ""); print; exit }' docker-images.env)"
  if [[ -n "$value" ]]; then
    export "$name=$value"
  fi
}

download_file() {
  local url="$1"
  local dest="$2"
  local tmp

  mkdir -p "$(dirname -- "$dest")"
  tmp="${dest}.tmp"
  log "downloading $url"
  curl -fsSL "$url" -o "$tmp"
  mv "$tmp" "$dest"
}

cache_busted_url() {
  local url="$1"
  local token="${LIGHT_PORTAL_ASSET_CACHE_BUST:-$(date -u +%Y%m%d%H%M%S)}"
  local separator="?"

  [[ "$url" == *\?* ]] && separator="&"
  printf '%s%scachebust=%s\n' "$url" "$separator" "$token"
}

verify_event_bundle() {
  local events_bundle="$1"
  local bundle_key_dir="${EVENT_BUNDLE_KEY_DIR:-release-keys}"
  local importer_image

  [[ "$events_bundle" == /* ]] || events_bundle="$PWD/$events_bundle"
  [[ "$bundle_key_dir" == /* ]] || bundle_key_dir="$PWD/$bundle_key_dir"
  [[ -f "$events_bundle" ]] || die "signed event bundle is missing: $events_bundle"
  [[ -d "$bundle_key_dir" ]] || die "trusted event-bundle key directory is missing: $bundle_key_dir"

  require_command docker
  load_env_file_var EVENT_IMPORTER_IMAGE
  importer_image="${EVENT_IMPORTER_IMAGE:-networknt/event-importer:latest}"
  log "verifying signed event bundle before extraction"
  docker run --rm \
    -v "$(dirname -- "$events_bundle"):/bundle:ro,z" \
    -v "$bundle_key_dir:/bundle-keys:ro,z" \
    "$importer_image" \
    --verify-bundle \
    --bundle "/bundle/$(basename -- "$events_bundle")" \
    --bundle-key-dir /bundle-keys ||
    die "signed event bundle verification failed"
}

download_archive() {
  local archive_name="$1"
  local target_dir="$2"
  local archive_file="data/$archive_name"

  download_file "$asset_base_url/$archive_name" "$archive_file"
  rm -rf "$target_dir"
  mkdir -p "$target_dir"
  log "extracting $archive_file to $target_dir"
  unzip -q "$archive_file" -d "$target_dir"
}

download_archive_file() {
  local archive_name="$1"
  local member_name="$2"
  local dest="$3"
  local archive_file="data/$archive_name"
  local archive_url="$asset_base_url/$archive_name"
  local download_target="$archive_file"

  if [[ "$archive_name" == "events.zip" ]]; then
    archive_url="$(cache_busted_url "$archive_url")"
    download_target="$archive_file.candidate"
  fi
  download_file "$archive_url" "$download_target"
  if [[ "$archive_name" == "events.zip" ]]; then
    verify_event_bundle "$download_target"
    mv "$download_target" "$archive_file"
  fi
  log "extracting $member_name from $archive_file to $dest"
  unzip -p "$archive_file" "$member_name" > "$dest.tmp"
  mv "$dest.tmp" "$dest"
}

download_release_artifacts() {
  local release_url="$release_base_url/$version"
  local archive_object=""
  local signature_object=""

  require_command curl
  require_command unzip
  require_command python3

  mkdir -p data db/patches events/deltas
  download_file "$release_url/manifest.json" data/manifest.json
  download_file "$release_url/db-patches.zip" data/db-patches.zip
  download_file "$release_url/event-deltas.zip" data/event-deltas.zip

  archive_object="$(python3 scripts/bootstrap_manifest.py get \
    --manifest data/manifest.json --path bootstrapArchive.object 2>/dev/null || true)"
  signature_object="$(python3 scripts/bootstrap_manifest.py get \
    --manifest data/manifest.json --path bootstrapArchive.signatureObject 2>/dev/null || true)"
  if [[ -n "$archive_object" && -n "$signature_object" ]]; then
    download_file "$release_url/$archive_object" "data/$(basename -- "$archive_object")"
    download_file "$release_url/$signature_object" "data/$(basename -- "$signature_object")"
  else
    log "release does not publish a PostgreSQL bootstrap archive; event import remains available"
  fi

  rm -rf db/patches events/deltas
  mkdir -p db events
  unzip -q data/db-patches.zip -d .
  unzip -q data/event-deltas.zip -d .
  mkdir -p db/patches events/deltas
}

replace_literal_in_file() {
  local file="$1"
  local source="$2"
  local target="$3"

  awk -v src="$source" -v dst="$target" '
    {
      out = ""
      line = $0
      while ((pos = index(line, src)) > 0) {
        out = out substr(line, 1, pos - 1) dst
        line = substr(line, pos + length(src))
      }
      print out line
    }
  ' "$file" > "$file.tmp"
  mv "$file.tmp" "$file"
}

normalize_events_json() {
  local events_file="${1:-events.json}"
  local source_redirect_uri="${LIGHT_PORTAL_SOURCE_CLIENT_REDIRECT_URI:-https://localhost:3000/authorization}"
  local target_redirect_uri="${LIGHT_PORTAL_CLIENT_REDIRECT_URI:-https://local.localhost/authorization}"

  [[ -f "$events_file" ]] || return 0
  [[ "$source_redirect_uri" != "$target_redirect_uri" ]] || return 0

  if grep -Fq "$source_redirect_uri" "$events_file"; then
    log "normalizing OAuth client redirectUri to $target_redirect_uri"
    replace_literal_in_file "$events_file" "$source_redirect_uri" "$target_redirect_uri"
  fi
}

normalize_portal_assets() {
  local asset_dir="${1:-light-gateway-rust/lightapi}"
  local file

  [[ -d "$asset_dir" ]] || return 0

  while IFS= read -r file; do
    if grep -Fq "user_type=C" "$file"; then
      log "normalizing portal signin user_type in $file"
      replace_literal_in_file "$file" "user_type=C" "user_type=E"
    fi
  done < <(find "$asset_dir" -type f \( -name '*.js' -o -name '*.html' \))
}

download_assets() {
  local docker_env_url

  require_command curl
  require_command unzip

  mkdir -p hybrid-command/service hybrid-query/service \
    light-gateway-rust/lightapi/dist light-gateway-rust/signin/dist data

  docker_env_url="$release_base_url/$version/docker-images.env"
  download_file "$docker_env_url" docker-images.env

  if [[ ! -f .env ]]; then
    cp .env.example .env
  fi

  download_archive hybrid-command.zip hybrid-command/service
  download_archive hybrid-query.zip hybrid-query/service
  download_archive lightapi.zip light-gateway-rust/lightapi
  normalize_portal_assets light-gateway-rust/lightapi
  download_archive signin.zip light-gateway-rust/signin
  download_archive_file events.zip events.json events.json
  normalize_events_json events.json
}

start_stack() {
  require_command docker
  [[ -f .env ]] || cp .env.example .env
  ensure_knowledge_runtime
  compose up -d
}

ensure_knowledge_database() {
  log "validating the local Config Server and Knowledge schema pair"
  compose run --rm --no-deps knowledge-schema-migration
}

ensure_portal_runtime_database_access() {
  log "ensuring the Portal runtime database identity"
  psql_exec <<'SQL'
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'portal_local_runtime') THEN
    CREATE ROLE portal_local_runtime LOGIN;
  END IF;
END
$$;
ALTER ROLE portal_local_runtime LOGIN PASSWORD 'secret';
REVOKE CONNECT ON DATABASE configserver FROM PUBLIC;
GRANT CONNECT ON DATABASE configserver TO portal_local_runtime;
GRANT USAGE ON SCHEMA configserver, public TO portal_local_runtime;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configserver TO portal_local_runtime;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA configserver TO portal_local_runtime;
GRANT EXECUTE ON ALL ROUTINES IN SCHEMA configserver TO portal_local_runtime;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA configserver
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portal_local_runtime;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA configserver
  GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO portal_local_runtime;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA configserver
  GRANT EXECUTE ON ROUTINES TO portal_local_runtime;
ALTER ROLE portal_local_runtime IN DATABASE configserver
  SET search_path = configserver, public;
SQL
}

ensure_knowledge_runtime() {
  ensure_knowledge_database

  # Upgrade existing installations to the same credential boundary as a fresh
  # install. Portal runtimes retain full Config Server access but cannot
  # authenticate to the Knowledge database.
  ensure_portal_runtime_database_access

  docker exec postgres psql -U postgres -d knowledge -v ON_ERROR_STOP=1 \
    -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='light_knowledge_local_api') THEN CREATE ROLE light_knowledge_local_api LOGIN; END IF; IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='light_knowledge_local_worker') THEN CREATE ROLE light_knowledge_local_worker LOGIN; END IF; IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='light_knowledge_local_admin_api') THEN CREATE ROLE light_knowledge_local_admin_api LOGIN; END IF; END \$\$; ALTER ROLE light_knowledge_local_api PASSWORD 'knowledge-local-api'; ALTER ROLE light_knowledge_local_worker PASSWORD 'knowledge-local-worker'; ALTER ROLE light_knowledge_local_admin_api PASSWORD 'knowledge-local-admin'; GRANT light_knowledge_api_role TO light_knowledge_local_api; GRANT light_knowledge_worker_role TO light_knowledge_local_worker; GRANT light_knowledge_admin_api_role,light_knowledge_snapshot_loader_role TO light_knowledge_local_admin_api; REVOKE CONNECT ON DATABASE knowledge FROM PUBLIC; GRANT CONNECT ON DATABASE knowledge TO light_knowledge_local_api,light_knowledge_local_worker,light_knowledge_local_admin_api; ALTER ROLE light_knowledge_local_api IN DATABASE knowledge SET search_path=knowledge,public; ALTER ROLE light_knowledge_local_worker IN DATABASE knowledge SET search_path=knowledge,public; ALTER ROLE light_knowledge_local_admin_api IN DATABASE knowledge SET search_path=knowledge,public;" >/dev/null

  mkdir -p light-knowledge/objects light-knowledge/checkouts
  log "Knowledge API, administration, and worker local runtime identities are ready"
}

validate_operational_store_assets() {
  local required_file
  local bundle_dir="postgres-db/operations/bundle"

  for required_file in \
    postgres-db/operations/bin/bootstrap-operational-store.sh \
    postgres-db/operations/bin/reset-empty-operational-store.sh \
    postgres-db/operations/bin/validate-operational-store.sh \
    "$bundle_dir/manifest.json" \
    "$bundle_dir/migration-order.tsv" \
    "$bundle_dir/bundle.sha256"; do
    [[ -f "$required_file" ]] || die "required operational-store asset is missing: $required_file"
  done

  (cd "$bundle_dir" && sha256sum -c bundle.sha256 >/dev/null) ||
    die "operational-store bundle checksum verification failed"
}

validate_compose_config() {
  local required_file

  for required_file in \
    llm-gateway-rust/config/startup.yml \
    llm-gateway-rust/config/ca.pem \
    llm-gateway-rust/config/cert.pem \
    llm-gateway-rust/config/key.pem; do
    [[ -f "$required_file" ]] ||
      die "required llm-gateway config file is missing: $required_file"
  done

  validate_operational_store_assets

  log "validating Docker Compose configuration"
  compose config --quiet || die "Docker Compose configuration validation failed"
}

clean_volumes_if_requested() {
  case "${CLEAN_VOLUMES:-false}" in
    true|TRUE|1|yes|YES|y|Y)
      require_command docker
      [[ -f .env ]] || cp .env.example .env
      log "CLEAN_VOLUMES=true; stopping stack and deleting Docker volumes"
      compose down -v
      ;;
  esac
}

wait_for_postgres() {
  local max_attempts="${POSTGRES_READY_ATTEMPTS:-60}"
  local interval="${POSTGRES_READY_INTERVAL:-2}"
  local attempt=1

  while [[ "$attempt" -le "$max_attempts" ]]; do
    if docker exec postgres psql -h localhost -p 5432 -U postgres -d configserver -tAc "select 1;" >/dev/null 2>&1; then
      return 0
    fi
    sleep "$interval"
    attempt=$((attempt + 1))
  done

  return 1
}

docker_runtime_is_podman() {
  local version_output

  version_output="$(docker --version 2>&1 || true)"
  [[ "$version_output" == *podman* || "$version_output" == *Podman* ]]
}

wait_for_running_container() {
  local container_name="$1"
  local max_attempts="${BOOTSTRAP_SERVICE_READY_ATTEMPTS:-30}"
  local interval="${BOOTSTRAP_SERVICE_READY_INTERVAL:-2}"
  local attempt=1
  local status

  while [[ "$attempt" -le "$max_attempts" ]]; do
    status="$(docker inspect -f '{{.State.Status}}' "$container_name" 2>/dev/null || true)"
    if [[ "$status" == "running" ]]; then
      return 0
    fi
    sleep "$interval"
    attempt=$((attempt + 1))
  done

  return 1
}

wait_for_healthy_container() {
  local container_name="$1"
  local max_attempts="${LIGHT_OAUTH_READY_ATTEMPTS:-90}"
  local interval="${LIGHT_OAUTH_READY_INTERVAL:-2}"
  local attempt=1
  local status

  while [[ "$attempt" -le "$max_attempts" ]]; do
    status="$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}missing{{end}}' "$container_name" 2>/dev/null || true)"
    if [[ "$status" == "healthy" ]]; then
      return 0
    fi
    sleep "$interval"
    attempt=$((attempt + 1))
  done

  return 1
}

start_light_oauth() {
  log "starting light-oauth after event bootstrap"
  compose up -d light-oauth
  wait_for_healthy_container light-oauth || die "light-oauth did not become healthy"
}

start_event_processors() {
  log "starting event bootstrap services"
  compose up -d postgres
  wait_for_postgres || die "postgres did not become ready for TCP connections"

  # Recreate the processors so refreshed JAR/config directories and a repaired
  # snapshot-signing file cannot remain attached through stale bind mounts.
  compose up -d --no-deps --force-recreate hybrid-command hybrid-query
  wait_for_running_container hybrid-command || die "hybrid-command did not start"
  wait_for_running_container hybrid-query || die "hybrid-query did not start"
  wait_for_postgres || die "postgres stopped accepting TCP connections"
}

event_store_count() {
  docker exec postgres psql -h localhost -p 5432 -U postgres -d configserver -tAc "select count(*) from event_store_t;" 2>/dev/null | tr -d '[:space:]'
}

wait_for_baseline_projection_cursor() {
  local max_attempts="${EVENT_PROJECTION_CURSOR_ATTEMPTS:-300}"
  local interval="${EVENT_PROJECTION_CURSOR_INTERVAL:-1}"
  local attempt=1
  local state

  while [[ "$attempt" -le "$max_attempts" ]]; do
    state="$(docker exec postgres psql -h localhost -p 5432 -U postgres \
      -d configserver -tAc "
        SELECT CASE WHEN COALESCE((
          SELECT next_offset
          FROM consumer_offsets
          WHERE group_id = 'user-query-group'
            AND topic_id = 1
            AND partition_id = 0
        ), 0) >= (SELECT next_offset FROM log_counter WHERE id = 1)
        THEN 'ready' ELSE 'waiting' END;
      " 2>/dev/null | tr -d '[:space:]' || true)"
    [[ "$state" == "ready" ]] && return 0
    sleep "$interval"
    attempt=$((attempt + 1))
  done

  die "event projection cursor did not catch up after $max_attempts attempts"
}

validate_runnable_agent_snapshot() {
  local required_agent_policy_property_count="33"
  local runnable_agent_snapshot_count
  local required_agent_policy_properties="'runtimePolicy.publicationId','runtimePolicy.releaseVersion','runtimePolicy.policySnapshotId','runtimePolicy.policyVersion','runtimePolicy.policyDigest','runtimePolicy.contentDigest','runtimePolicy.audience','runtimePolicy.host','runtimePolicy.serviceId','runtimePolicy.envTag','runtimePolicy.sourceEventSequence','runtimePolicy.schemaVersion','runtimePolicy.createdAt','runtimePolicy.validFrom','runtimePolicy.refreshAfter','runtimePolicy.expiresAt','runtimePolicy.revocationEpoch','runtimePolicy.compatibilityGeneration','portalAssociation.runtimeInstanceId','agentPolicy.agentDefId','agentPolicy.definitionVersion','agentPolicy.prompt.system','agentPolicy.model.alias','agentPolicy.policySnapshot.snapshotId','agentPolicy.policySnapshot.definitionDigest','agentPolicy.policySnapshot.productProfileDigest','agentPolicy.policySnapshot.modelDigest','agentPolicy.policySnapshot.catalogDigest','agentPolicy.policySnapshot.memoryDigest','agentPolicy.policySnapshot.executionDigest','agentPolicy.policySnapshot.channelDigest','agentPolicy.policySnapshot.dataBoundaryDigest','agentPolicy.policySnapshot.tools'"

  runnable_agent_snapshot_count="$(docker exec postgres \
    psql -h localhost -p 5432 -U postgres -d configserver -tAc \
    "SELECT count(*) FROM (SELECT s.snapshot_id FROM configserver.config_snapshot_t s JOIN configserver.config_snapshot_property_t p ON p.snapshot_id=s.snapshot_id WHERE s.current AND s.service_id='com.networknt.agent.account-1.0.0' AND p.property_name IN ($required_agent_policy_properties) AND NULLIF(btrim(p.property_value), '') IS NOT NULL GROUP BY s.snapshot_id HAVING count(DISTINCT p.property_name) = $required_agent_policy_property_count) runnable_agent_snapshots;" \
    2>/dev/null | tr -d '[:space:]' || true)"
  [[ "$runnable_agent_snapshot_count" =~ ^[0-9]+$ ]] ||
    die "cannot query mandatory Account Agent policy snapshot properties"
  [[ "$runnable_agent_snapshot_count" == "1" ]] ||
    die "the current Account Agent snapshot is operational-store-only and not runnable; publish and activate its complete runtimePolicy, portalAssociation, and agentPolicy projection before creating an installer release"
  log "validated one runnable Account Agent snapshot"
}

psql_exec() {
  docker exec -i postgres psql -h localhost -p 5432 -U postgres -d configserver -v ON_ERROR_STOP=1 "$@"
}

reset_configserver_database() {
  log "recreating the dedicated Config Server and Knowledge databases"
  docker exec postgres psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
    -c "DROP DATABASE IF EXISTS knowledge WITH (FORCE);"
  docker exec postgres psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
    -c "DROP DATABASE IF EXISTS configserver WITH (FORCE);"
  docker exec \
    -e POSTGRES_USER=postgres \
    -e PORTAL_DB_TOPOLOGY=separate \
    -e PORTAL_DB_NAME=configserver \
    -e PORTAL_DB_KNOWLEDGE_NAME=knowledge \
    postgres /bin/bash /docker-entrypoint-initdb.d/00-init-environment.sh
}

verify_bootstrap_postconditions() {
  psql_exec <<'SQL'
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM instance_graph_revision_t
     WHERE projected_revision < accepted_revision
  ) THEN
    RAISE EXCEPTION 'instance graph projection has not converged';
  END IF;
  IF EXISTS (
    SELECT 1 FROM outbox_message_t
     WHERE transaction_ordinal <> 0 OR transaction_count <> 1
        OR substring(transaction_id::text, 15, 1) <> '7'
  ) THEN
    RAISE EXCEPTION 'outbox singleton UUIDv7 invariant failed';
  END IF;
  IF (SELECT count(*) FROM outbox_message_t) <>
     (SELECT count(DISTINCT transaction_id) FROM outbox_message_t) THEN
    RAISE EXCEPTION 'outbox transaction ids are not unique';
  END IF;
  IF EXISTS (
    SELECT 1 FROM outbox_message_t
     GROUP BY c_offset HAVING count(*) <> 1
  ) OR COALESCE((SELECT max(c_offset) - min(c_offset) + 1 FROM outbox_message_t), 0) <>
       (SELECT count(*) FROM outbox_message_t) THEN
    RAISE EXCEPTION 'outbox offsets are not gapless';
  END IF;
  IF EXISTS (SELECT 1 FROM user_t WHERE password = 'DISABLED:portal-bootstrap-v1')
     OR EXISTS (SELECT 1 FROM auth_client_t WHERE client_secret = 'DISABLED:portal-bootstrap-v1') THEN
    RAISE EXCEPTION 'bootstrap credential placeholders remain after rotation';
  END IF;
END $$;
SQL
}

try_restore_bootstrap_archive() {
  local mode="${PORTAL_BOOTSTRAP_ARCHIVE:-auto}"
  local manifest="data/manifest.json"
  local archive_object
  local signature_object
  local archive
  local signature
  local public_key="${LIGHT_PORTAL_BOOTSTRAP_PUBLIC_KEY:-bootstrap/release-public.pem}"
  local rotation_hook="${LIGHT_PORTAL_BOOTSTRAP_CREDENTIAL_ROTATION_HOOK:-scripts/rotate-bootstrap-credentials.py}"
  local postgres_major
  local restore_role="${PORTAL_BOOTSTRAP_APPLICATION_ROLE:-postgres}"
  local container_archive="/tmp/light-portal-bootstrap.dump"
  local expected_schema_digest
  local actual_schema_digest
  local restored_checksums
  local grants_verified
  local analyze_verified
  local existing_event_count
  local expected_included_deltas
  local actual_included_deltas

  case "${mode,,}" in
    false|no|0|disabled) return 1 ;;
    auto|true|yes|1) ;;
    *) die "invalid PORTAL_BOOTSTRAP_ARCHIVE value: $mode" ;;
  esac

  existing_event_count="$(event_store_count || true)"
  if [[ "$existing_event_count" != "0" ]]; then
    log "bootstrap archive requires an empty event store; preserving the existing database"
    return 1
  fi

  [[ -f "$manifest" && -f events.json ]] || return 1
  archive_object="$(python3 scripts/bootstrap_manifest.py get \
    --manifest "$manifest" --path bootstrapArchive.object 2>/dev/null || true)"
  signature_object="$(python3 scripts/bootstrap_manifest.py get \
    --manifest "$manifest" --path bootstrapArchive.signatureObject 2>/dev/null || true)"
  [[ -n "$archive_object" && -n "$signature_object" ]] || return 1
  archive="data/$(basename -- "$archive_object")"
  signature="data/$(basename -- "$signature_object")"

  if [[ ! -f "$archive" || ! -f "$signature" || ! -f "$public_key" ]]; then
    log "bootstrap archive verification inputs are incomplete; using event import"
    return 1
  fi
  if [[ -z "$rotation_hook" || ! -x "$rotation_hook" ]]; then
    log "credential rotation hook is unavailable; refusing public bootstrap archive"
    return 1
  fi

  require_command openssl
  require_command python3
  if ! openssl dgst -sha256 -verify "$public_key" -signature "$signature" "$manifest" >/dev/null; then
    log "bootstrap manifest signature verification failed; using event import"
    return 1
  fi
  postgres_major="$(docker exec postgres psql -U postgres -d postgres -tAc \
    "SELECT current_setting('server_version_num')::integer / 10000;" | tr -d '[:space:]')"
  if ! python3 scripts/bootstrap_manifest.py verify --manifest "$manifest" \
      --archive "$archive" --events events.json \
      --profile bootstrap/portal-bootstrap-v1.json \
      --postgres-major "$postgres_major"; then
    log "bootstrap artifact contract verification failed; using event import"
    return 1
  fi
  [[ "$restore_role" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] ||
    die "invalid PORTAL_BOOTSTRAP_APPLICATION_ROLE: $restore_role"

  log "restoring verified PostgreSQL bootstrap archive"
  docker cp "$archive" "postgres:$container_archive"
  if ! docker exec postgres pg_restore -U postgres -d configserver \
      --clean --if-exists --no-owner --no-acl --exit-on-error \
      --jobs "${BOOTSTRAP_RESTORE_JOBS:-4}" "$container_archive"; then
    docker exec postgres rm -f "$container_archive" || true
    reset_configserver_database
    log "bootstrap restore failed; reset completed for event-import fallback"
    return 1
  fi
  docker exec postgres rm -f "$container_archive"

  restored_schema_ready="$(docker exec postgres psql -U postgres -d configserver -tAc \
    "SELECT to_regclass('configserver.event_store_t') IS NOT NULL;" | tr -d '[:space:]')"
  if [[ "$restored_schema_ready" != "t" ]]; then
    reset_configserver_database
    log "bootstrap archive uses the legacy public schema; reset completed for event-import fallback"
    return 1
  fi

  expected_schema_digest="$(python3 scripts/bootstrap_manifest.py get \
    --manifest "$manifest" --path schemaSha256)"
  actual_schema_digest="$(docker exec postgres pg_dump -U postgres -d configserver \
    --schema-only --no-owner --no-acl |
    sed '/^\\restrict /d; /^\\unrestrict /d' | sha256sum | awk '{print $1}')"
  if [[ "$actual_schema_digest" != "$expected_schema_digest" ]]; then
    reset_configserver_database
    log "restored schema digest mismatch; reset completed for event-import fallback"
    return 1
  fi
  expected_included_deltas="$(python3 scripts/bootstrap_manifest.py get \
    --manifest "$manifest" --path includedDeltaIds | tr -d '[:space:]')"
  actual_included_deltas="$(docker exec postgres psql -U postgres -d configserver -tAc \
    "SELECT COALESCE(json_agg(delta_id ORDER BY imported_ts, delta_id)::text, '[]')
       FROM portal_event_delta_t;" | tr -d '[:space:]')"
  if [[ "$actual_included_deltas" != "$expected_included_deltas" ]]; then
    reset_configserver_database
    log "archive delta ledger mismatch; reset completed for event-import fallback"
    return 1
  fi

  restored_checksums="$(mktemp "${TMPDIR:-/tmp}/portal-bootstrap-checksums.XXXXXX")"
  if ! python3 scripts/bootstrap_checksums.py \
      --profile bootstrap/portal-bootstrap-v1.json --docker-container postgres \
      > "$restored_checksums" ||
     ! python3 scripts/bootstrap_manifest.py verify-checksums \
      --manifest "$manifest" --checksums "$restored_checksums"; then
    rm -f "$restored_checksums"
    reset_configserver_database
    log "restored canonical checksums failed; reset completed for event-import fallback"
    return 1
  fi
  rm -f "$restored_checksums"

  psql_exec -c "GRANT CONNECT ON DATABASE configserver TO $restore_role;"
  psql_exec -c "GRANT USAGE ON SCHEMA configserver, public TO $restore_role;"
  psql_exec -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configserver TO $restore_role;"
  psql_exec -c "GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA configserver TO $restore_role;"
  psql_exec -c "ALTER ROLE $restore_role IN DATABASE configserver SET search_path = configserver, public;"
  grants_verified="$(docker exec postgres psql -U postgres -d configserver -tAc \
    "SELECT has_database_privilege('$restore_role', 'configserver', 'CONNECT')
         AND has_schema_privilege('$restore_role', 'configserver', 'USAGE')
         AND has_table_privilege('$restore_role', 'configserver.event_store_t', 'SELECT');" |
    tr -d '[:space:]')"
  [[ "$grants_verified" == "t" ]] || {
    reset_configserver_database
    log "restore grant verification failed; reset completed for event-import fallback"
    return 1
  }
  if ! "$rotation_hook" "$manifest"; then
    reset_configserver_database
    log "credential rotation failed; reset completed for event-import fallback"
    return 1
  fi
  psql_exec -c "ANALYZE;"
  analyze_verified="$(docker exec postgres psql -U postgres -d configserver -tAc \
    "SELECT last_analyze IS NOT NULL FROM pg_stat_all_tables
      WHERE schemaname = 'configserver' AND relname = 'event_store_t';" |
    tr -d '[:space:]')"
  [[ "$analyze_verified" == "t" ]] || {
    reset_configserver_database
    log "planner statistics verification failed; reset completed for event-import fallback"
    return 1
  }
  if ! verify_bootstrap_postconditions; then
    reset_configserver_database
    log "post-restore verification failed; reset completed for event-import fallback"
    return 1
  fi
  log "verified PostgreSQL bootstrap archive is database-ready"
  return 0
}

default_event_import_network() {
  local network

  network="$(docker inspect -f '{{range $name, $_ := .NetworkSettings.Networks}}{{println $name}}{{end}}' postgres 2>/dev/null | head -n 1 || true)"
  if [[ -n "$network" ]]; then
    printf '%s\n' "$network"
  else
    printf '%s_default\n' "$(basename "$PWD")"
  fi
}

import_events() {
  local import_mode="${IMPORT_EVENTS:-auto}"
  local import_mode_lower="${import_mode,,}"
  local event_count=""
  local importer_image
  local import_network
  local extra_args=()

  case "$import_mode_lower" in
    false|no|0|"")
      log "event import skipped"
      return 0
      ;;
    auto|true|yes|1|force)
      ;;
    *)
      die "invalid IMPORT_EVENTS value: $import_mode"
      ;;
  esac

  [[ -f events.json ]] || die "events.json is missing; run ./install.sh assets first"
  normalize_events_json events.json

  event_count="$(event_store_count || true)"
  if [[ "$event_count" =~ ^[0-9]+$ && "$import_mode_lower" == "auto" && "$event_count" -gt 0 ]]; then
    log "event_store_t already has $event_count rows; skipping event import"
    return 0
  fi
  if [[ ! "$event_count" =~ ^[0-9]+$ ]]; then
    die "cannot read event_store_t before event import"
  fi

  load_env_file_var EVENT_IMPORTER_IMAGE
  importer_image="${EVENT_IMPORTER_IMAGE:-networknt/event-importer:latest}"
  import_network="${EVENT_IMPORT_NETWORK:-$(default_event_import_network)}"

  if [[ "$event_count" -eq 0 ]]; then
    extra_args+=(
      --bootstrap-import
      --physical-chunk-events "${EVENT_IMPORT_PHYSICAL_CHUNK_EVENTS:-500}"
      --physical-chunk-bytes "${EVENT_IMPORT_PHYSICAL_CHUNK_BYTES:-16777216}"
      --max-event-bytes "${EVENT_IMPORT_MAX_EVENT_BYTES:-67108864}"
    )
    [[ "${EVENT_IMPORT_SYNCHRONOUS_COMMIT_OFF:-false}" =~ ^(1|true|TRUE|yes|YES)$ ]] &&
      extra_args+=(--bootstrap-synchronous-commit-off)
    [[ "${EVENT_IMPORT_DIAGNOSE_FAILED_CHUNK:-false}" =~ ^(1|true|TRUE|yes|YES)$ ]] &&
      extra_args+=(--diagnose-failed-chunk)
    [[ "${EVENT_IMPORT_PHYSICAL_CHUNKING_DISABLED:-false}" =~ ^(1|true|TRUE|yes|YES)$ ]] &&
      extra_args+=(--physical-chunking-disabled)
    log "empty destination detected; enabling direct event-table bootstrap import"
  fi

  if docker_runtime_is_podman; then
    log "streaming events.json to $importer_image over stdin"
    docker run --rm -i \
      --network "$import_network" \
      -e DB_JDBC_URL="${EVENT_IMPORT_DB_JDBC_URL:-jdbc:postgresql://postgres:5432/configserver}" \
      -e DB_USERNAME="${EVENT_IMPORT_DB_USERNAME:-postgres}" \
      -e DB_PASSWORD="${EVENT_IMPORT_DB_PASSWORD:-secret}" \
      -e DB_MAXIMUM_POOL_SIZE="${EVENT_IMPORT_DB_MAXIMUM_POOL_SIZE:-3}" \
      "$importer_image" \
      --filename /dev/stdin \
      "${extra_args[@]}" < events.json
  else
    log "importing events.json with $importer_image"
    docker run --rm \
      --network "$import_network" \
      -v "$PWD/events.json:/events/events.json:ro,z" \
      -e DB_JDBC_URL="${EVENT_IMPORT_DB_JDBC_URL:-jdbc:postgresql://postgres:5432/configserver}" \
      -e DB_USERNAME="${EVENT_IMPORT_DB_USERNAME:-postgres}" \
      -e DB_PASSWORD="${EVENT_IMPORT_DB_PASSWORD:-secret}" \
      -e DB_MAXIMUM_POOL_SIZE="${EVENT_IMPORT_DB_MAXIMUM_POOL_SIZE:-3}" \
      "$importer_image" \
      --filename /events/events.json \
      "${extra_args[@]}"
  fi
}

apply_db_patches() {
  local patch_dir="${DB_PATCH_DIR:-db/patches}"
  local patches=()
  local patch
  local patch_id
  local checksum
  local existing_checksum
  local source_sql
  local rendered_sql

  wait_for_postgres || die "postgres did not become ready before database patches"

  psql_exec <<'SQL'
CREATE TABLE IF NOT EXISTS portal_schema_patch_t (
  patch_id VARCHAR(128) PRIMARY KEY,
  checksum VARCHAR(128) NOT NULL,
  applied_ts TIMESTAMPTZ NOT NULL DEFAULT now()
);
SQL

  shopt -s nullglob
  patches=("$patch_dir"/*.sql)
  shopt -u nullglob

  if ((${#patches[@]} == 0)); then
    log "no database patches found in $patch_dir"
    return 0
  fi

  IFS=$'\n' patches=($(printf '%s\n' "${patches[@]}" | sort))
  unset IFS

  for patch in "${patches[@]}"; do
    patch_id="$(basename -- "$patch" .sql)"
    checksum="$(sha256sum "$patch" | awk '{print $1}')"
    existing_checksum="$(docker exec postgres psql -h localhost -p 5432 -U postgres -d configserver -tAc "select checksum from portal_schema_patch_t where patch_id = '$patch_id';" | tr -d '[:space:]' || true)"

    if [[ -n "$existing_checksum" ]]; then
      [[ "$existing_checksum" == "$checksum" ]] ||
        die "checksum drift for applied patch $patch_id: database=$existing_checksum file=$checksum"
      log "database patch already applied: $patch_id"
      continue
    fi

    log "applying database patch $patch_id"
    source_sql="$(mktemp "${TMPDIR:-/tmp}/light-portal-db-patch-source.XXXXXX.sql")"
    rendered_sql="$(mktemp "${TMPDIR:-/tmp}/light-portal-db-patch-rendered.XXXXXX.sql")"
    {
      printf 'BEGIN;\n'
      cat "$patch"
      printf '\n'
      printf "INSERT INTO portal_schema_patch_t (patch_id, checksum) VALUES ('%s', '%s');\n" "$patch_id" "$checksum"
      printf 'COMMIT;\n'
    } > "$source_sql"

    PORTAL_DB_CONFIGSERVER_SOURCE="$source_sql" \
      postgres-db/lib/render-schema.sh configserver configserver "$rendered_sql"

    if ! psql_exec < "$rendered_sql"; then
      rm -f "$source_sql" "$rendered_sql"
      die "failed to apply database patch $patch_id"
    fi
    rm -f "$source_sql" "$rendered_sql"
  done
}

verify_event_delta_applied() {
  local delta="$1"
  local verify_delta_sql="$2"
  local expected_json

  expected_json="$(<"$delta")"

  [[ -f "$verify_delta_sql" ]] || die "event delta verification SQL is missing: $verify_delta_sql"
  psql_exec -v "expected_json=$expected_json" < "$verify_delta_sql"
}

is_superseded_event_delta() {
  local delta_id="$1"
  local superseded_delta_file="$2"

  [[ -f "$superseded_delta_file" ]] || return 1
  awk '
    /^[[:space:]]*(#|$)/ { next }
    { sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, "") }
    $0 == target { found = 1 }
    END { exit(found ? 0 : 1) }
  ' target="$delta_id" "$superseded_delta_file"
}

import_event_deltas() {
  local delta_dir="${EVENT_DELTA_DIR:-events/deltas}"
  local superseded_delta_file="${EVENT_SUPERSEDED_DELTA_FILE:-$delta_dir/superseded-deltas.list}"
  local verify_delta_sql="${EVENT_DELTA_VERIFY_SQL:-$delta_dir/verify-event-delta.sql}"
  local deltas=()
  local delta
  local delta_id
  local checksum
  local existing_checksum
  local importer_image
  local import_network

  wait_for_postgres || die "postgres did not become ready before event deltas"

  psql_exec <<'SQL'
CREATE TABLE IF NOT EXISTS portal_event_delta_t (
  delta_id VARCHAR(128) PRIMARY KEY,
  checksum VARCHAR(128) NOT NULL,
  imported_ts TIMESTAMPTZ NOT NULL DEFAULT now()
);
SQL

  if [[ -f data/manifest.json ]]; then
    local verified_delta_list
    verified_delta_list="$(mktemp "${TMPDIR:-/tmp}/portal-deltas.XXXXXX")"
    if ! python3 scripts/bootstrap_manifest.py verify-deltas \
        --manifest data/manifest.json --delta-dir "$delta_dir" > "$verified_delta_list"; then
      rm -f "$verified_delta_list"
      die "event delta release manifest verification failed"
    fi
    mapfile -t deltas < <(cut -f2 "$verified_delta_list")
    rm -f "$verified_delta_list"
  else
    shopt -s nullglob
    deltas=("$delta_dir"/*.json)
    shopt -u nullglob
  fi

  if ((${#deltas[@]} == 0)); then
    log "no event deltas found in $delta_dir"
    return 0
  fi

  IFS=$'\n' deltas=($(printf '%s\n' "${deltas[@]}" | sort))
  unset IFS

  load_env_file_var EVENT_IMPORTER_IMAGE
  importer_image="${EVENT_IMPORTER_IMAGE:-networknt/event-importer:latest}"
  import_network="${EVENT_IMPORT_NETWORK:-$(default_event_import_network)}"

  for delta in "${deltas[@]}"; do
    delta_id="$(basename -- "$delta" .json)"
    checksum="$(sha256sum "$delta" | awk '{print $1}')"
    existing_checksum="$(docker exec postgres psql -h localhost -p 5432 -U postgres -d configserver -tAc "select checksum from portal_event_delta_t where delta_id = '$delta_id';" | tr -d '[:space:]' || true)"

    if [[ -n "$existing_checksum" ]]; then
      [[ "$existing_checksum" == "$checksum" ]] ||
        die "checksum drift for imported delta $delta_id: database=$existing_checksum file=$checksum"
      log "event delta already imported: $delta_id"
      continue
    fi

    if is_superseded_event_delta "$delta_id" "$superseded_delta_file"; then
      log "skipping superseded event delta $delta_id"
      psql_exec -c "INSERT INTO portal_event_delta_t (delta_id, checksum) VALUES ('$delta_id', '$checksum');"
      continue
    fi

    log "importing event delta $delta_id with $importer_image"
    if ! docker run --rm -i \
      --network "$import_network" \
      -e DB_JDBC_URL="${EVENT_IMPORT_DB_JDBC_URL:-jdbc:postgresql://postgres:5432/configserver}" \
      -e DB_USERNAME="${EVENT_IMPORT_DB_USERNAME:-postgres}" \
      -e DB_PASSWORD="${EVENT_IMPORT_DB_PASSWORD:-secret}" \
      -e DB_MAXIMUM_POOL_SIZE="${EVENT_IMPORT_DB_MAXIMUM_POOL_SIZE:-3}" \
      "$importer_image" \
      --filename /dev/stdin \
      --fail-on-error < "$delta"; then
      die "failed to import event delta $delta_id"
    fi

    if ! verify_event_delta_applied "$delta" "$verify_delta_sql"; then
      die "event importer exited successfully but $delta_id was not fully applied"
    fi
    log "verified event effects for event delta $delta_id"

    psql_exec -c "INSERT INTO portal_event_delta_t (delta_id, checksum) VALUES ('$delta_id', '$checksum');"
  done
}

apply_release_deltas() {
  case "${APPLY_RELEASE_DELTAS:-true}" in
    false|FALSE|0|no|NO|n|N)
      log "release delta application skipped"
      return 0
      ;;
  esac

  [[ -f data/manifest.json ]] || die "release manifest is missing; run ./install.sh update or assets first"
  apply_db_patches
  compose up -d --no-deps hybrid-command hybrid-query
  import_event_deltas
}

bootstrap_events() {
  require_command docker
  [[ -f .env ]] || cp .env.example .env
  validate_compose_config
  compose up -d postgres
  wait_for_postgres || die "postgres did not become ready for TCP connections"
  ensure_portal_runtime_database_access
  if try_restore_bootstrap_archive; then
    start_event_processors
    apply_release_deltas
  else
    start_event_processors
    import_events
  fi
  log "waiting for asynchronous baseline projection cursor before OAuth startup"
  wait_for_baseline_projection_cursor
  validate_runnable_agent_snapshot
  start_light_oauth
}

case "$command_name" in
  install)
    download_assets
    download_release_artifacts
    clean_volumes_if_requested
    bootstrap_events
    start_stack
    if [[ "${LIGHT_GATEWAY_HOST_PORT:-443}" == "443" ]]; then
      log "portal should be available at https://local.localhost"
    else
      log "portal should be available at https://local.localhost:${LIGHT_GATEWAY_HOST_PORT}"
    fi
    log "LLM gateway should be available at https://localhost:${LLM_GATEWAY_HOST_PORT:-8444}"
    ;;
  update)
    download_assets
    download_release_artifacts
    clean_volumes_if_requested
    bootstrap_events
    apply_release_deltas
    start_stack
    ;;
  assets)
    download_assets
    download_release_artifacts
    ;;
  start)
    clean_volumes_if_requested
    bootstrap_events
    start_stack
    ;;
  stop)
    require_command docker
    compose down
    ;;
  status)
    require_command docker
    compose ps
    ;;
  logs)
    require_command docker
    compose logs -f
    ;;
  uninstall)
    require_command docker
    compose down
    printf 'Delete Docker volumes for this stack? [y/N] '
    read -r answer
    case "$answer" in
      y|Y|yes|YES)
        compose down -v
        ;;
    esac
    ;;
  *)
    usage
    die "unknown command: $command_name"
    ;;
esac
