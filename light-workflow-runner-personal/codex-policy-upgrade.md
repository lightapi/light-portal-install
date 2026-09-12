# Codex personal policy upgrade

Rebuild `light-agent` and `light-agent-worker` from the same Light-Fabric revision.
Retain the qualified Codex 0.153.4 native binary and its existing digest. Install
root-owned `/usr/bin/bwrap` on the personal runner before enabling native permissions.
Regenerate worker, image, capability, adapter-contract, and qualification admission;
the qualification evidence digest now includes `codex-personal-policy-v1`.

Copy [codex-policy.json.example](codex-policy.json.example) into the published source
Agent policy at `agentPolicy.execution.codingProfile.codexPolicy`, choosing exact
models available to the native account. Add `codex-personal-policy-v1` to the
profile's `requiredFeatures`, regenerate its contract digest, and publish the
source policy through the normal workflow. Do not hand-edit generated snapshots.
Omitting `codexPolicy` preserves the existing managed behavior. The extension
applies to immutable-repository `coding` requests, not the separate workspace tool
bridge. Enterprise profiles cannot enable it.

Use `coding.nativeModel` for an explicit workflow model. Omit it on resume to retain
the selected model. Start a new session when changing the model or published policy.
Native configuration reloads on the next invocation; model defaults never silently
switch an existing conversation. Git-ignored source-checkout settings are absent
from bundles. Use owner-installed configuration for reusable settings; staged
project trust is governed by Codex.

`permissionMode: inherit` omits native permission overrides. Only published policy
may select `trusted-personal-unattended`, which requests both no approvals and
full native sandbox authority, still constrained by managed requirements and the
outer worker namespace. It does not expand enterprise permissions. Qualify remote
MCP/tool permissions separately for read-only review; filesystem isolation alone
cannot restrict remote service mutations.

From the Light-Fabric source checkout, run:

```bash
python3 scripts/test-codex-personal-config.py --codex /absolute/path/to/codex
python3 scripts/run-coding-thread-smoke.py --codex /absolute/path/to/codex \
  --personal-policy inherit --model gpt-6-astra
```

The second command consumes native plan usage and tests separate worker processes,
context and patch continuity, explicit model selection, and a changed local default.
Repeat with `--personal-policy trusted-personal-unattended` before using that mode.
A failed, skipped, or timed-out live gate is unqualified. Existing workflow leases,
owner/host binding, artifact review/publication, and uncertain-operation fencing
remain in force. Rebuild and restart affected services using this distribution's
normal deployment process, and begin fresh coding sessions.

See the [full worker contract](https://github.com/networknt/light-fabric/blob/master/docs/src/product/light-agent-worker/codex-personal-policy.md).
