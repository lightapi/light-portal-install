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
  LIGHT_PORTAL_REPO_ARCHIVE  Default:
                             https://github.com/lightapi/light-portal-install/archive/refs/heads/master.tar.gz
  IMPORT_EVENTS              Default: auto. Use false to skip event import.
  EVENT_IMPORTER_IMAGE       Default: networknt/event-importer:latest
  LIGHT_PORTAL_CLIENT_REDIRECT_URI
                             Default: https://local.localhost/authorization
  CLEAN_VOLUMES=true         Stop the stack and delete Docker volumes before
                             install, update, or start.
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
compose() {
  if [[ -f docker-images.env ]]; then
    docker compose --env-file docker-images.env --env-file .env "$@"
  else
    docker compose --env-file .env "$@"
  fi
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

  download_file "$asset_base_url/$archive_name" "$archive_file"
  log "extracting $member_name from $archive_file to $dest"
  unzip -p "$archive_file" "$member_name" > "$dest.tmp"
  mv "$dest.tmp" "$dest"
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
  download_archive signin.zip light-gateway-rust/signin
  download_archive_file events.zip events.json events.json
  normalize_events_json events.json
}

start_stack() {
  require_command docker
  [[ -f .env ]] || cp .env.example .env
  compose up -d
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
  local status

  while [[ "$attempt" -le "$max_attempts" ]]; do
    status="$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' postgres 2>/dev/null || true)"
    if [[ "$status" == "healthy" ]]; then
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

start_event_processors() {
  log "starting event bootstrap services"
  compose up -d postgres
  wait_for_postgres || die "postgres did not become healthy"

  compose up -d --no-deps hybrid-command hybrid-query
  wait_for_running_container hybrid-command || die "hybrid-command did not start"
  wait_for_running_container hybrid-query || die "hybrid-query did not start"
}

event_store_count() {
  docker exec postgres psql -U postgres -d configserver -tAc "select count(*) from event_store_t;" 2>/dev/null | tr -d '[:space:]'
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

  if docker_runtime_is_podman; then
    log "streaming events.json to $importer_image over stdin"
    docker run --rm -i \
      --network "$import_network" \
      -e DB_JDBC_URL="${EVENT_IMPORT_DB_JDBC_URL:-jdbc:postgresql://postgres:5432/configserver}" \
      -e DB_USERNAME="${EVENT_IMPORT_DB_USERNAME:-postgres}" \
      -e DB_PASSWORD="${EVENT_IMPORT_DB_PASSWORD:-secret}" \
      -e DB_MAXIMUM_POOL_SIZE="${EVENT_IMPORT_DB_MAXIMUM_POOL_SIZE:-3}" \
      "$importer_image" \
      --filename /dev/stdin < events.json
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
      --filename /events/events.json
  fi
}

bootstrap_events() {
  require_command docker
  [[ -f .env ]] || cp .env.example .env
  start_event_processors
  import_events
}

case "$command_name" in
  install)
    download_assets
    clean_volumes_if_requested
    bootstrap_events
    start_stack
    log "portal should be available at https://localhost:${LIGHT_GATEWAY_HOST_PORT:-443}"
    ;;
  update)
    download_assets
    clean_volumes_if_requested
    bootstrap_events
    start_stack
    ;;
  assets)
    download_assets
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
