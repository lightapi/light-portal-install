#!/bin/sh
set -eu

sync_once() {
  test -n "${SNAPSHOT_AUTHORIZATION:-}"
  case "$SNAPSHOT_AUTHORIZATION" in
    Bearer\ *) authorization="$SNAPSHOT_AUTHORIZATION" ;;
    *) authorization="Bearer $SNAPSHOT_AUTHORIZATION" ;;
  esac
  snapshot_file="$(mktemp)"
  trap 'rm -f "$snapshot_file"' EXIT HUP INT TERM
  curl --fail --silent --show-error --insecure --get \
    --connect-timeout 2 --max-time 10 --retry 30 --retry-all-errors --retry-delay 2 \
    -H "Authorization: $authorization" \
    --data-urlencode "cmd={\"host\":\"lightapi.net\",\"service\":\"genai\",\"action\":\"getKnowledgeAudienceSnapshot\",\"version\":\"0.1.0\",\"data\":{\"environment\":\"$SNAPSHOT_ENVIRONMENT\"}}" \
    "$SNAPSHOT_QUERY_URL" >"$snapshot_file"
  curl --fail --silent --show-error \
    --connect-timeout 2 --max-time 10 --retry 3 --retry-all-errors --retry-delay 1 \
    -H "Authorization: $authorization" \
    -H "X-Knowledge-Environment: $SNAPSHOT_ENVIRONMENT" \
    -H "Content-Type: application/json" \
    --data-binary "@$snapshot_file" \
    "$SNAPSHOT_APPLY_URL"
  rm -f "$snapshot_file"
  trap - EXIT HUP INT TERM
}

case "${1:-once}" in
  once)
    sync_once
    ;;
  loop)
    while true; do
      sync_once
      sleep "${SNAPSHOT_REFRESH_SECONDS:-60}"
    done
    ;;
  *)
    echo "usage: $0 [once|loop]" >&2
    exit 2
    ;;
esac
