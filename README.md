# light-portal-install

Local Light Portal deployment with Docker Compose as the only host dependency.

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

The installer downloads refreshed service assets from the Cloudflare R2
`lightapi` bucket and starts the Rust `all-in-lt` stack with `light-agent` and
the local demo APIs.

When run through `curl | bash`, the script bootstraps this repo into
`$HOME/.light-portal` before downloading R2 assets and starting Compose.

By default the script expects public R2 assets under:

```text
https://cdn.networknt.com
https://cdn.networknt.com/light-portal/releases/latest/docker-images.env
```

Override these if the public R2 custom domain changes:

```bash
LIGHT_PORTAL_ASSET_BASE_URL=https://example.com ./install.sh assets
LIGHT_PORTAL_RELEASE_BASE_URL=https://example.com/light-portal/releases ./install.sh assets
```
