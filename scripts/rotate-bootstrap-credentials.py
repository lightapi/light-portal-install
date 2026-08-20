#!/usr/bin/env python3
"""Replace archive placeholders and deliver installation-unique clear credentials locally."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import secrets
import shutil
import subprocess
import sys
import tempfile
import uuid


PLACEHOLDER = "DISABLED:portal-bootstrap-v1"


def verifier(clear_value: str) -> str:
    raw = secrets.token_bytes(16)
    signed = [value if value < 128 else value - 256 for value in raw]
    salt = ("[" + ", ".join(str(value) for value in signed) + "]").encode("utf-8")
    derived = hashlib.pbkdf2_hmac("sha1", clear_value.encode("utf-8"), salt, 1000, 64)
    return f"1000:{salt.hex()}:{derived.hex()}"


def psql_command(args: argparse.Namespace) -> list[str]:
    return [args.docker, "exec", "-i", args.container, "psql", "-U", args.user,
            "-d", args.database, "-X", "-v", "ON_ERROR_STOP=1", "-qAt"]


def query(args: argparse.Namespace, sql: str) -> list[dict]:
    completed = subprocess.run(psql_command(args) + ["-c", sql], check=True,
                               text=True, capture_output=True)
    return [json.loads(line) for line in completed.stdout.splitlines() if line]


def sql_literal(value: str) -> str:
    return "'" + value.replace("'", "''") + "'"


def run(args: argparse.Namespace) -> int:
    manifest = json.loads(Path(args.manifest).read_text(encoding="utf-8"))
    if manifest.get("credentialSanitizationPolicy") != "disabled-placeholders-v1":
        raise ValueError("manifest does not declare disabled-placeholders-v1")
    users = query(args, """
        SELECT jsonb_build_object('userId', user_id, 'email', email)::text
          FROM user_t WHERE password = 'DISABLED:portal-bootstrap-v1'
         ORDER BY user_id
    """)
    clients = query(args, """
        SELECT jsonb_build_object('hostId', host_id, 'clientId', client_id,
                                  'clientName', client_name)::text
          FROM auth_client_t
         WHERE client_secret = 'DISABLED:portal-bootstrap-v1'
         ORDER BY host_id, client_id
    """)
    output = Path(args.output_dir)
    user_path = output / "bootstrap-users.json"
    client_path = output / "bootstrap-oauth-clients.json"
    if not users and not clients:
        if user_path.is_file() and client_path.is_file():
            return 0
        raise ValueError("no credential placeholders found and no prior delivery files exist")

    user_delivery = []
    client_delivery = []
    statements = ["BEGIN;"]
    for user in users:
        user_id = str(uuid.UUID(user["userId"]))
        clear = secrets.token_urlsafe(32)
        user_delivery.append({**user, "password": clear})
        statements.append(
            "UPDATE user_t SET password = " + sql_literal(verifier(clear))
            + " WHERE user_id = '" + user_id + "'::uuid AND password = "
            + sql_literal(PLACEHOLDER) + ";")
    for client in clients:
        host_id = str(uuid.UUID(client["hostId"]))
        client_id = str(uuid.UUID(client["clientId"]))
        clear = secrets.token_urlsafe(48)
        client_delivery.append({**client, "clientSecret": clear})
        statements.append(
            "UPDATE auth_client_t SET client_secret = " + sql_literal(verifier(clear))
            + " WHERE host_id = '" + host_id + "'::uuid AND client_id = '"
            + client_id + "'::uuid AND client_secret = " + sql_literal(PLACEHOLDER) + ";")
    statements.append("COMMIT;")

    output.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    if output.exists():
        if any(output.iterdir()):
            raise ValueError(f"credential delivery directory is not empty: {output}")
        output.rmdir()
    staging = Path(tempfile.mkdtemp(prefix=output.name + ".", dir=output.parent))
    os.chmod(staging, 0o700)
    database_updated = False
    try:
        for destination, value in ((user_path, user_delivery), (client_path, client_delivery)):
            staged_file = staging / destination.name
            with staged_file.open("w", encoding="utf-8") as stream:
                json.dump(value, stream, indent=2)
                stream.write("\n")
            os.chmod(staged_file, 0o600)
        subprocess.run(psql_command(args), input="\n".join(statements), text=True,
                       check=True, capture_output=True)
        database_updated = True
        os.replace(staging, output)
    finally:
        if staging.exists() and not database_updated:
            shutil.rmtree(staging)
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("manifest")
    parser.add_argument("--output-dir", default="bootstrap/secrets")
    parser.add_argument("--docker", default="docker")
    parser.add_argument("--container", default="postgres")
    parser.add_argument("--user", default="postgres")
    parser.add_argument("--database", default="configserver")
    args = parser.parse_args()
    try:
        return run(args)
    except (OSError, ValueError, KeyError, json.JSONDecodeError,
            subprocess.CalledProcessError) as error:
        print(f"bootstrap credential rotation error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
