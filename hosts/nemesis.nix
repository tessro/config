{ pkgs, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  home-manager.users.tess = {
    # Keep work stack choices in this host or in each project's dev shell.
    disabledModules = [ ../modules/home-manager/devtools.nix ];
    home.packages = with pkgs; [
      btop
      curl
      devenv
      fd
      fzf
      jq
      neovim
      ripgrep
      wget
    ];

    home.file.".claude/settings.json".enable = false;
  };

  system.stateVersion = 6;
}
