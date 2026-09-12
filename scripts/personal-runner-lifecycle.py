#!/usr/bin/env python3
"""Preflight, restart and qualify configured host personal runners without exposing tokens."""
import argparse
import base64
import hashlib
import ipaddress
import json
import math
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import time
import urllib.request

import yaml

UNITS = {
    'light-workflow-runner-personal': 'light-workflow-runner-personal.service',
    'light-workflow-runner-claude-personal': 'light-workflow-runner-claude-personal.service',
}


def system_property(unit, name):
    return subprocess.check_output(
        ['systemctl', '--user', 'show', unit, '-p', name, '--value'],
        text=True, stderr=subprocess.DEVNULL, timeout=10).strip()


def file_digest(path):
    with Path(path).open('rb') as stream:
        return 'sha256:' + hashlib.file_digest(stream, 'sha256').hexdigest()


def check_token(path, label, now=None):
    # Diagnostic only: signature, audience and identity remain server-validated.
    try:
        encoded = Path(path).read_text().strip().removeprefix('Bearer ').split('.')[1]
        claims = json.loads(base64.urlsafe_b64decode(encoded + '=' * (-len(encoded) % 4)))
        remaining = float(claims['exp']) - (time.time() if now is None else now)
    except (OSError, ValueError, KeyError, IndexError, TypeError):
        raise ValueError(f'{label}: missing or malformed expiring issuer token; renew through the local issuer') from None
    if not math.isfinite(remaining) or remaining <= 300:
        raise ValueError(f'{label}: issuer token expired or expires within five minutes; renew and rerun setup')
    if remaining < 86400:
        print(f'Warning: {label} issuer token expires within 24 hours; schedule renewal.')


def configured_runners(distribution):
    runners = []
    for folder, unit in UNITS.items():
        runtime = distribution / folder / '.runtime'
        configured = any((runtime / name).exists() for name in ['runner.yml', 'credentials.compose.yml', 'service.jwt'])
        try:
            loaded = system_property(unit, 'LoadState') == 'loaded'
        except (OSError, subprocess.SubprocessError):
            loaded = False
        if not loaded:
            if configured:
                raise ValueError(f'{unit}: enrollment files exist but user service is not installed; complete setup')
            continue
        environment = dict(item.split('=', 1) for item in shlex.split(system_property(unit, 'Environment')) if '=' in item)
        config_path = Path(environment.get('LIGHT_WORKFLOW_RUNNER_CONFIG_FILE', ''))
        match = re.search(r'\bpath=(.*?) ; argv\[\]=', system_property(unit, 'ExecStart'))
        if not config_path.is_absolute() or not config_path.is_file() or not match:
            raise ValueError(f'{unit}: installed unit lacks an absolute config/executable; rerun setup')
        executable = Path(match.group(1))
        if not executable.is_absolute() or not executable.is_file():
            raise ValueError(f'{unit}: installed runner binary missing; rebuild and rerun setup')
        config = yaml.safe_load(config_path.read_text())
        runners.append(dict(unit=unit, runtime=runtime, config=config, config_path=config_path, executable=executable))
    return runners


def preflight(runner):
    config, unit = runner['config'], runner['unit']
    check_token(config['jwtFile'], unit)
    service_token = runner['runtime'] / 'service.jwt'
    if service_token.exists():
        check_token(service_token, unit + ' Agent')
    worker = config.get('agentWorker', {})
    if worker and file_digest(worker['executable']) != worker['binaryDigest']:
        raise ValueError(f'{unit}: worker binary pin mismatch; rebuild, rerun setup and republish the profile')
    if worker.get('claudeHome'):
        profile_path = runner['runtime'] / 'coding-profile.json'
        profile = json.loads(profile_path.read_text())
        if file_digest(worker['claudeExecutable']) != profile['binaryDigest']:
            raise ValueError(f'{unit}: native Claude binary pin mismatch; qualify the new version before updating the profile')
        # Credentials stay on the host. Inspect expiry metadata only, never print
        # token contents or run native commands that could refresh the login.
        try:
            credentials = json.loads((Path(worker['claudeHome']) / '.credentials.json').read_text())
            expiry = credentials['claudeAiOauth']['expiresAt']
        except (OSError, ValueError, KeyError, TypeError):
            raise ValueError(f'{unit}: native file-backed login/expiry metadata unavailable; refresh Claude login on the host') from None
        if not isinstance(expiry, (int, float)) or isinstance(expiry, bool) or not math.isfinite(expiry):
            raise ValueError(f'{unit}: native login expiry metadata invalid; refresh Claude login on the host')
        if expiry / 1000 <= time.time() + 300:
            raise ValueError(f'{unit}: native Claude login expired or near expiry; refresh on the host, then retry')
        if shutil.disk_usage(worker['claudeHome']).free < 1024 ** 3:
            raise ValueError(f'{unit}: native session filesystem has less than 1 GiB free; inspect retained state before restarting')
    health_url(config)  # Validate the configured endpoint before any restart.


def health_url(config):
    address = config['healthAddress']
    host, port = address.rsplit(':', 1)
    if not ipaddress.ip_address(host.strip('[]')).is_loopback or not 1 <= int(port) <= 65535:
        raise ValueError('Personal runner healthAddress must be loopback with a valid port')
    return 'http://' + address


def read_http(url):
    # Host-local qualification must never follow a proxy or redirect elsewhere.
    class NoRedirect(urllib.request.HTTPRedirectHandler):
        def redirect_request(self, *args):
            raise ValueError('Runner health endpoint redirected')
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}), NoRedirect())
    with opener.open(url, timeout=2) as response:
        body = response.read(65537)
    if len(body) > 65536:
        raise ValueError('Runner health response exceeds limit')
    return body.decode()


def verify_running_identity(runner):
    unit = runner['unit']
    if system_property(unit, 'ActiveState') != 'active':
        raise ValueError('service is not active')
    pid = int(system_property(unit, 'MainPID'))
    if pid <= 0:
        raise ValueError('service has no process')
    process = Path('/proc') / str(pid)
    if (process / 'exe').resolve(strict=True) != runner['executable'].resolve(strict=True):
        raise ValueError('running executable differs from installed unit')
    entries = (process / 'environ').read_bytes().split(b'\0')
    expected = b'LIGHT_WORKFLOW_RUNNER_CONFIG_FILE=' + os.fsencode(runner['config_path'])
    if expected not in entries:
        raise ValueError('running configuration path differs from installed unit')


def check_ready(runner):
    verify_running_identity(runner)
    base = health_url(runner['config'])
    health = json.loads(read_http(base + '/healthz'))
    required = ['controllerConnected', 'backendHealthy', 'journalHealthy', 'watchdogHealthy', 'orphanReconciliationHealthy']
    if health.get('status') != 'healthy' or any(health.get(key) is not True for key in required):
        raise ValueError('runner is not healthy and Controller-connected; check enrollment expiry and admission')
    digest = runner['config']['backend']['compatibilityDigest']
    metrics = read_http(base + '/metrics')
    if not any(line.startswith('light_runner_backend_info{') and f'compatibility_digest="{digest}"' in line
               for line in metrics.splitlines()):
        raise ValueError('running backend compatibility differs from installed configuration')


def wait_ready(runner, timeout):
    deadline = time.monotonic() + timeout
    last = 'runner not ready'
    while True:
        try:
            check_ready(runner)
            print(runner['unit'] + ': healthy, Controller-connected, installed identity verified')
            return
        except (OSError, ValueError, KeyError, subprocess.SubprocessError) as error:
            # Never expose HTTP response bodies, config, environment or tokens.
            last = str(error) if isinstance(error, ValueError) else type(error).__name__
        if time.monotonic() >= deadline:
            raise ValueError(f"{runner['unit']}: readiness timed out: {last}")
        time.sleep(min(1, max(0, deadline - time.monotonic())))


def run(distribution, action, timeout):
    runners = configured_runners(distribution.resolve())
    if action == 'storage':
        for runner in runners:
            storage_report(runner)
        return
    for runner in runners:
        preflight(runner)
    if action == 'preflight':
        print(f'Personal runner preflight passed ({len(runners)} configured).')
        return
    if action == 'restart':
        # Validate all enrollments before changing any process. systemd sends
        # SIGTERM; the runner drains/cancels within its existing shutdown grace.
        for runner in runners:
            subprocess.run(['systemctl', '--user', 'restart', runner['unit']], check=True, timeout=60)
    for runner in runners:
        wait_ready(runner, timeout)


def workspace_storage_report(runner):
    config_path = runner['config'].get('agentWorker', {}).get('workspaceConfig')
    if not config_path:
        return
    root = Path(json.loads(Path(config_path).read_text())['store']) / 'native-conversations'
    if not root.exists():
        return
    if root.is_symlink():
        raise ValueError('workspace native state root must not be a symlink')
    counts = {'READY': 0, 'IN_FLIGHT': 0, 'CLOSED': 0, 'unrecognized': 0}
    for record in (root / 'light-worker-threads').glob('*.json'):
        try:
            state = None if record.is_symlink() else json.loads(record.read_text()).get('state')
        except (OSError, ValueError):
            state = None
        counts[state if state in counts else 'unrecognized'] += 1
    directories, size = 0, 0
    for home in root.iterdir():
        if home.is_symlink() or not home.is_dir() or not re.fullmatch('[0-9a-f]{64}', home.name):
            continue
        directories += 1
        for current, _, files in os.walk(home, followlinks=False):
            for name in files:
                path = Path(current) / name
                try:
                    if not path.is_symlink(): size += path.stat().st_size
                except FileNotFoundError:
                    pass  # A completed standalone turn may remove its private home.
    print(json.dumps(dict(unit=runner['unit'], scope='shared-workspace-store',
        checkpointStates=counts, nativeDirectories=directories, nativeBytes=size,
        filesystemFreeBytes=shutil.disk_usage(root).free, deletionPerformed=False), sort_keys=True))


def storage_report(runner):
    workspace_storage_report(runner)
    home = runner['config'].get('agentWorker', {}).get('claudeHome')
    if not home:
        return
    parent = Path(home).resolve().parent
    counts = {'READY': 0, 'IN_FLIGHT': 0, 'CLOSED': 0, 'unrecognized': 0}
    key = hashlib.sha256(os.fsencode(Path(home).resolve())).hexdigest()
    for path in (parent / ('.light-claude-checkpoints-' + key) / 'light-worker-threads').glob('*.json'):
        if path.is_symlink():
            counts['unrecognized'] += 1
            continue
        try:
            state = json.loads(path.read_text()).get('state')
        except (OSError, ValueError):
            state = None
        counts[state if state in counts else 'unrecognized'] += 1
    size, directories = 0, 0
    # This prefix can contain several Claude homes owned by the same account.
    # Report the combined native footprint without reading transcript contents.
    for root in parent.glob('.light-claude-native-*'):
        if root.is_symlink() or not root.is_dir():
            continue
        directories += 1
        for current, _, files in os.walk(root, followlinks=False):
            for name in files:
                path = Path(current) / name
                if not path.is_symlink():
                    size += path.stat().st_size
    print(json.dumps(dict(unit=runner['unit'], checkpointStates=counts,
        accountNativeDirectories=directories, accountNativeBytes=size,
        filesystemFreeBytes=shutil.disk_usage(home).free, deletionPerformed=False), sort_keys=True))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['preflight', 'restart', 'check', 'storage'])
    parser.add_argument('distribution', type=Path)
    parser.add_argument('--timeout', type=float, default=90)
    args = parser.parse_args()
    if not 0 < args.timeout <= 300:
        parser.error('--timeout must be within (0, 300] seconds')
    try:
        run(args.distribution, args.action, args.timeout)
    except (OSError, ValueError, KeyError, TypeError, yaml.YAMLError, subprocess.SubprocessError) as error:
        message = str(error) if isinstance(error, ValueError) else type(error).__name__
        parser.exit(1, 'Personal runner qualification failed: ' + message + '\n')


if __name__ == '__main__':
    main()
