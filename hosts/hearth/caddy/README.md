# Caddy with Cloudflare DNS

This package pins Caddy and its Go dependencies separately from Nixpkgs.
Nixpkgs still supplies the Go compiler. `main.go` loads the standard Caddy
modules and the Cloudflare DNS module.

The daily workflow runs `update.py` after `nix flake update`. It follows the
Caddy version in `nixpkgs-stable`, uses that input's Go compiler, and refreshes
`go.mod`, `go.sum`, and `sources.json`. It builds and checks Caddy before
creating the update commit. All five host builds must pass before CI pushes it.

To update locally, run `python3 hosts/hearth/caddy/update.py` from the repo root,
then build `.#nixosConfigurations.hearth.config.services.caddy.package` on Linux.
Commit the generated files with `flake.lock`.

Cloudflare stays pinned to `cloudflareVersion` in `sources.json`. Edit that
field and run the updater to change it. Other Go libraries follow the versions
required by Caddy and Cloudflare; the updater does not upgrade them independently.
