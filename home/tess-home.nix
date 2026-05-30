# Portable home-manager content for tess.
#
# Imported two ways:
#   - as a NixOS home-manager module via ../home/tess.nix (the Linux hosts)
#   - as a nix-darwin home-manager module via ../flake/darwin.nix (zephyr)
{ pkgs, lib, config, inputs, ... }: {
  imports = [ ./devtools.nix ./fonts.nix ];

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

  # On darwin, route git/ssh auth through the 1Password SSH agent so no key
  # file lives on disk (also what bootstraps the private config-private fetch).
  programs.ssh = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    enableDefaultConfig = false;
    settings."*".identityAgent =
      ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
  };
}
