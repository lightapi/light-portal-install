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
        self.assertIn('download_file "$archive_url" "$archive_file"', function)


if __name__ == "__main__":
    unittest.main()
