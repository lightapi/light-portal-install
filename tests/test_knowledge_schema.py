import hashlib
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
KNOWLEDGE_DIR = ROOT / "postgres-db" / "knowledge"
EXPECTED_DDL_SHA256 = "c949e1c4b5b9e7cffd9745b538fc78e26e6824dc164c579bc6f651599fc305c0"


class KnowledgeSchemaTest(unittest.TestCase):
    def test_packaged_canonical_ddl_digest(self):
        actual = hashlib.sha256((KNOWLEDGE_DIR / "ddl.sql").read_bytes()).hexdigest()
        self.assertEqual(EXPECTED_DDL_SHA256, actual)

    def test_bootstrap_installs_an_isolated_schema_pair(self):
        validator = (ROOT / "postgres-db" / "validate-environment.sh").read_text(
            encoding="utf-8"
        )
        initializer = (ROOT / "postgres-db" / "init-environment.sh").read_text(
            encoding="utf-8"
        )
        renderer = (ROOT / "postgres-db" / "lib" / "render-schema.sh").read_text(
            encoding="utf-8"
        )
        self.assertIn('topology="${PORTAL_DB_TOPOLOGY:-separate}"', initializer)
        self.assertIn('configserver_schema="configserver"', initializer)
        self.assertIn('knowledge_schema="knowledge"', initializer)
        self.assertIn('configserver_schema="configserver_${environment_name}"', initializer)
        self.assertIn('knowledge_schema="knowledge_${environment_name}"', initializer)
        self.assertIn("REVOKE CREATE ON SCHEMA public FROM PUBLIC", initializer)
        self.assertIn("knowledge_control_snapshot_t", validator)
        self.assertIn("__PORTAL_DB_EXTENSION_SCHEMA__.vector", renderer)
        self.assertNotIn("DROP DATABASE", initializer)

        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        self.assertIn("DROP DATABASE IF EXISTS knowledge WITH (FORCE)", install)
        self.assertIn("DROP DATABASE IF EXISTS configserver WITH (FORCE)", install)
        self.assertNotIn("DROP SCHEMA IF EXISTS knowledge_local CASCADE", install)

        validator_call = install[
            install.index("ensure_knowledge_database() {") :
            install.index("ensure_portal_runtime_database_access() {")
        ]
        self.assertIn(
            "compose run --rm --no-deps knowledge-schema-migration",
            validator_call,
        )
        self.assertNotIn("docker exec", validator_call)

    def test_phase2_snapshot_refresh_runs_inside_knowledge_admin(self):
        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        self.assertNotIn("knowledge-control-snapshot-sync:", compose)
        self.assertNotIn("knowledge-control-snapshot-refresh:", compose)
        self.assertIn('KNOWLEDGE_ADMIN_SNAPSHOT_SOURCE_ENABLED: "true"', compose)
        self.assertIn("KNOWLEDGE_ADMIN_SNAPSHOT_REFRESH_SECONDS", compose)
        self.assertIn("LIGHT_KNOWLEDGE_SNAPSHOT_AUTHORIZATION", compose)
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
            "patch_20260821_06_knowledge_admin_pgcrypto.sql",
            "patch_20260821_07_knowledge_admin_audit_retention.sql",
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
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        self.assertIn(
            "compose run --rm --no-deps knowledge-schema-migration",
            install,
        )
        ddl = (KNOWLEDGE_DIR / "ddl.sql").read_text(encoding="utf-8")
        self.assertIn("CREATE TABLE public.knowledge_admin_audit_t", ddl)
        self.assertIn("knowledge_admin_sync_runs_page_idx", ddl)
        self.assertIn("CREATE EXTENSION IF NOT EXISTS pgcrypto", ddl)
        self.assertIn("'CONTROL_SNAPSHOT_APPLY'::text", ddl)
        self.assertIn("SELECT,INSERT,UPDATE,DELETE", ddl)

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

    def test_portal_runtime_identity_precedes_event_processors(self):
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        helper = install[
            install.index("ensure_portal_runtime_database_access() {") :
            install.index("ensure_knowledge_runtime() {")
        ]
        self.assertIn("CREATE ROLE portal_local_runtime LOGIN", helper)
        self.assertIn("ALTER ROLE portal_local_runtime LOGIN PASSWORD 'secret'", helper)
        self.assertIn("IN SCHEMA configserver", helper)
        self.assertIn("SET search_path = configserver, public", helper)
        self.assertIn("ALTER DEFAULT PRIVILEGES FOR ROLE postgres", helper)

        bootstrap = install[
            install.index("bootstrap_events() {") :
            install.index('case "$command_name" in')
        ]
        identity = bootstrap.index("ensure_portal_runtime_database_access")
        processors = bootstrap.index("start_event_processors")
        self.assertLess(identity, processors)

        knowledge_runtime = install[
            install.index("ensure_knowledge_runtime() {") :
            install.index("validate_compose_config() {")
        ]
        self.assertIn("ensure_portal_runtime_database_access", knowledge_runtime)

    def test_release_database_patches_are_rendered_into_local_schema(self):
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        helper = install[
            install.index("apply_db_patches() {") :
            install.index("verify_event_delta_applied() {")
        ]
        self.assertIn("PORTAL_DB_CONFIGSERVER_SOURCE", helper)
        self.assertIn(
            "render-schema.sh configserver configserver", helper
        )
        self.assertNotIn('psql_exec < "$source_sql"', helper)

    def test_snapshot_signing_key_exists_before_bootstrap_containers(self):
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        helper = install[
            install.index("ensure_control_snapshot_signing_key() {") :
            install.index("ensure_knowledge_database() {")
        ]
        self.assertIn("rmdir", helper)
        self.assertIn("write_secret_once", helper)

        bootstrap = install[
            install.index("bootstrap_events() {") :
            install.index('case "$command_name" in')
        ]
        signing_key = bootstrap.index("ensure_control_snapshot_signing_key")
        postgres = bootstrap.index("compose up -d postgres")
        processors = bootstrap.index("start_event_processors")
        self.assertLess(signing_key, postgres)
        self.assertLess(signing_key, processors)

        start_processors = install[
            install.index("start_event_processors() {") :
            install.index("event_store_count() {")
        ]
        self.assertIn(
            "compose up -d --no-deps --force-recreate hybrid-command hybrid-query",
            start_processors,
        )

    def test_agent_delegation_secret_is_generated_persisted_and_reused(self):
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        helper = install[
            install.index("ensure_agent_delegation_secret() {") :
            install.index("ensure_control_snapshot_signing_key() {")
        ]
        self.assertIn("env_value LIGHT_AGENT_DELEGATION_SECRET", helper)
        self.assertIn('-s "$secret_file"', helper)
        self.assertIn("openssl rand -hex 48", helper)
        self.assertIn(
            "persist_env_value LIGHT_AGENT_DELEGATION_SECRET", helper
        )
        self.assertIn(
            'export LIGHT_AGENT_DELEGATION_SECRET="$delegation_secret"', helper
        )

        knowledge_runtime = install[
            install.index("ensure_knowledge_runtime() {") :
            install.index("validate_compose_config() {")
        ]
        self.assertIn("ensure_agent_delegation_secret", knowledge_runtime)
        self.assertNotIn(
            "Knowledge services require LIGHT_AGENT_DELEGATION_SECRET",
            knowledge_runtime,
        )

    def test_non_root_knowledge_services_receive_secret_reader_group(self):
        install = (ROOT / "install.sh").read_text(encoding="utf-8")
        helper = install[
            install.index("prepare_knowledge_secret_access() {") :
            install.index("ensure_control_snapshot_signing_key() {")
        ]
        self.assertIn('secret_gid="$(id -g)"', helper)
        self.assertIn('chmod 640 "$secret_dir/$secret_file"', helper)
        self.assertIn("light-knowledge/objects light-knowledge/checkouts", helper)
        self.assertIn('chmod 2770 "$runtime_dir"', helper)
        self.assertIn("persist_env_value LIGHT_PORTAL_SECRET_GID", helper)

        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        self.assertEqual(
            3, compose.count('- "${LIGHT_PORTAL_SECRET_GID:-1000}"')
        )

    def test_shared_bind_mounts_use_shared_selinux_labels(self):
        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        for source in (
            "./postgres-db/init-environment.sh",
            "./postgres-db/lib",
            "./postgres-db/validate-environment.sh",
            "./postgres-db/knowledge",
            "./light-controller-rust/ca.pem",
            "./light-knowledge/secrets",
            "./light-knowledge/objects",
            "./light-knowledge/checkouts",
            "./light-gateway-rust/config",
            "./light-gateway-rust/config/ca.pem",
        ):
            for line in compose.splitlines():
                if line.strip().startswith(f"- {source}:"):
                    self.assertTrue(
                        line.endswith(":z") or line.endswith(",z"),
                        f"shared bind mount must use an SELinux shared label: {line}",
                    )

        signing_mounts = [
            line
            for line in compose.splitlines()
            if line.strip().startswith(
                "- ./light-knowledge/secrets/control-snapshot-signing-key:"
            )
        ]
        self.assertEqual(2, len(signing_mounts))
        self.assertTrue(
            all(line.endswith(":z") or line.endswith(",z") for line in signing_mounts)
        )

    def test_light_knowledge_uses_a_non_root_writable_working_directory(self):
        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        light_knowledge = compose[
            compose.index("  light-knowledge:\n") :
            compose.index("  light-knowledge-worker:\n")
        ]
        self.assertIn("working_dir: /var/lib/light-knowledge", light_knowledge)


if __name__ == "__main__":
    unittest.main()
