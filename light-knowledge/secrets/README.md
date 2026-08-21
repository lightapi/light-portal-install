When the `knowledge` Compose profile is enabled, `install.sh` creates separate
local PostgreSQL login identities for the API, administration service, and
embedded job engine and materializes their URL files. It also generates the
query-cache, opaque-actor, and control-snapshot signing keys.
Provide the externally issued delegation and workload tokens through `.env`;
the installer copies them into mode-0600 runtime-only files. The complete file
set is:

- `knowledge-database-url`
- `knowledge-worker-database-url`
- `knowledge-admin-database-url`
- `agent-delegation-secret`
- `knowledge-query-cache-key`
- `control-snapshot-signing-key`
- `knowledge-admin-opaque-actor-key`
- `knowledge-portal-authorization`
- `knowledge-query-embedding-authorization`
- `knowledge-index-embedding-authorization`
- `knowledge-connector-authorization` (only for a Phase 2 enterprise source)

The installer defaults to protected embeddings and separate `kb_index` and
`kb_query` workload credentials. Repository, immutable commit, ingestion
policy, Knowledge Base, and embedding-space values are resolved from the
projected Portal control plane for each claimed job; they are not worker
configuration. The service rejects a gateway response whose selected space
does not match the selected qualified profile. Do not reuse a standard model lane.
Embedding migrations additionally keep `migrationDeterministicPilot: false`.
The `kb_index` lane must enforce `x-light-maximum-billed-cost-micros` and return
`x-light-billed-cost-micros`; a response without bounded cost evidence is
rejected after the worker has reserved the approved budget.

Do not commit their values. Every Knowledge database URL targets the isolated
`knowledge` database. No Light Knowledge process receives a Config Server
database credential.

`knowledge-query-cache-key` must contain at least 32 random bytes and must be
independent of `agent-delegation-secret`. Rotating it invalidates cache keys
without changing token-verification authority.

The connector credential is source-scoped and least privilege. For SharePoint,
prefer selected-site access where supported; Confluence credentials must be
restricted to the approved site and spaces. Never reuse Portal, delegation,
embedding, or connector credentials across purposes.

The `agent-delegation-secret` value must match
`LIGHT_AGENT_DELEGATION_SECRET`. A delegated UI bearer is forwarded only for
the duration of an operational command and is never persisted. Promotion
receipts commit in the Knowledge database with the generation pointer; the
worker never calls Hybrid Command.

The checked-in `portal-config-dev` and `portal-config-loc` fixtures remain
explicit deterministic pilots. Do not copy their fake 32-dimensional space
into this installer. Embedded executors form a shared job pool: a claimed job resolves a
versioned source/policy/profile snapshot from PostgreSQL, enforces the policy
concurrency ceiling, and rebuilds one complete BASE across every active Git
source in the Knowledge Base. Job leases are renewed while work is running and
expired claims are safely requeued.

Start the protected installer with both `knowledge` and `llm-gateway` Compose
profiles. The image supplies the canonical Knowledge templates, while the
Config Server snapshot supplies deployment-specific overrides. A deliberately
deterministic exercise must use instance-scoped Config Server overrides and
must keep production operations and migrations disabled; it is not release
evidence.
