#!/usr/bin/env python3
"""Merge a qualified database bootstrap archive into a release manifest."""

from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--archive", required=True)
    parser.add_argument("--events", required=True)
    parser.add_argument("--profile", required=True)
    parser.add_argument("--checksums", required=True)
    parser.add_argument("--schema-digest", required=True)
    parser.add_argument("--portal-db-commit", required=True)
    parser.add_argument("--postgres-major", required=True, type=int)
    parser.add_argument("--baseline-id", required=True)
    parser.add_argument("--event-count", required=True, type=int)
    parser.add_argument("--last-event-id", required=True)
    parser.add_argument("--last-outbox-offset", required=True, type=int)
    parser.add_argument("--included-delta-ids", default="[]")
    parser.add_argument("--signing-identity", required=True)
    parser.add_argument("--archive-object", required=True)
    parser.add_argument("--signature-object", required=True)
    args = parser.parse_args()

    manifest_path = Path(args.manifest)
    archive_path = Path(args.archive)
    events_path = Path(args.events)
    profile_path = Path(args.profile)
    checksums = json.loads(Path(args.checksums).read_text(encoding="utf-8"))
    included = json.loads(args.included_delta_ids)
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    manifest.update({
        "format": "lightapi.portal-postgres-bootstrap",
        "formatVersion": 1,
        "postgresMajor": args.postgres_major,
        "portalDbCommit": args.portal_db_commit,
        "eventsJsonSha256": digest(events_path),
        "eventCount": args.event_count,
        "singletonTransactionCount": args.event_count,
        "lastEventId": args.last_event_id,
        "lastOutboxOffset": args.last_outbox_offset,
        "archiveBaselineId": args.baseline_id,
        "includedDeltaIds": included,
        "checksumProfile": "portal-bootstrap-v1",
        "canonicalizationSpecSha256": digest(profile_path),
        "projectionChecksumSet": checksums,
        "schemaSha256": args.schema_digest,
        "credentialSanitizationPolicy": "disabled-placeholders-v1",
        "restoreRoleMapping": {"owner": "none", "acl": "none", "applicationRole": "postgres"},
        "releaseSigningIdentity": args.signing_identity,
        "createdAt": datetime.now(timezone.utc).isoformat(),
        "bootstrapArchive": {
            "object": args.archive_object,
            "signatureObject": args.signature_object,
            "signatureAlgorithm": "openssl-dgst-sha256",
            "sha256": digest(archive_path),
            "bytes": archive_path.stat().st_size,
        },
    })
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n",
                             encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
