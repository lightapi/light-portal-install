#!/usr/bin/env python3
"""Validate and query the signed portal PostgreSQL bootstrap manifest."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys


FORMAT = "lightapi.portal-postgres-bootstrap"
FORMAT_VERSION = 1


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def load(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as source:
        value = json.load(source)
    if not isinstance(value, dict):
        raise ValueError("manifest root must be an object")
    return value


def archive_contract(manifest: dict) -> dict:
    archive = manifest.get("bootstrapArchive")
    if not isinstance(archive, dict):
        raise ValueError("manifest bootstrapArchive must be an object")
    return archive


def require_text(value: object, name: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise ValueError(f"manifest {name} must be a non-empty string")
    return value


def validate(args: argparse.Namespace) -> None:
    manifest_path = Path(args.manifest)
    archive_path = Path(args.archive)
    events_path = Path(args.events)
    profile_path = Path(args.profile)
    manifest = load(manifest_path)
    archive = archive_contract(manifest)

    if manifest.get("format") != FORMAT or manifest.get("formatVersion") != FORMAT_VERSION:
        raise ValueError("unsupported portal bootstrap manifest format")
    require_text(manifest.get("archiveBaselineId"), "archiveBaselineId")
    require_text(manifest.get("portalDbCommit"), "portalDbCommit")
    require_text(manifest.get("schemaSha256"), "schemaSha256")
    require_text(manifest.get("releaseSigningIdentity"), "releaseSigningIdentity")
    if manifest.get("checksumProfile") != "portal-bootstrap-v1":
        raise ValueError("unsupported bootstrap checksum profile")
    if int(manifest.get("postgresMajor", -1)) != int(args.postgres_major):
        raise ValueError("PostgreSQL major version does not match archive manifest")
    if archive.get("bytes") != archive_path.stat().st_size:
        raise ValueError("bootstrap archive byte size does not match manifest")
    if require_text(archive.get("sha256"), "bootstrapArchive.sha256") != sha256(archive_path):
        raise ValueError("bootstrap archive SHA-256 does not match manifest")
    if archive.get("signatureAlgorithm") != "openssl-dgst-sha256":
        raise ValueError("unsupported bootstrap manifest signature algorithm")
    if Path(require_text(archive.get("object"), "bootstrapArchive.object")).name != archive_path.name:
        raise ValueError("bootstrap archive object name does not match manifest")
    require_text(archive.get("signatureObject"), "bootstrapArchive.signatureObject")
    if require_text(manifest.get("eventsJsonSha256"), "eventsJsonSha256") != sha256(events_path):
        raise ValueError("events.json SHA-256 does not match bootstrap baseline")
    if require_text(manifest.get("canonicalizationSpecSha256"),
                    "canonicalizationSpecSha256") != sha256(profile_path):
        raise ValueError("canonicalization profile digest does not match manifest")
    if manifest.get("credentialSanitizationPolicy") != "disabled-placeholders-v1":
        raise ValueError("archive does not use the required disabled credential policy")
    included = manifest.get("includedDeltaIds")
    if not isinstance(included, list) or not all(isinstance(item, str) for item in included):
        raise ValueError("includedDeltaIds must be an ordered string array")
    delta_entries = manifest.get("eventDeltas")
    if not isinstance(delta_entries, list):
        raise ValueError("eventDeltas must be an ordered array")
    delta_ids = [entry.get("id") for entry in delta_entries if isinstance(entry, dict)]
    if len(delta_ids) != len(delta_entries) or len(delta_ids) != len(set(delta_ids)):
        raise ValueError("eventDeltas contains invalid or duplicate ids")
    positions = [delta_ids.index(delta_id) for delta_id in included
                 if delta_id in delta_ids]
    if len(positions) != len(included) or positions != sorted(positions):
        raise ValueError("includedDeltaIds is not an ordered subset of eventDeltas")
    transaction_count = manifest.get("singletonTransactionCount")
    event_count = manifest.get("eventCount")
    if not isinstance(event_count, int) or event_count < 1 or transaction_count != event_count:
        raise ValueError("event and singleton transaction counts are inconsistent")
    checksums = manifest.get("projectionChecksumSet")
    if not isinstance(checksums, dict) or checksums.get("profile") != "portal-bootstrap-v1":
        raise ValueError("projectionChecksumSet is missing or uses the wrong profile")


def get_value(args: argparse.Namespace) -> None:
    value: object = load(Path(args.manifest))
    for component in args.path.split("."):
        if not isinstance(value, dict) or component not in value:
            raise ValueError(f"manifest path not found: {args.path}")
        value = value[component]
    if isinstance(value, (dict, list)):
        print(json.dumps(value, separators=(",", ":")))
    elif value is True:
        print("true")
    elif value is False:
        print("false")
    elif value is not None:
        print(value)


def verify_deltas(args: argparse.Namespace) -> None:
    manifest = load(Path(args.manifest))
    entries = manifest.get("eventDeltas")
    if not isinstance(entries, list):
        raise ValueError("manifest eventDeltas must be an ordered array")
    delta_dir = Path(args.delta_dir)
    seen: set[str] = set()
    authorized_files: set[str] = set()
    for entry in entries:
        if not isinstance(entry, dict):
            raise ValueError("eventDeltas entries must be objects")
        delta_id = require_text(entry.get("id"), "eventDeltas[].id")
        relative = require_text(entry.get("path", entry.get("file")),
                                "eventDeltas[].file")
        checksum = require_text(entry.get("sha256"), "eventDeltas[].sha256")
        if delta_id in seen:
            raise ValueError(f"duplicate event delta id: {delta_id}")
        seen.add(delta_id)
        path = delta_dir / Path(relative).name
        authorized_files.add(path.name)
        if not path.is_file() or sha256(path) != checksum:
            raise ValueError(f"event delta missing or checksum mismatched: {delta_id}")
        print(f"{delta_id}\t{path}\t{checksum}")
    unexpected = sorted(path.name for path in delta_dir.glob("*.json")
                        if path.name not in authorized_files)
    if unexpected:
        raise ValueError("unknown event delta files: " + ", ".join(unexpected))


def verify_checksums(args: argparse.Namespace) -> None:
    manifest = load(Path(args.manifest))
    actual = load(Path(args.checksums))
    if manifest.get("projectionChecksumSet") != actual:
        raise ValueError("post-restore canonical table checksums do not match manifest")


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser()
    commands = root.add_subparsers(dest="command", required=True)
    verify = commands.add_parser("verify")
    verify.add_argument("--manifest", required=True)
    verify.add_argument("--archive", required=True)
    verify.add_argument("--events", required=True)
    verify.add_argument("--profile", required=True)
    verify.add_argument("--postgres-major", required=True, type=int)
    verify.set_defaults(action=validate)
    query = commands.add_parser("get")
    query.add_argument("--manifest", required=True)
    query.add_argument("--path", required=True)
    query.set_defaults(action=get_value)
    deltas = commands.add_parser("verify-deltas")
    deltas.add_argument("--manifest", required=True)
    deltas.add_argument("--delta-dir", required=True)
    deltas.set_defaults(action=verify_deltas)
    checksums = commands.add_parser("verify-checksums")
    checksums.add_argument("--manifest", required=True)
    checksums.add_argument("--checksums", required=True)
    checksums.set_defaults(action=verify_checksums)
    return root


def main() -> int:
    args = parser().parse_args()
    try:
        args.action(args)
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"bootstrap manifest error: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
