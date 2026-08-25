# light-portal-install

Local Light Portal deployment with Docker Compose as the only host dependency.
The installer also uses standard `curl`, `tar`, and `unzip` utilities to
bootstrap the repo and extract downloaded asset archives.

```bash
curl -fsSL https://raw.githubusercontent.com/lightapi/light-portal-install/master/install.sh | bash
```

Once the installation is complete, open your web browser and navigate to
`https://local.localhost` to access the dashboard. This local deployment uses a
self-signed TLS certificate, so your browser may display a privacy or security
warning the first time you open the site. This warning is expected for the
local installation. Choose the browser's advanced option and continue to
`local.localhost` (the exact wording varies by browser). Only bypass this
warning for this local address.

To sign in, click the user icon in the bottom-left corner of the page. The
default username and password are:

```
steve.hu@lightapi.net/123456
```

For a checked-out repo:

```bash
./install.sh install
./install.sh status
./install.sh logs
./install.sh stop
```

The installer downloads refreshed service assets from compressed Cloudflare R2
archives in the `lightapi` bucket and starts the Rust `all-in-lt` stack with
`light-agent`, the local demo REST APIs, and the insurance claim MCP server.

## Light Knowledge services

The installer always starts the `light-knowledge` API, the private
`light-knowledge-admin` service, and `light-knowledge-worker`, including bounded uploads,
multi-KB retrieval, and the MCP adapter. Fresh PostgreSQL volumes apply the
Portal catalog to the `configserver` schema in the `configserver` database and
the Knowledge model to the `knowledge` schema in the `knowledge` database. The
`public` schema in each database contains only extension objects and does not
accept application object creation. Runtime roles own the search paths, so
service URLs do not carry schema query parameters. The bundled
embedding-space/profile prerequisites and the Phase 0 through Phase 3 schema
are rendered into `knowledge`.
Installations created before this topology was introduced must use the
`CLEAN_VOLUMES=true` reinstall procedure below; the installer does not move
existing application tables out of `public` in place.
Production promotion still
requires the environment-dependent Phase 2 and Phase 3 qualification evidence;
these local/development feature flags do not waive that gate.

Before starting the stack, populate any environment-specific runtime values
listed in `light-knowledge/secrets/README.md`. On first start, the installer
generates the shared Light Agent delegation secret, stores it with mode `0600`
in `.env`, stores the mounted copy with group-read-only mode `0640` in
`light-knowledge/secrets/agent-delegation-secret`, and reuses it on later
starts. Set `LIGHT_AGENT_DELEGATION_SECRET` before starting only to provide an
explicit secret-manager value; the installer persists that override to keep
both consumers synchronized. The installer also records its primary group as
`LIGHT_PORTAL_SECRET_GID`, allowing the non-root Knowledge containers to read
only their bind-mounted secrets without making those files world-readable. The
three database URLs must use login
identities that inherit the API, worker, and Portal-projector roles extended by
the Phase 2 schema. SharePoint and
Confluence workers use a source-scoped `enterpriseConnectorPageUrl`, an
external bearer secret, and the provider `enterpriseConnectorApprovedOrigin`.
Notifications enqueue independent priority ACL and bulk content reconciliation;
they never authorize retrieval or advance a cursor by themselves. The bundled
operational migration adds transition audit, ACL-mode fencing, sustainable
FULL/DELTA freshness, and atomic cursor/promotion enforcement.
The Phase 3 migration adds budgeted embedding migration, candidate isolation,
watermark fencing, retention/legal-hold accounting, scheduled anti-entropy and
checkpoint requests, restore-verification metadata, and purge evidence. Its
feature switches remain disabled until live migration, backup/restore,
large-corpus, and horizontal-worker qualification passes.

Start the Knowledge services with the rest of the installer stack:

```bash
./install.sh start
```

The deterministic pilot configuration is enabled by default. Production
qualification must replace the shared development credential with separate
protected `kb_index` and `kb_query` credentials and the qualified
embedding-space contract. Existing
volumes must receive the same schema through the normal versioned release-patch
process; the `postgres-db/zy-*.sql` and `postgres-db/zz-*.sql` files run only
during PostgreSQL initialization of a fresh volume.

## Dedicated LLM Gateway

The installation always runs a dedicated `llm-gateway` from the
`networknt/light-gateway` image because the Knowledge worker depends on it.
Provider routes become usable when their corresponding credentials are configured. It uses
`serviceId=com.networknt.llm.gateway-1.0.0` with `envTag=dev`, sharing the
same development instance configuration as `portal-config-loc` and
`portal-config-dev`. The deployment remains identifiable as the demo install;
only the LLM configuration tag is shared.

The gateway listens at `https://localhost:8444` by default. Copy
`.env.example` to `.env` and add the provider keys you want to exercise:

```dotenv
GROQ_API_KEY=...
GEMINI_API_KEY=...
```

The bundled development service token is suitable only for this local
evaluation stack. Override it through
`LLM_GATEWAY_LIGHT_PORTAL_AUTHORIZATION` when needed; the token must carry
`sid=com.networknt.llm.gateway-1.0.0`. The port can be changed with
`LLM_GATEWAY_HOST_PORT`, and the service image can be overridden independently
with `LLM_GATEWAY_IMAGE`. `LLM_GATEWAY_RUST_LOG` overrides the shared
`RUST_LOG` setting for this service.

An authenticated `GET https://localhost:8444/v1/models` lists the configured
models. The provider keys are optional for the overall Portal installation. If
either key is missing, `install.sh` leaves the dedicated LLM gateway disabled
while starting the remaining services normally.

On install, update, and start, the script first starts Postgres plus
`hybrid-command` and `hybrid-query`, imports `events.json` when `event_store_t`
is empty, automatically using the importer's guarded bootstrap mode, and then
starts the full Compose stack. This avoids the first-run
dependency loop where `light-oauth` cannot serve JWKS until the OAuth key data
has been imported.

On Silverblue/Podman, the event import streams `events.json` over stdin instead
of bind-mounting it into the importer container. This avoids SELinux mount
label issues that can make `/events/events.json` unreadable inside Java.

Before import, the installer normalizes the exported portal OAuth client
redirect URI from `https://localhost:3000/authorization` to
`https://local.localhost/authorization`. Override the installed redirect URI
when needed:

```bash
LIGHT_PORTAL_CLIENT_REDIRECT_URI=https://example.local/authorization ./install.sh install
```

The installer also normalizes downloaded portal UI assets so the local signin
link uses employee login (`user_type=E`) instead of the customer login default.

When run through `curl | bash`, the script bootstraps this repo into
`$HOME/.light-portal` before downloading and extracting R2 assets and starting
Compose.

To stop the Compose stack after installing with `curl | bash`, run the stop
command from the bootstrapped install directory:

```bash
cd "$HOME/.light-portal"
./install.sh stop
```

## Refresh runtime assets

To replace the installed hybrid service JARs, portal UI, signin UI, and
`events.json` with the current assets from the CDN, stop the stack, refresh the
assets, and start it again:

```bash
cd "$HOME/.light-portal"
./install.sh stop
./install.sh assets
./install.sh start
```

The `assets` command downloads and replaces these release archives regardless
of whether the destination directories already contain files:

```text
hybrid-command.zip
hybrid-query.zip
lightapi.zip
signin.zip
events.zip
```

This procedure preserves the existing Docker volumes and database. For a
checked-out repository, run the same commands from the repository root. To use
a different asset host, set `LIGHT_PORTAL_ASSET_BASE_URL` on the `assets`
command:

```bash
LIGHT_PORTAL_ASSET_BASE_URL=https://example.com ./install.sh assets
```

## Reinstall from scratch

Deleting `$HOME/.light-portal` does **not** delete the database. PostgreSQL data
is stored in the Docker Compose `postgres-data` named volume, which exists
outside the installation directory.

To recreate the database while keeping the installed directory, use the
following recommended command:

```bash
cd "$HOME/.light-portal"
CLEAN_VOLUMES=true ./install.sh install
```

This permanently deletes the PostgreSQL volume, downloads fresh release
assets, recreates the dedicated Config Server and Knowledge databases, and imports the
baseline `events.json` again. Use the same command from the repository root for
a checked-out installation that you want to keep. The installer adds a fresh
cache-busting query to the `events.zip` request so a newly recreated database
cannot receive an older cached baseline after a release.

If the downloaded assets are already current and only the database needs to be
recreated, use:

```bash
cd "$HOME/.light-portal"
CLEAN_VOLUMES=true ./install.sh start
```

For a complete reinstall that also removes downloaded assets and local
installation files, first stop the stack and delete its Docker Compose volumes:

```bash
cd "$HOME/.light-portal"
./install.sh uninstall
```

When prompted to delete the Docker volumes, enter `y`. If you answer `n` or
skip this step, the next installation will reuse the existing database even if
`$HOME/.light-portal` is deleted. After the uninstall finishes, leave the
installation directory, delete it, and run the installer again:

```bash
cd "$HOME"
rm -rf "$HOME/.light-portal"
curl -fsSL https://raw.githubusercontent.com/lightapi/light-portal-install/master/install.sh | bash
```

`CLEAN_VOLUMES=true` stops the stack with `docker compose down -v`, starts
Postgres and the event processors again, and imports the downloaded events
after Postgres accepts TCP connections. The flag can also be used with
`update`. No event-importer command-line switch is required.
The fallback event import reports success when the event, outbox, and
notification rows are durable; projection and DLQ handling continue
asynchronously. The installer then waits for the `user-query-group` consumer
cursor before starting OAuth because OAuth reads projected key data. This is a
deployment readiness check, not part of event import, and it does not inspect
the DLQ.

Fresh installs prefer a release-matched `portal-bootstrap.dump` when the signed
release manifest publishes one. Archive restore is fail-closed: the installer
verifies the detached manifest signature, archive and `events.json` digests,
PostgreSQL major version, schema digest, canonical table checksums, singleton
UUIDv7 transactions, offsets, graph convergence, grants, and planner statistics.
It restores with ownership and ACL data disabled and starts no OAuth listener
until the bundled rotation hook has replaced every disabled credential
placeholder. Set `LIGHT_PORTAL_BOOTSTRAP_PUBLIC_KEY` to the pinned PEM release
key. The hook writes installation-unique, mode-0600 one-time delivery files to
`bootstrap/secrets/`; deployments may override it with
`LIGHT_PORTAL_BOOTSTRAP_CREDENTIAL_ROTATION_HOOK`. If any archive gate fails,
the script recreates the empty
`configserver` database and falls back to direct event-table import from
`events.json`.

Physical chunking is independently reversible. It defaults to one physical
commit per 500 events (`EVENT_IMPORT_PHYSICAL_CHUNK_EVENTS=500`, also the hard
maximum); every event still receives its own UUIDv7 transaction ID with ordinal
0 and count 1. Set `EVENT_IMPORT_PHYSICAL_CHUNKING_DISABLED=true` only when
diagnosing or comparing the legacy one-commit-per-event path.

By default the script expects public R2 assets under:

```text
https://cdn.networknt.com
https://cdn.networknt.com/light-portal/releases/latest/docker-images.env
```

The demo service images can be overridden with `DEMO_CUSTOMER_PROFILE_API_IMAGE`,
`DEMO_OFFER_DECISION_API_IMAGE`, and
`DEMO_INSURANCE_CLAIM_MCP_SERVER_IMAGE`.

The asset archive names are:

```text
hybrid-command.zip
hybrid-query.zip
lightapi.zip
signin.zip
events.zip
```

For existing installs, `./install.sh update` also downloads the release
artifacts from `light-portal/releases/<version>/`:

```text
manifest.json
db-patches.zip
event-deltas.zip
```

It applies SQL patches and imports event delta files once, tracking checksums
in `portal_schema_patch_t` and `portal_event_delta_t`. This is the normal
upgrade path when you want to keep the existing database. Use
`CLEAN_VOLUMES=true` only when you intentionally want to recreate the database
and re-import the full baseline `events.json`.

New event deltas are recorded only after their requested aggregate versions
are represented by the exact event or an equivalent payload effect at that or
a later version. Release packages can also list an immutable broken delta in
`events/deltas/superseded-deltas.list` and supply a later replacement. The
replacement must reproduce the complete intended effect so preserved
installations and fresh rebuilds converge.

Override these if the public R2 custom domain changes:

```bash
LIGHT_PORTAL_ASSET_BASE_URL=https://example.com ./install.sh assets
LIGHT_PORTAL_RELEASE_BASE_URL=https://example.com/light-portal/releases ./install.sh assets
```

Set `IMPORT_EVENTS=false` only when you intentionally want to skip the
bootstrap import.
# Instance clone rollout

The development install stack ships instance clone enabled in both hybrid
processes with a committed development-only fallback key. Copy `.env.example`
to `.env` and override it for any shared or externally reachable environment:

```dotenv
INSTANCE_CLONE_PLAN_HMAC_KEY=<secret-from-vault>
INSTANCE_CLONE_PLAN_HMAC_KEY_ID=v1
```

Never commit the populated `.env`, print a real key in compose output, or store
it in a portal configuration snapshot. Command and query must use the same key
and key identifier.

Each service has one `LIGHT_PORTAL_AUTHORIZATION` token for its own identity.
When `light-gateway` invokes `light-workflow`, it sends its existing token in
`X-Scope-Token` while preserving the original user JWT in `Authorization`.
`light-workflow` uses its own independent token for downstream API calls.

Light Workflow uses `light-workflow-rust/config/startup.yml` to select the demo
Portal/config instance and stores only its validated, identity-bound
last-known-good configuration in the `light-workflow-config-cache` volume.
After the Phase 1a Portal events are imported, create and promote its first
snapshot with `./light-workflow-rust/publish-current-snapshot.sh`.

The publisher prints the previous snapshot ID. Restore a previously reviewed
snapshot with
`./light-workflow-rust/rollback-current-snapshot.sh <previous-snapshot-id>`,
then use Portal Control Pane **Modules** to reload only
`light-workflow/runtime-config`. Restart the service instead when the review
contains restart-required changes. `LIGHT_WORKFLOW_SNAPSHOT_DRY_RUN=true`
validates either snapshot transaction without committing it.
