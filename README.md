# systems

Nix configuration for my systems. This is "just for me" but you are welcome to
reference it!

## Bootstrapping

### Darwin

1. Install [Nix](https://nixos.org/download) and 1Password.
2. In 1Password: **Settings → Developer → Use the SSH agent**.
3. Point SSH at the 1Password agent:

   ```sh
   export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
   ```

4. Seed GitHub's host key:

   ```sh
   ssh -o StrictHostKeyChecking=accept-new -T git@github.com
   ```

5. Clone this repo and build:

   ```sh
   mkdir ~/repos
   git clone https://github.com/tessro/config.git ~/repos/config
   cd ~/repos/config
   nix run nix-darwin -- switch --flake .#zephyr
   home-manager switch --flake .#tess
   ```

## License

MIT
