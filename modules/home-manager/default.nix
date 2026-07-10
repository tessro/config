{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../home-manager/devtools.nix
    ../home-manager/dots.nix
    ../home-manager/fonts.nix
    ../home-manager/git.nix
    ../home-manager/nix.nix
    ../home-manager/secrets.nix
    ../home-manager/shell.nix
    ../home-manager/utils.nix
  ];

  home.packages =
    with pkgs;
    [
      inputs.nix-claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Claude sandbox (Linux namespaces; not available on darwin)
      bubblewrap
      socat
    ];

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

    settings.hearth.ForwardAgent = true;
  };
}
