import hashlib
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
KNOWLEDGE_DIR = ROOT / "postgres-db" / "knowledge"
EXPECTED_DDL_SHA256 = "fe7eec66e59e71eb81ffa4232b02957d7bceda6408ca0c0e7030bdf96b61f314"


class KnowledgeSchemaTest(unittest.TestCase):
    def test_packaged_canonical_ddl_digest(self):
        actual = hashlib.sha256((KNOWLEDGE_DIR / "ddl.sql").read_bytes()).hexdigest()
        self.assertEqual(EXPECTED_DDL_SHA256, actual)

    def test_bootstrap_does_not_clone_or_filter_the_config_server_schema(self):
        script = (ROOT / "postgres-db" / "init-knowledge.sh").read_text(
            encoding="utf-8"
        )
        self.assertIn("knowledge/ddl.sql", script)
        self.assertNotIn("--schema-only --no-owner", script)
        self.assertNotIn("DROP %s IF EXISTS", script)

    def test_phase2_snapshot_bootstrap_has_a_recurring_lease_refresh(self):
        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        sync = (ROOT / "light-knowledge" / "sync-control-snapshot.sh").read_text(
            encoding="utf-8"
        )
        self.assertIn("knowledge-control-snapshot-sync:", compose)
        self.assertIn("knowledge-control-snapshot-refresh:", compose)
        self.assertIn("SNAPSHOT_REFRESH_SECONDS", compose)
        self.assertIn("control-snapshots:apply", compose)
        self.assertIn("while true", sync)
        self.assertNotIn("LIGHT_KNOWLEDGE_CONTROL_EVENT_DATABASE_URL", compose)

    def test_packaged_boundary_files_match_portal_db_when_both_repos_exist(self):
        portal_db = ROOT.parent / "portal-db" / "postgres" / "knowledge"
        if not portal_db.is_dir():
            self.skipTest("portal-db sibling checkout is unavailable")
        for name in (
            "ddl.sql",
            "roles.sql",
            "patch_20260821_02_canonical_knowledge_boundary.sql",
            "patch_20260821_03_snapshot_command_boundary.sql",
            "patch_20260821_04_configserver_knowledge_control_only.sql",
        ):
            self.assertEqual(
                (portal_db / name).read_bytes(),
                (KNOWLEDGE_DIR / name).read_bytes(),
                f"packaged Knowledge boundary file drifted: {name}",
            )


if __name__ == "__main__":
    unittest.main()
