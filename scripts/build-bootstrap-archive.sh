#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
database_url="${PORTAL_BOOTSTRAP_DATABASE_URL:?PORTAL_BOOTSTRAP_DATABASE_URL is required}"
postgres_container="${PORTAL_BOOTSTRAP_POSTGRES_CONTAINER:-}"
events_file="${PORTAL_BOOTSTRAP_EVENTS_FILE:-$repo_dir/events.json}"
manifest_file="${PORTAL_BOOTSTRAP_MANIFEST:-$repo_dir/data/manifest.json}"
archive_file="${PORTAL_BOOTSTRAP_ARCHIVE_OUT:-$repo_dir/data/portal-bootstrap.dump}"
signature_file="${PORTAL_BOOTSTRAP_SIGNATURE_OUT:-$archive_file.manifest.sig}"
profile_file="${PORTAL_BOOTSTRAP_PROFILE:-$repo_dir/bootstrap/portal-bootstrap-v1.json}"
private_key="${LIGHT_PORTAL_BOOTSTRAP_SIGNING_PRIVATE_KEY:?LIGHT_PORTAL_BOOTSTRAP_SIGNING_PRIVATE_KEY is required}"
signing_identity="${LIGHT_PORTAL_BOOTSTRAP_SIGNING_IDENTITY:?LIGHT_PORTAL_BOOTSTRAP_SIGNING_IDENTITY is required}"
portal_db_dir="${PORTAL_DB_DIR:-$repo_dir/../portal-db}"
baseline_id="${PORTAL_BOOTSTRAP_BASELINE_ID:?PORTAL_BOOTSTRAP_BASELINE_ID is required}"

[[ "${PORTAL_BOOTSTRAP_DISPOSABLE_DATABASE:-false}" =~ ^(1|true|TRUE|yes|YES)$ ]] || {
  printf 'PORTAL_BOOTSTRAP_DISPOSABLE_DATABASE=true is required because archive normalization mutates the source database\n' >&2
  exit 1
}

for command in python3 openssl sha256sum git; do
  command -v "$command" >/dev/null 2>&1 || {
    printf 'missing required command: %s\n' "$command" >&2
    exit 1
  }
done
if [[ -n "$postgres_container" ]]; then
  command -v docker >/dev/null 2>&1 || {
    printf 'missing required command: docker\n' >&2
    exit 1
  }
else
  for command in pg_dump psql; do
    command -v "$command" >/dev/null 2>&1 || {
      printf 'missing required command: %s\n' "$command" >&2
      exit 1
    }
  done
fi
[[ -f "$events_file" && -f "$manifest_file" && -f "$profile_file" && -f "$private_key" ]]
mkdir -p "$(dirname -- "$archive_file")" "$(dirname -- "$signature_file")"

work_dir="$(mktemp -d "${TMPDIR:-/tmp}/portal-bootstrap-build.XXXXXX")"
trap 'rm -rf "$work_dir"' EXIT
checksums_file="$work_dir/checksums.json"
schema_file="$work_dir/schema.sql"

run_psql() {
  if [[ -n "$postgres_container" ]]; then
    docker exec -i "$postgres_container" psql -U postgres -d configserver "$@"
  else
    psql "$database_url" "$@"
  fi
}

run_psql -X -v ON_ERROR_STOP=1 <<'SQL'
CREATE TABLE IF NOT EXISTS portal_event_delta_t (
  delta_id VARCHAR(128) PRIMARY KEY,
  checksum VARCHAR(128) NOT NULL,
  imported_ts TIMESTAMPTZ NOT NULL DEFAULT now()
);

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM instance_graph_revision_t WHERE projected_revision < accepted_revision) THEN
    RAISE EXCEPTION 'graph projection has not converged';
  END IF;
  IF EXISTS (SELECT 1 FROM outbox_message_t
              WHERE transaction_ordinal <> 0 OR transaction_count <> 1
                 OR substring(transaction_id::text, 15, 1) <> '7') THEN
    RAISE EXCEPTION 'singleton UUIDv7 transaction invariant failed';
  END IF;
  IF (SELECT count(*) FROM outbox_message_t) <>
     (SELECT count(DISTINCT transaction_id) FROM outbox_message_t) THEN
    RAISE EXCEPTION 'transaction ids are not unique';
  END IF;
  IF EXISTS (SELECT 1 FROM dead_letter_queue)
     OR EXISTS (SELECT 1 FROM notification_t WHERE status IN ('FAILED', 'DLQ'))
     OR EXISTS (SELECT 1 FROM event_failure_transaction_t)
     OR EXISTS (SELECT 1 FROM event_failure_delivery_t)
     OR EXISTS (SELECT 1 FROM event_failure_event_t)
     OR EXISTS (SELECT 1 FROM event_replay_request_t
                 WHERE status NOT IN ('SUCCEEDED', 'CANCELLED', 'EXPIRED')) THEN
    RAISE EXCEPTION 'failed, DLQ, or active replay state remains';
  END IF;
END $$;

UPDATE user_t SET password = 'DISABLED:portal-bootstrap-v1' WHERE password IS NOT NULL;
UPDATE auth_client_t SET client_secret = 'DISABLED:portal-bootstrap-v1';
DELETE FROM notification_t;
DELETE FROM dead_letter_queue;
SQL

event_count="$(run_psql -X -qAt -c 'SELECT count(*) FROM event_store_t')"
outbox_count="$(run_psql -X -qAt -c 'SELECT count(*) FROM outbox_message_t')"
[[ "$event_count" == "$outbox_count" && "$event_count" -gt 0 ]] || {
  printf 'event/outbox count mismatch: %s/%s\n' "$event_count" "$outbox_count" >&2
  exit 1
}
last_event_id="$(run_psql -X -qAt -c 'SELECT id FROM outbox_message_t ORDER BY c_offset DESC LIMIT 1')"
last_offset="$(run_psql -X -qAt -c 'SELECT c_offset FROM outbox_message_t ORDER BY c_offset DESC LIMIT 1')"
postgres_major="$(run_psql -X -qAt -c "SELECT current_setting('server_version_num')::integer / 10000")"
included_delta_ids="$(run_psql -X -qAt -c \
  "SELECT COALESCE(json_agg(delta_id ORDER BY imported_ts, delta_id)::text, '[]') FROM portal_event_delta_t" \
  2>/dev/null || printf '[]')"

if [[ -n "$postgres_container" ]]; then
  python3 "$repo_dir/scripts/bootstrap_checksums.py" --profile "$profile_file" \
    --docker-container "$postgres_container" > "$checksums_file"
  docker exec "$postgres_container" pg_dump -U postgres -d configserver \
    --schema-only --no-owner --no-acl |
    sed '/^\\restrict /d; /^\\unrestrict /d' > "$schema_file"
else
  python3 "$repo_dir/scripts/bootstrap_checksums.py" --profile "$profile_file" \
    --database-url "$database_url" > "$checksums_file"
  pg_dump "$database_url" --schema-only --no-owner --no-acl |
    sed '/^\\restrict /d; /^\\unrestrict /d' > "$schema_file"
fi
schema_digest="$(sha256sum "$schema_file" | awk '{print $1}')"
if [[ -n "$postgres_container" ]]; then
  container_archive="/tmp/light-portal-release-bootstrap.dump"
  docker exec "$postgres_container" pg_dump -U postgres -d configserver \
    --format=custom --no-owner --no-acl --file "$container_archive"
  docker cp "$postgres_container:$container_archive" "$archive_file"
  docker exec "$postgres_container" rm -f "$container_archive"
else
  pg_dump "$database_url" --format=custom --no-owner --no-acl --file "$archive_file"
fi

portal_db_commit="$(git -C "$portal_db_dir" rev-parse HEAD)"
python3 "$repo_dir/scripts/build_bootstrap_manifest.py" \
  --manifest "$manifest_file" --archive "$archive_file" --events "$events_file" \
  --profile "$profile_file" --checksums "$checksums_file" \
  --schema-digest "$schema_digest" --portal-db-commit "$portal_db_commit" \
  --postgres-major "$postgres_major" --baseline-id "$baseline_id" \
  --event-count "$event_count" --last-event-id "$last_event_id" \
  --last-outbox-offset "$last_offset" --included-delta-ids "$included_delta_ids" \
  --signing-identity "$signing_identity" --archive-object "$(basename -- "$archive_file")" \
  --signature-object "$(basename -- "$signature_file")"
openssl dgst -sha256 -sign "$private_key" -out "$signature_file" "$manifest_file"

printf 'built %s and signed manifest %s\n' "$archive_file" "$manifest_file"
