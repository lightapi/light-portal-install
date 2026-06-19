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
