import hashlib
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
KNOWLEDGE_DIR = ROOT / "postgres-db" / "knowledge"
EXPECTED_DDL_SHA256 = "7ee640f7aa3204692ee3018149ad043a3e9d4524ba614bbaff924ffffaf9a6fd"


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
        self.assertNotIn("public.knowledge_*", script)
        self.assertIn("data-migration-relations-v1.txt", script)
        self.assertIn("Knowledge migration count mismatch", script)

        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        self.assertNotIn("public.knowledge_*", install)
        self.assertIn("zz-init-knowledge.sh", install)

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
            "patch_20260821_05_admin_api.sql",
            "data-migration-relations-v1.txt",
        ):
            self.assertEqual(
                (portal_db / name).read_bytes(),
                (KNOWLEDGE_DIR / name).read_bytes(),
                f"packaged Knowledge boundary file drifted: {name}",
            )
        operation = "phase7_drop_configserver_rollback_evidence.sql"
        self.assertEqual(
            (portal_db / "operations" / operation).read_bytes(),
            (KNOWLEDGE_DIR / "operations" / operation).read_bytes(),
            f"packaged Knowledge operation drifted: {operation}",
        )

    def test_phase7_removes_disabled_client_compatibility_switches(self):
        runtime = "\n".join(
            (ROOT / relative).read_text(encoding="utf-8")
            for relative in (
                "hybrid-query/node1/values.yml",
                "hybrid-query/node1/knowledge-admin-client.yml",
                "docker-compose.yml",
            )
        )
        for marker in (
            "knowledge-admin-client.enabled",
            "knowledge-admin-client.shadow",
            "knowledge-admin-client.cutover",
            "legacyAuthoritative",
            "shadowEnvironments",
            "KNOWLEDGE_ADMIN_CLIENT_ENABLED",
        ):
            self.assertNotIn(marker, runtime)

    def test_phase3_admin_api_upgrade_is_installed(self):
        init = (ROOT / "postgres-db" / "init-knowledge.sh").read_text(
            encoding="utf-8"
        )
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        self.assertIn("knowledge_admin_audit_t", init)
        self.assertIn("patch_20260821_05_admin_api.sql", init)
        self.assertIn("zz-init-knowledge.sh", install)
        ddl = (KNOWLEDGE_DIR / "ddl.sql").read_text(encoding="utf-8")
        self.assertIn("CREATE TABLE public.knowledge_admin_audit_t", ddl)
        self.assertIn("knowledge_admin_sync_runs_page_idx", ddl)

    def test_config_server_bootstrap_retains_canonical_seed_data(self):
        ddl = (ROOT / "postgres-db" / "init.sql").read_text(encoding="utf-8")
        for relation in (
            "scheduler_lock_t",
            "log_counter",
            "pii_token_scheme_t",
            "cascade_relationship_policy_seed_t",
            "cascade_relationship_policy_t",
        ):
            self.assertTrue(
                f"INSERT INTO public.{relation}" in ddl
                or f"INSERT INTO {relation}" in ddl,
                f"Config Server seed missing: {relation}",
            )


if __name__ == "__main__":
    unittest.main()
