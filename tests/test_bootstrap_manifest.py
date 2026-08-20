import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "bootstrap_manifest.py"
CHECKSUM_SCRIPT = ROOT / "scripts" / "bootstrap_checksums.py"
ROTATION_SCRIPT = ROOT / "scripts" / "rotate-bootstrap-credentials.py"
PROFILE = ROOT / "bootstrap" / "portal-bootstrap-v1.json"


class BootstrapManifestTest(unittest.TestCase):
    def test_reference_rotation_verifier_matches_java_hash_shape(self):
        spec = importlib.util.spec_from_file_location("rotate_bootstrap_credentials",
                                                      ROTATION_SCRIPT)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        encoded = module.verifier("test-secret")
        iterations, salt_hex, hash_hex = encoded.split(":")
        self.assertEqual("1000", iterations)
        self.assertEqual(64, len(bytes.fromhex(hash_hex)))
        self.assertTrue(bytes.fromhex(salt_hex).startswith(b"["))

    def test_checksum_profile_builds_only_explicit_column_sql(self):
        sys.path.insert(0, str(CHECKSUM_SCRIPT.parent))
        try:
            import bootstrap_checksums
            profile = json.loads(PROFILE.read_text(encoding="utf-8"))
            queries = [bootstrap_checksums.table_query(table)
                       for table in profile["tables"]]
        finally:
            sys.path.pop(0)
        self.assertTrue(all("SELECT *" not in query for query in queries))
        self.assertTrue(all("ORDER BY" in query for query in queries))
        self.assertTrue(any("'@db-ts@'" in query for query in queries))

    def test_verifies_exact_archive_events_and_profile_digests(self):
        with tempfile.TemporaryDirectory() as directory:
            temp = Path(directory)
            archive = temp / "portal.dump"
            events = temp / "events.json"
            archive.write_bytes(b"archive")
            events.write_text("[]", encoding="utf-8")
            manifest = self.manifest(archive, events)
            manifest_path = temp / "manifest.json"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
            result = self.run_verify(manifest_path, archive, events)
            self.assertEqual(0, result.returncode, result.stderr)

            archive.write_bytes(b"tampered")
            result = self.run_verify(manifest_path, archive, events)
            self.assertNotEqual(0, result.returncode)

    def test_rejects_unknown_credential_policy(self):
        with tempfile.TemporaryDirectory() as directory:
            temp = Path(directory)
            archive = temp / "portal.dump"
            events = temp / "events.json"
            archive.write_bytes(b"archive")
            events.write_text("[]", encoding="utf-8")
            manifest = self.manifest(archive, events)
            manifest["credentialSanitizationPolicy"] = "public-seed"
            manifest_path = temp / "manifest.json"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
            self.assertNotEqual(0, self.run_verify(manifest_path, archive, events).returncode)

    def manifest(self, archive: Path, events: Path) -> dict:
        digest = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
        return {
            "format": "lightapi.portal-postgres-bootstrap",
            "formatVersion": 1,
            "postgresMajor": 18,
            "portalDbCommit": "abc",
            "schemaSha256": "a" * 64,
            "releaseSigningIdentity": "test-key",
            "eventsJsonSha256": digest(events),
            "eventCount": 2,
            "singletonTransactionCount": 2,
            "archiveBaselineId": "test-baseline-1",
            "includedDeltaIds": [],
            "eventDeltas": [],
            "checksumProfile": "portal-bootstrap-v1",
            "canonicalizationSpecSha256": digest(PROFILE),
            "credentialSanitizationPolicy": "disabled-placeholders-v1",
            "projectionChecksumSet": {"profile": "portal-bootstrap-v1", "tables": {}},
            "bootstrapArchive": {
                "object": "portal.dump",
                "signatureObject": "manifest.sig",
                "signatureAlgorithm": "openssl-dgst-sha256",
                "sha256": digest(archive),
                "bytes": archive.stat().st_size,
            },
        }

    def run_verify(self, manifest: Path, archive: Path, events: Path):
        return subprocess.run([
            sys.executable, str(SCRIPT), "verify", "--manifest", str(manifest),
            "--archive", str(archive), "--events", str(events),
            "--profile", str(PROFILE), "--postgres-major", "18",
        ], text=True, capture_output=True, check=False)


if __name__ == "__main__":
    unittest.main()
