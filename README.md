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

On install, update, and start, the script first starts Postgres plus
`hybrid-command` and `hybrid-query`, imports `events.json` when `event_store_t`
is empty, and then starts the full Compose stack. This avoids the first-run
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

## Reinstall from scratch

The following procedure permanently deletes the existing PostgreSQL data,
imported events, downloaded assets, and local installation files. For an
installation created with `curl | bash`, first stop the stack and remove its
Docker Compose volumes:

```bash
cd "$HOME/.light-portal"
./install.sh uninstall
```

When prompted to delete the Docker volumes, enter `y`. After the uninstall
finishes, leave the installation directory, delete it, and run the installer
again:

```bash
cd "$HOME"
rm -rf "$HOME/.light-portal"
curl -fsSL https://raw.githubusercontent.com/lightapi/light-portal-install/master/install.sh | bash
```

For a checked-out repository that you want to keep, do not delete the
repository. Use `CLEAN_VOLUMES=true ./install.sh install` from the repository
instead; it removes the Compose volumes, downloads fresh assets, recreates the
database, and imports the baseline `events.json` again.

To force a fresh database and re-import `events.json`, run with
`CLEAN_VOLUMES=true`. This stops the stack, deletes the Compose volumes, starts
Postgres and the event processors again, and imports the downloaded events into
the recreated database after Postgres accepts TCP connections:

```bash
cd "$HOME/.light-portal"
CLEAN_VOLUMES=true ./install.sh start
```

Use the same flag with `install` or `update` when you also want to refresh the
downloaded assets first.

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
