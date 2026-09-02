import base64
import json
import os
from pathlib import Path
import re
import subprocess
import unittest


ROOT = Path(__file__).resolve().parents[1]
INSTALLER = ROOT / "install.sh"


class InstallerTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.script = INSTALLER.read_text(encoding="utf-8")

    def test_cache_busted_url_supports_plain_and_existing_query_urls(self):
        match = re.search(
            r"^cache_busted_url\(\) \{.*?^\}",
            self.script,
            flags=re.MULTILINE | re.DOTALL,
        )
        self.assertIsNotNone(match)
        helper = match.group(0)
        env = os.environ | {"LIGHT_PORTAL_ASSET_CACHE_BUST": "release-test"}

        plain = subprocess.run(
            ["bash", "-c", helper + '\ncache_busted_url "$1"', "_",
             "https://cdn.example/events.zip"],
            text=True,
            capture_output=True,
            check=False,
            env=env,
        )
        queried = subprocess.run(
            ["bash", "-c", helper + '\ncache_busted_url "$1"', "_",
             "https://cdn.example/events.zip?channel=latest"],
            text=True,
            capture_output=True,
            check=False,
            env=env,
        )

        self.assertEqual(0, plain.returncode, plain.stderr)
        self.assertEqual(
            "https://cdn.example/events.zip?cachebust=release-test\n",
            plain.stdout,
        )
        self.assertEqual(0, queried.returncode, queried.stderr)
        self.assertEqual(
            "https://cdn.example/events.zip?channel=latest&cachebust=release-test\n",
            queried.stdout,
        )

    def test_only_events_archive_uses_cache_busted_download_url(self):
        function = self.script[
            self.script.index("download_archive_file() {") :
            self.script.index("download_release_artifacts() {")
        ]
        self.assertIn('if [[ "$archive_name" == "events.zip" ]]', function)
        self.assertIn('archive_url="$(cache_busted_url "$archive_url")"', function)
        self.assertIn('download_target="$archive_file.candidate"', function)
        self.assertIn('download_file "$archive_url" "$download_target"', function)

    def test_event_bundle_is_verified_before_it_replaces_or_extracts_assets(self):
        function = self.script[
            self.script.index("download_archive_file() {") :
            self.script.index("download_release_artifacts() {")
        ]
        verify = function.index('verify_event_bundle "$download_target"')
        replace = function.index('mv "$download_target" "$archive_file"')
        extract = function.index('unzip -p "$archive_file" "$member_name"')
        self.assertLess(verify, replace)
        self.assertLess(replace, extract)

        verifier = self.script[
            self.script.index("verify_event_bundle() {") :
            self.script.index("download_archive() {")
        ]
        self.assertIn('--verify-bundle', verifier)
        self.assertIn('--bundle-key-dir /bundle-keys', verifier)
        self.assertIn('${EVENT_BUNDLE_KEY_DIR:-release-keys}', verifier)

        install_case = self.script[
            self.script.index("  install)\n") : self.script.index("  update)\n")
        ]
        self.assertLess(
            install_case.index("download_assets"),
            install_case.index("clean_volumes_if_requested"),
        )

    def test_current_event_bundle_public_key_is_shipped(self):
        key = ROOT / "release-keys" / "portal-release-2026-01.pem"
        content = key.read_text(encoding="utf-8")
        self.assertIn("-----BEGIN PUBLIC KEY-----", content)
        self.assertNotIn("PRIVATE KEY", content)

    def test_preserved_database_repairs_portal_runtime_write_access(self):
        function = self.script[
            self.script.index("ensure_portal_runtime_database_access() {") :
            self.script.index("ensure_knowledge_runtime() {")
        ]
        self.assertIn(
            "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configserver TO portal_local_runtime;",
            function,
        )
        self.assertIn(
            "ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA configserver",
            function,
        )
        self.assertGreaterEqual(
            self.script.count("ensure_portal_runtime_database_access"), 3
        )

    def test_hybrid_projectors_do_not_use_retired_runtime_role(self):
        for relative_path in (
            "hybrid-command/config/values.yml",
            "hybrid-query/node1/values.yml",
        ):
            values = (ROOT / relative_path).read_text(encoding="utf-8")
            self.assertIn("db-provider.username: postgres", values)
            self.assertNotIn("db-provider.username: portal_local_runtime", values)

    def test_agent_template_uses_remote_config_namespace(self):
        template = (ROOT / "light-agent-rust/config/agent.yml").read_text(
            encoding="utf-8"
        )
        self.assertIn("${agent.runtimePolicy.publicationId:}", template)
        self.assertIn("${agent.portalAssociation.runtimeInstanceId:}", template)
        self.assertIn("${agent.agentPolicy.agentDefId:}", template)
        self.assertNotIn("${runtimePolicy.publicationId:}", template)
        self.assertNotIn("${portalAssociation.runtimeInstanceId:}", template)
        self.assertNotIn("${agentPolicy.agentDefId:}", template)

        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        self.assertIn(
            "AGENT_OPERATIONALSTORE_DATABASEURLFILE: /tmp/operational-database-url",
            compose,
        )
        self.assertNotIn("AGENTPOLICY_AGENTDEFID:", compose)

    def test_agent_bootstrap_transport_stays_local_and_policy_stays_remote(self):
        values = (ROOT / "light-agent-rust/config/values.yml").read_text(
            encoding="utf-8"
        )
        self.assertIn(
            "server.environment: ${LIGHT_AGENT_ENVIRONMENT:dev}", values
        )
        self.assertNotIn("model-provider.", values)
        self.assertNotIn("codex.", values)
        self.assertNotIn("\noperationalStore.", values)

        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        self.assertNotIn("e741fa85-8a3d-432c-b31c-c41439d23f42", compose)
        self.assertNotIn(
            "sha256:c29d23732e9136115f928ae52172bc73322a8f8700d789ede8c6b9e264ce48c5",
            compose,
        )
        match = re.search(
            r"LIGHT_AGENT_LIGHT_PORTAL_AUTHORIZATION:-Bearer ([A-Za-z0-9_.-]+)",
            compose,
        )
        self.assertIsNotNone(match)
        payload_segment = match.group(1).split(".")[1]
        payload_segment += "=" * (-len(payload_segment) % 4)
        claims = json.loads(base64.urlsafe_b64decode(payload_segment))
        self.assertEqual("dev", claims.get("env"))
        self.assertEqual(
            "com.networknt.agent.account-1.0.0", claims.get("sid")
        )
        self.assertEqual(claims.get("sub"), claims.get("client_id"))

    def test_workflow_cache_is_owned_before_runtime_start(self):
        compose = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
        self.assertIn("light-workflow-config-cache-init:", compose)
        self.assertIn(
            'command: ["chown -R 999:999 /app/config-cache && chmod 700 /app/config-cache"]',
            compose,
        )
        workflow = compose[compose.index("  light-workflow:\n") :]
        self.assertIn(
            "light-workflow-config-cache-init:\n        condition: service_completed_successfully",
            workflow,
        )


if __name__ == "__main__":
    unittest.main()
