#!/usr/bin/env python3
"""Prepare an owner-scoped Claude runner. Tokens are supplied by the local issuer.

No login credentials are copied. Outputs are deterministic apart from supplied
identities; existing execution journals and native conversations are preserved.
"""
import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import time
import yaml


def digest(data):
    return 'sha256:' + hashlib.sha256(data).hexdigest()


def canonical(value):
    return digest(json.dumps(value, sort_keys=True, separators=(',', ':')).encode())


def private(path, value):
    path.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(descriptor, 'w') as stream:
        stream.write(value)
    path.chmod(0o600)


def claims(path):
    token = path.read_text().strip().removeprefix('Bearer ')
    data = json.loads(base64.urlsafe_b64decode(token.split('.')[1] + '=='))
    if data.get('exp', 0) <= time.time() + 300:
        raise ValueError('Renew the supplied local token before setup')
    return token, data


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--fabric', type=Path, required=True)
    parser.add_argument('--native-home', type=Path, required=True)
    parser.add_argument('--claude', type=Path, required=True)
    parser.add_argument('--runner-jwt', type=Path, required=True)
    parser.add_argument('--service-jwt', type=Path, required=True)
    parser.add_argument('--instance-id', required=True)
    parser.add_argument('--host-id', default='01964b05-552a-7c4b-9184-6857e7f3dc5f')
    parser.add_argument('--controller-url', default='wss://localhost:8438/ws/runner')
    parser.add_argument('--ca', type=Path, required=True)
    parser.add_argument('--permission-mode', choices=['inherit', 'dontAsk', 'bypassPermissions'], default='inherit')
    parser.add_argument('--install-user-service', action='store_true')
    parser.add_argument('--workspace-config', type=Path, help='Owner-only RunnerWorkspaceConfig; store is shared with the Codex runner')
    args = parser.parse_args()
    root = Path(__file__).resolve().parent
    runtime = root / '.runtime'
    runtime.mkdir(mode=0o700, exist_ok=True)
    runtime.chmod(0o700)
    fabric = args.fabric.resolve()
    native = args.claude.resolve(strict=True)
    # The phase2 contract deliberately pins the native binary independently of PATH.
    pin = 'sha256:25e44883f54419569a3d739f38cbbdaebe83b09895da0f343e1b003710a4775b'
    if digest(native.read_bytes()) != pin:
        raise ValueError('Native Claude binary differs from qualified 2.1.269 pin')
    subprocess.run(['/usr/bin/bwrap', '--ro-bind', '/', '/', '--', '/usr/bin/true'], check=True)
    runner_id = 'personal-claude-runner'
    service = 'com.networknt.agent.claude-personal-1.0.0'
    token, rc = claims(args.runner_jwt)
    stoken, sc = claims(args.service_jwt)
    if (rc.get('runner_id') != runner_id or rc.get('host') != args.host_id
            or rc.get('enrollment_id') != runner_id + '-enrollment'
            or rc.get('sub') != 'urn:lightapi:runner:' + runner_id
            or rc.get('aud') != 'urn:lightapi:runner' or 'runner.connect' not in rc.get('scp', [])):
        raise ValueError('Runner token identity/scope does not match Claude enrollment')
    if sc.get('sid') != service or sc.get('host') != args.host_id or 'execution.invoke' not in sc.get('scp', []):
        raise ValueError('Service token must bind the Claude service and execution.invoke')
    private(runtime / 'runner.jwt', token + '\n')
    private(runtime / 'service.jwt', stoken + '\n')
    # Parent is 0700; the non-root container can read only this bind-mounted file.
    (runtime / 'service.jwt').chmod(0o644)
    # Content-addressed installation avoids overwriting binaries used by live sessions.
    installed = {}
    for name in ['light-workflow-runner', 'light-claude-worker']:
        source = fabric / 'target/debug' / name
        identity = digest(source.read_bytes()).split(':')[1]
        destination = runtime / 'bin' / identity / name
        destination.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
        if not destination.exists():
            shutil.copyfile(source, destination)
            destination.chmod(0o700)
        installed[name] = destination
    runner, worker = installed['light-workflow-runner'], installed['light-claude-worker']
    caps = json.loads(subprocess.check_output([str(worker), 'print-capabilities']))
    if caps['capabilities']['adapterId'] != 'claude-code-v1':
        raise ValueError('Expected the dedicated Claude worker')
    template = dict(name='personal-claude-worker-v1', executable=str(worker),
                    binaryDigest=digest(worker.read_bytes()), capabilityDigest=caps['capabilityDigest'])
    template_digest = canonical(template)
    config = dict(version=1, runnerId=runner_id, enrollmentId=runner_id+'-enrollment', hostId=args.host_id,
        controllerUrl=args.controller_url, jwtFile=str(runtime/'runner.jwt'), dataDirectory=str(runtime/'data'),
        healthAddress='127.0.0.1:9445', maximumConcurrency=1, heartbeatIntervalMs=5000, reconnectMaximumMs=30000,
        shutdownGraceMs=29000, stagingMaximumBytes=1073741824, orphanReconcileIntervalMs=60000,
        orphanReconcileStartupTimeoutMs=30000,
        backend=dict(compatibilityDigest=template_digest, availableSlots=1,
            behavior=dict(durationMs=10, stdout='', stderr='', exitCode=0, outcome='success', loseFirstResponse=False, cleanupFails=False)),
        allowedCommandTemplateDigests=[template_digest],
        agentWorker=dict(originServiceId=service, executable=str(worker), binaryDigest=template['binaryDigest'],
            capabilityDigest=caps['capabilityDigest'], claudeHome=str(args.native_home.resolve()), claudeExecutable=str(native)))
    workspace_config = args.workspace_config
    if workspace_config is None and (runtime/'runner.yml').exists():
        previous = yaml.safe_load((runtime/'runner.yml').read_text())
        if previous.get('agentWorker', {}).get('workspaceConfig'):
            workspace_config = Path(previous['agentWorker']['workspaceConfig'])
    bindings = []
    if workspace_config is not None:
        workspace_config = workspace_config.resolve(strict=True)
        workspace = json.loads(workspace_config.read_text())
        bindings = workspace['bindings']
        if not bindings or any(b['runnerId'] != runner_id or b['hostId'] != args.host_id or service not in b['agents'] for b in bindings):
            raise ValueError('Workspace bindings must select this Claude runner, Host, and Agent')
        config['agentWorker']['workspaceConfig'] = str(workspace_config)
    private(runtime/'runner.yml', yaml.safe_dump(config, sort_keys=False))
    env = dict(os.environ, LIGHT_WORKFLOW_RUNNER_CONFIG_FILE=str(runtime/'runner.yml'))
    admission = json.loads(subprocess.check_output([str(runner), 'print-admission', 'urn:lightapi:runner:'+runner_id, 'light-workflow'], env=env))
    private(runtime/'admission.json', json.dumps(admission, indent=2)+'\n')
    spool = runtime/'repositories'; spool.mkdir(exist_ok=True, mode=0o700)
    contract = dict(schemaVersion=1, adapterId='claude-code-v1', adapterVersion='2.1.269',
        adapterProtocolVersion='claude-cli-stream-json-v1', actionKind='coding.claude-code-v1',
        compatibilityDigest=template_digest, imageDigest=template['binaryDigest'], capabilityDigest=caps['capabilityDigest'],
        templateId='coding-claude-code-v1', templateVersion=1, templateDigest=template_digest,
        executable='/usr/local/bin/claude', binaryDigest=pin,
        schemaDigest=digest((fabric/'contracts/claude-code/v2.1.269/phase2-launch.json').read_bytes()),
        requiredFeatures=sorted(['claude-code-v1','canonical-patch-output','workflow-coding-threads-v1','claude-review-namespace-v1']))
    evidence = fabric/'contracts/claude-code/v2.1.269/phase2-qualification.json'
    identity = dict(hostId=args.host_id, runtimeInstanceId=args.instance_id, serviceId=service, envTag='dev')
    profile = dict(contract, productProfileDigest=canonical(identity), repositoryUriPrefix=spool.as_uri()+'/',
        model='coding-implementer', reviewModel='coding-reviewer', authenticationProfile='personal-subscription', enterpriseGateway=None,
        claudePolicy=dict(permissionSource='claude-cli', permissionMode=args.permission_mode, defaultModel='sonnet',
            models={'sonnet':'claude-sonnet-5'}, tools=[], allowedTools=[]),
        qualification=dict(schemaVersion=1, adapterId='claude-code-v1', adapterVersion='2.1.269',status='local-qualified',
            evaluatedDimensions=sorted(json.loads(evidence.read_text())['dimensions']), contractDigest=canonical(contract), evidenceDigest=digest(evidence.read_bytes())))
    if bindings:
        profile['workspaceBindings'] = bindings
    private(runtime/'coding-profile.json', json.dumps(profile, indent=2)+'\n')
    unit = f'''[Unit]
Description=Light Claude personal runner
After=network-online.target
[Service]
Type=simple
Environment="LIGHT_WORKFLOW_RUNNER_CONFIG_FILE={runtime}/runner.yml"
Environment="SSL_CERT_FILE={args.ca.resolve()}"
ExecStart={runner}
Restart=on-failure
RestartSec=5
TimeoutStopSec=35
UMask=0077
[Install]
WantedBy=default.target
'''
    private(runtime/'light-workflow-runner-claude-personal.service', unit)
    if args.install_user_service:
        target = Path.home()/'.config/systemd/user/light-workflow-runner-claude-personal.service'
        private(target, unit)
        subprocess.run(['systemctl','--user','daemon-reload'],check=True)
        subprocess.run(['systemctl','--user','enable',target.name],check=True)
    print('Prepared Claude runner and server-owned coding profile:', runtime)
    print('Publish coding-profile.json through Portal, then use the normal deployment restart.')

if __name__ == '__main__':
    main()
