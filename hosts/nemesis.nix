{ ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  home-manager.users.tess = {
    home.file.".claude/settings.json".enable = false;
  };

  system.stateVersion = 6;
}
