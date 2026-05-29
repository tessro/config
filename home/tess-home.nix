# Portable home-manager content for tess.
#
# Imported two ways:
#   - as a NixOS home-manager module via ../home/tess.nix (the Linux hosts)
#   - as a standalone home-manager config via ../flake/home.nix (zephyr, darwin)
{ pkgs, lib, inputs, ... }: {
  home.stateVersion = lib.mkDefault "25.11";

  home.packages = with pkgs; [
    devenv

    inputs.nix-claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # Claude sandbox (Linux namespaces; not available on darwin)
    bubblewrap
    socat
  ];
}
