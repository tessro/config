# systems

Nix configuration for my systems. This is "just for me" but you are welcome to
reference it!

## Bootstrapping

### Darwin

Each Mac gets its own file in `hosts/` and entry in `flake/hosts.nix`.
`nemesis` is the new work Mac (Apple Silicon, macOS user `tess`). It starts
from `tess-at-work`, with its own host settings: no Pinecone SSH routes,
Homebrew core or HashiCorp taps. It uses the same shared dev tools as `zephyr`.
Homebrew still manages the common casks and Mac App Store apps.

1. Install [Nix](https://nixos.org/download) and 1Password.
   This config lets nix-darwin manage Nix; use an install that supports that.
   If macOS asks for Command Line Tools when you first run Git, install them.
2. In 1Password: **Settings → Developer → Use the SSH agent**.
   Make sure it has a GitHub key with access to `tessro/config-private`, which
   holds the fonts. The build needs that repo even though this repo is public.
3. Point SSH at the 1Password agent:

   ```sh
   export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
   ```

4. Seed GitHub's host key:

   ```sh
   ssh -o StrictHostKeyChecking=accept-new -T git@github.com
   ```

5. Clone this repo and set up the dotfile path. `NH_FLAKE` and the project
   picker use `~/repos`; the dotfile links use `~/r/config`.

   ```sh
   mkdir -p ~/repos ~/r
   git clone https://github.com/tessro/config.git ~/repos/config
   ln -s ~/repos/config ~/r/config
   cd ~/repos/config
   ```

6. Build first, then apply the work Mac profile:

   ```sh
   nix --extra-experimental-features 'nix-command flakes' build .#darwinConfigurations.nemesis.system
   sudo nix-env -p /nix/var/nix/profiles/system --set ./result
   sudo ./result/activate
   ```

   The first command fetches the private input as your user, with the 1Password
   agent. The next two save the first system generation and apply it as root.
   Use `zephyr` instead of `nemesis` for the personal Mac.
   Sign in to the App Store before activation
   so Homebrew can install the listed App Store apps.

7. Open a new shell. For later changes:

   ```sh
   cd ~/repos/config
   nh darwin switch . -H nemesis
   ```

   `nh` builds as your user and calls sudo to apply the result.
   Keep `system.stateVersion` at its initial value when updating inputs.

## License

MIT
