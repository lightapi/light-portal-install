# Claude personal runner in the installer

This distribution includes the same `setup.py` and native runner contract as
`portal-config-loc/all-in-lt/light-workflow-runner-claude-personal`. Follow that
setup guide with this directory as the working directory and the installer's
`../light-controller-rust/ca.pem`. Supply the exact published instance identity
and local issuer credentials. Native Claude login stays on the host.

All services, including `light-agent-claude-personal` (loopback port 8090) and
standalone `light-a2a`, are selected by the base `docker-compose.yml` without
Compose profiles. Use normal `install.sh` commands; no profile selection is needed.
After `.runtime/runner.yml` exists, the installer automatically adds the tracked
Controller admission configuration from `controller.compose.yml`. This overlay
contains Controller settings only, not optional services. Enrollment credentials,
compatible images, and activated Portal policies remain full-stack prerequisites.
The standalone A2A image/configuration blocker is tracked in
[portal-config-loc #351](https://github.com/lightapi/portal-config-loc/issues/351).

Build the native Rust worker, runner, and local Claude Agent image with
`light-fabric/scripts/build-claude-personal-local.sh`. Build Java publishers through
their normal build/release pipeline, including the updated `light-portal` dependency,
and select their images with `PORTAL_HYBRID_COMMAND_IMAGE` and
`PORTAL_HYBRID_QUERY_IMAGE`.
Publish `.runtime/coding-profile.json` through Portal before starting the Agent.
The setup helper installs/enables the native user service. `install.sh` preflights configured runners before `up` operations and regenerates
admission from the installed binaries. After the complete stack starts, it
restarts the configured runners and requires healthy Controller connectivity plus
the installed process/backend identity. Partial database/OAuth bootstrap steps
do not restart runners or wait for an unavailable Controller. Private state is
retained across container recreation.

Only one local distribution should own the fixed container names and ports at a
time. For service configuration qualification against an already running local
stack, the installer Agent can use that same published Host, native enrollment,
and owner-only runtime directory; `.runtime` may point to that existing runtime.
This tests the installer Agent service against shared infrastructure and does not
claim a clean-room full installer bootstrap.

Run `light-fabric/scripts/run-claude-deployment-smoke.py` with the selected runtime
after deployment. The same six-step, independent review, durable receipt, and
zero gateway-audit checks apply. Production subscription/distribution eligibility
remains an independent gate; this is explicitly local technical qualification.

Run the same diagnostics from the installer root:

```bash
python3 scripts/personal-runner-lifecycle.py preflight .
python3 scripts/personal-runner-lifecycle.py check . --timeout 90
python3 scripts/personal-runner-lifecycle.py storage .
```

Follow the local runner guide's upgrade, credential-renewal, retention and fixed
validation procedures. Finish active sessions before updating policy. An active
old service is explicitly restarted by `install.sh start`/`update` after full
stack startup; it cannot satisfy readiness using an old compatibility digest.
The unit's existing shutdown grace controls drain/cancellation.

Fresh installer qualification still requires an isolated installation with its
own initialized database, issuer credentials, published Agent policy, images and
host enrollment. The service-layout smoke against shared local infrastructure
is not evidence of that bootstrap. Do not run uninstall or volume removal against
the existing all-in-lt stack to simulate a clean install.

## Shared workspace enrollment

Pass `setup.py --workspace-config /private/path/workspace.json` to enable the
runner-owned task workspace tools. Later setup runs preserve this setting when
omitted. Use the same workspace store as the Codex personal runner, while keeping
separate runner IDs and native conversation homes. The workspace registration must
grant both Agent service IDs. Publish the generated profile's `workspaceBindings`
and a new Agent policy snapshot before restarting. Existing snapshots are immutable.
Inspect/review are read-only; implementation edits use file digest preconditions.
The shared task tool facade does not mount the checkout into Claude's namespace.
See light-fabric's `shared-native-coding-sessions.md` for lifecycle and qualification.
