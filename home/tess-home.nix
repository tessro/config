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

  home.sessionVariables.NH_FLAKE = "${config.home.homeDirectory}/repos/config";

  programs.ssh = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      SetEnv = {
        # Masquerade Ghostty as Xterm to avoid confusing NixOS
        TERM = "xterm-256color";
      };
    };
  };
}
