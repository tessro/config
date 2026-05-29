# Portable home-manager content for tess.
#
# Imported two ways:
#   - as a NixOS home-manager module via ../home/tess.nix (the Linux hosts)
#   - as a standalone home-manager config via ../flake/home.nix (zephyr, darwin)
{ pkgs, lib, config, inputs, ... }: {
  imports = [ ./devtools.nix ];

  home.stateVersion = lib.mkDefault "25.11";

  home.packages = with pkgs; [
    devenv
    gh
    nh

    inputs.nix-claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # Claude sandbox (Linux namespaces; not available on darwin)
    bubblewrap
    socat
  ];

  # Point nh at this flake without hardcoding the platform's home path.
  home.sessionVariables.NH_FLAKE = "${config.home.homeDirectory}/repos/config";
}
