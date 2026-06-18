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
                             Default: https://assets.lightapi.net
  LIGHT_PORTAL_RELEASE_BASE_URL
                             Default: $LIGHT_PORTAL_ASSET_BASE_URL/light-portal/releases
  LIGHT_PORTAL_MANIFEST      Default: ./asset-manifest.txt
  LIGHT_PORTAL_INSTALL_DIR   Optional target directory. If set, the script
                             copies repo files there before running.
  LIGHT_PORTAL_REPO_ARCHIVE  Default:
                             https://github.com/networknt/light-portal-install/archive/refs/heads/main.tar.gz
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

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
command_name="${1:-install}"

if [[ "$command_name" == "-h" || "$command_name" == "--help" ]]; then
  usage
  exit 0
fi

repo_archive="${LIGHT_PORTAL_REPO_ARCHIVE:-https://github.com/networknt/light-portal-install/archive/refs/heads/main.tar.gz}"

if [[ -f "$script_dir/docker-compose.yml" ]]; then
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

asset_base_url="${LIGHT_PORTAL_ASSET_BASE_URL:-https://assets.lightapi.net}"
asset_base_url="${asset_base_url%/}"
release_base_url="${LIGHT_PORTAL_RELEASE_BASE_URL:-$asset_base_url/light-portal/releases}"
release_base_url="${release_base_url%/}"
manifest_file="${LIGHT_PORTAL_MANIFEST:-asset-manifest.txt}"

compose() {
  if [[ -f docker-images.env ]]; then
    docker compose --env-file docker-images.env --env-file .env "$@"
  else
    docker compose --env-file .env "$@"
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

local_path_for_asset() {
  local asset_path="$1"

  case "$asset_path" in
    hybrid-command/*)
      printf 'hybrid-command/service/%s\n' "${asset_path#hybrid-command/}"
      ;;
    hybrid-query/*)
      printf 'hybrid-query/service/%s\n' "${asset_path#hybrid-query/}"
      ;;
    lightapi/dist/*)
      printf 'light-gateway-rust/lightapi/dist/%s\n' "${asset_path#lightapi/dist/}"
      ;;
    signin/dist/*)
      printf 'light-gateway-rust/signin/dist/%s\n' "${asset_path#signin/dist/}"
      ;;
    *)
      printf '%s\n' "$asset_path"
      ;;
  esac
}

download_assets() {
  local asset_path
  local target_path
  local docker_env_url

  require_command curl

  [[ -f "$manifest_file" ]] || die "asset manifest not found: $manifest_file"

  mkdir -p hybrid-command/service hybrid-query/service \
    light-gateway-rust/lightapi/dist light-gateway-rust/signin/dist data

  docker_env_url="$release_base_url/$version/docker-images.env"
  download_file "$docker_env_url" docker-images.env

  if [[ ! -f .env ]]; then
    cp .env.example .env
  fi

  while IFS= read -r asset_path || [[ -n "$asset_path" ]]; do
    [[ -n "$asset_path" && "$asset_path" != \#* ]] || continue
    target_path="$(local_path_for_asset "$asset_path")"
    download_file "$asset_base_url/$asset_path" "$target_path"
  done < "$manifest_file"

  if curl -fsSL "$asset_base_url/events.json" -o events.json.tmp; then
    mv events.json.tmp events.json
  else
    rm -f events.json.tmp
    log "events.json was not downloaded; continuing without import data"
  fi
}

start_stack() {
  require_command docker
  [[ -f .env ]] || cp .env.example .env
  compose up -d
}

case "$command_name" in
  install)
    download_assets
    start_stack
    log "portal should be available at https://localhost:${LIGHT_GATEWAY_HOST_PORT:-443}"
    ;;
  update)
    download_assets
    start_stack
    ;;
  assets)
    download_assets
    ;;
  start)
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
