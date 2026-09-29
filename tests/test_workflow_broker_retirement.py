"""Protect installer artifacts against reintroducing the retired issuer profile."""
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]


class WorkflowBrokerRetirementTest(unittest.TestCase):
    def test_provisioning_assets_are_absent(self):
        for name in ('README.md', 'compose.yml', 'credential_broker.sql', 'issuer-server.yml',
                     'local-profile.json', 'prepare.py', 'refresh-claims-preflight.sql', 'set-ownership.py'):
            with self.subTest(name=name):
                self.assertFalse((ROOT / 'workflow-broker' / name).exists())

    def test_issuer_config_has_no_broker_key(self):
        config = (ROOT / 'light-oauth-rust/config/server.yml').read_text()
        self.assertNotIn('workflowBroker', config)
        self.assertNotIn('workflow_broker', config)

    def test_bootstrap_retires_only_broker_runtime_tables(self):
        sql = (ROOT / 'postgres-db/init.sql').read_text()
        tables = set(re.findall(r'^CREATE TABLE (?:public\.)?([a-z_]+) \(', sql, re.M))
        for suffix in ('broker', 'broker_certificate', 'enrollment', 'grant', 'token_history', 'revocation'):
            table = 'auth_workflow_' + suffix + '_t'
            self.assertNotIn(table, tables)
            self.assertNotIn("'" + table + "'", sql)
        for table in ('auth_refresh_claim_source_t', 'auth_workflow_long_binding_t',
                      'auth_workflow_long_binding_deleted_t'):
            self.assertIn(table, tables)


if __name__ == '__main__':
    unittest.main()
