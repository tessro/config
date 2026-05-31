{ pkgs, lib, inputs, ... }:
  let username = "tess";
      homeDirectory = if pkgs.stdenv.isDarwin then "/Users/tess" else "/home/tess"; in {
  users.users.tess.home = homeDirectory;

  home-manager.users.tess = {
    imports = [
      ../home-manager/devtools.nix
      ../home-manager/fonts.nix
      ../home-manager/secrets.nix
    ];

    home.username = username;
    home.homeDirectory = homeDirectory;
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

    home.sessionVariables.NH_FLAKE = "${homeDirectory}/repos/config";

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
  };
}
