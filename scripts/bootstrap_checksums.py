#!/usr/bin/env python3
"""Compute explicit, profile-pinned canonical PostgreSQL table checksums."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys


IDENTIFIER = re.compile(r"^[a-z_][a-z0-9_]*$")


def identifier(value: str) -> str:
    if not IDENTIFIER.fullmatch(value):
        raise ValueError(f"invalid SQL identifier in checksum profile: {value}")
    return value


def table_query(table: dict) -> str:
    name = identifier(table["name"])
    columns = table.get("columns")
    sort_key = table.get("sortKey")
    normalized = set(table.get("normalizedColumns", []))
    if not isinstance(columns, list) or not columns:
        raise ValueError(f"{name} must declare an exact non-empty columns list")
    if not isinstance(sort_key, list) or not sort_key:
        raise ValueError(f"{name} must declare an exact non-empty sortKey")
    expressions = []
    for column in columns:
        column = identifier(column)
        if column in normalized:
            expressions.append(f"CASE WHEN {column} IS NULL THEN NULL ELSE '@db-ts@' END")
        else:
            expressions.append(column)
    order = ", ".join(identifier(column) for column in sort_key)
    return ("COPY (SELECT jsonb_build_array(" + ", ".join(expressions) + ")::text "
            f"FROM {name} ORDER BY {order}) TO STDOUT")


def run(args: argparse.Namespace) -> int:
    profile = json.loads(Path(args.profile).read_text(encoding="utf-8"))
    tables = profile.get("tables")
    if not isinstance(tables, list) or not tables:
        raise ValueError("checksum profile must contain tables")
    results = {}
    for table in tables:
        query = table_query(table)
        if args.docker_container:
            command = [args.docker, "exec", args.docker_container, "psql",
                       "-U", args.database_user, "-d", args.database_name,
                       "-X", "-v", "ON_ERROR_STOP=1", "-qAt", "-c", query]
        else:
            command = [args.psql, args.database_url, "-X", "-v", "ON_ERROR_STOP=1",
                       "-qAt", "-c", query]
        completed = subprocess.run(command, check=True, capture_output=True)
        rows = completed.stdout.splitlines()
        results[table["name"]] = {
            "rows": len(rows),
            "sha256": hashlib.sha256(completed.stdout).hexdigest(),
        }
    print(json.dumps({"profile": profile["profile"], "tables": results},
                     sort_keys=True, separators=(",", ":")))
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", required=True)
    connection = parser.add_mutually_exclusive_group(required=True)
    connection.add_argument("--database-url")
    connection.add_argument("--docker-container")
    parser.add_argument("--psql", default="psql")
    parser.add_argument("--docker", default="docker")
    parser.add_argument("--database-user", default="postgres")
    parser.add_argument("--database-name", default="configserver")
    args = parser.parse_args()
    try:
        return run(args)
    except (KeyError, OSError, ValueError, json.JSONDecodeError,
            subprocess.CalledProcessError) as error:
        print(f"bootstrap checksum error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
