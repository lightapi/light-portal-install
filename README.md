# light-portal-install

Local Light Portal deployment with Docker Compose as the only host dependency.
The installer also uses standard `curl`, `tar`, and `unzip` utilities to
bootstrap the repo and extract downloaded asset archives.

```bash
curl -fsSL https://raw.githubusercontent.com/lightapi/light-portal-install/master/install.sh | bash
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
`light-agent` and the local demo APIs.

On install, update, and start, the script first starts Postgres plus
`hybrid-command` and `hybrid-query`, imports `events.json` when `event_store_t`
is empty, and then starts the full Compose stack. This avoids the first-run
dependency loop where `light-oauth` cannot serve JWKS until the OAuth key data
has been imported.

On Silverblue/Podman, the event import streams `events.json` over stdin instead
of bind-mounting it into the importer container. This avoids SELinux mount
label issues that can make `/events/events.json` unreadable inside Java.

When run through `curl | bash`, the script bootstraps this repo into
`$HOME/.light-portal` before downloading and extracting R2 assets and starting
Compose.

By default the script expects public R2 assets under:

```text
https://cdn.networknt.com
https://cdn.networknt.com/light-portal/releases/latest/docker-images.env
```

The asset archive names are:

```text
hybrid-command.zip
hybrid-query.zip
lightapi.zip
signin.zip
events.zip
```

Override these if the public R2 custom domain changes:

```bash
LIGHT_PORTAL_ASSET_BASE_URL=https://example.com ./install.sh assets
LIGHT_PORTAL_RELEASE_BASE_URL=https://example.com/light-portal/releases ./install.sh assets
```

Set `IMPORT_EVENTS=false` only when you intentionally want to skip the
bootstrap import.
