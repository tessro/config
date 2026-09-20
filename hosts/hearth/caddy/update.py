#!/usr/bin/env python3
"""Follow stable Nixpkgs' Caddy release; keep Cloudflare explicitly pinned."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile


def run(*args, cwd=None):
    return subprocess.check_output(args, cwd=cwd, text=True).strip()


def main():
    package = Path(__file__).resolve().parent
    root = package.parents[2]
    sources_path = package / "sources.json"
    sources = json.loads(sources_path.read_text())
    # Read the input from flake.lock, not the channel or a global Nix registry.
    nixpkgs = run(
        "nix",
        "eval",
        "--impure",
        "--raw",
        "--expr",
        f"(builtins.getFlake {json.dumps(str(root))}).inputs.nixpkgs-stable.outPath",
    )
    version = run("nix", "eval", "--raw", f"{nixpkgs}#caddy.version")
    if version != sources["version"]:
        fetched = json.loads(
            run(
                "nix",
                "store",
                "prefetch-file",
                "--json",
                "--unpack",
                f"https://github.com/caddyserver/dist/archive/refs/tags/v{version}.tar.gz",
            )
        )
        sources["distHash"] = fetched["hash"]
    sources["version"] = version

    # Generate dependencies outside the checkout; failures leave it unchanged.
    with tempfile.TemporaryDirectory(prefix="caddy-update-") as work:
        work = Path(work)
        for name in ("main.go", "go.mod", "go.sum"):
            shutil.copyfile(package / name, work / name)

        def go(*args):
            return run(
                "nix", "shell", f"{nixpkgs}#go", "--command", "go", *args, cwd=work
            )

        go(
            "get",
            f"github.com/caddyserver/caddy/v2@v{version}",
            f"github.com/caddy-dns/cloudflare@{sources['cloudflareVersion']}",
        )
        go("mod", "tidy")
        go("mod", "vendor")
        sources["vendorHash"] = run("nix", "hash", "path", str(work / "vendor"))
        for name in ("go.mod", "go.sum"):
            shutil.copyfile(work / name, package / name)
        sources_path.write_text(json.dumps(sources, indent=2) + "\n")

    print(f"Updated Caddy {version}, Cloudflare {sources['cloudflareVersion']}")


if __name__ == "__main__":
    main()
