Provide these runtime-only files before enabling the `knowledge` Compose profile:

- `knowledge-database-url`
- `knowledge-worker-database-url`
- `knowledge-projector-database-url`
- `agent-delegation-secret`
- `knowledge-heartbeat-secret`
- `knowledge-portal-authorization`

Protected embedding qualification also requires separate `kb_index` and
`kb_query` workload credentials. Point `embeddingAuthorizationFile` in the
worker and API configs at their respective runtime-only files when
`deterministicPilot` is set to `false`; do not reuse a standard model lane.

Do not commit their values. The three database identities must use the API,
worker, and projector roles created by the Phase 1a schema.

The `agent-delegation-secret` value must match
`LIGHT_AGENT_DELEGATION_SECRET`. The bearer token stored in
`knowledge-portal-authorization` must have a `sub` included in
`KNOWLEDGE_WORKLOAD_PRINCIPALS`; the local default principal is
`light-knowledge-worker`. Promotion acknowledgements do not require an
end-user tenant or platform-admin role: the allowlisted workload identity and
the exact pending-outbox generation, pointer, and evidence digest authorize the
operation.
