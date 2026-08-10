Provide these runtime-only files before enabling the `knowledge` Compose profile:

- `knowledge-database-url`
- `knowledge-worker-database-url`
- `knowledge-projector-database-url`
- `agent-delegation-secret`
- `knowledge-query-cache-key`
- `knowledge-heartbeat-secret`
- `knowledge-portal-authorization`
- `knowledge-query-embedding-authorization`
- `knowledge-index-embedding-authorization`
- `knowledge-connector-authorization` (only for a Phase 2 enterprise source)

The installer defaults to protected embeddings and separate `kb_index` and
`kb_query` workload credentials. Replace the operator-assigned embedding-space
identifier, revision, and dimension in both configs with one qualified gateway
contract before starting the profile. The service rejects a gateway response
whose selected space does not match. Do not reuse a standard model lane.
Embedding migrations additionally keep `migrationDeterministicPilot: false`.
The `kb_index` lane must enforce `x-light-maximum-billed-cost-micros` and return
`x-light-billed-cost-micros`; a response without bounded cost evidence is
rejected after the worker has reserved the approved budget.

Do not commit their values. The three database identities must use the API,
worker, and projector roles created by the Phase 2 schema.

`knowledge-query-cache-key` must contain at least 32 random bytes and must be
independent of `agent-delegation-secret`. Rotating it invalidates cache keys
without changing token-verification authority.

The connector credential is source-scoped and least privilege. For SharePoint,
prefer selected-site access where supported; Confluence credentials must be
restricted to the approved site and spaces. Never reuse Portal, delegation,
embedding, or connector credentials across purposes.

The `agent-delegation-secret` value must match
`LIGHT_AGENT_DELEGATION_SECRET`. The bearer token stored in
`knowledge-portal-authorization` must have a `sub` included in
`KNOWLEDGE_WORKLOAD_PRINCIPALS`; the local default principal is
`light-knowledge-worker`. Promotion acknowledgements do not require an
end-user tenant or platform-admin role: the allowlisted workload identity and
the exact pending-outbox generation, pointer, and evidence digest authorize the
operation.

The checked-in `portal-config-dev` and `portal-config-loc` fixtures remain
explicit deterministic pilots. Do not copy their fake 32-dimensional space
into this installer. A builder instance is a declared shard for the configured
`knowledgeBaseId` and `sourceId`; run one shard per identity pair. Job leases
are renewed while work is running and expired claims are safely requeued.

Start the protected installer with both `knowledge` and `llm-gateway` Compose
profiles. For a deliberately local deterministic exercise only, set
`LIGHT_KNOWLEDGE_CONFIG_FILE=/config/knowledge-pilot.yml` and
`LIGHT_KNOWLEDGE_WORKER_CONFIG_FILE=/config/worker-pilot.yml`. The pilot files
keep production operations and migrations disabled and are not release
evidence.
