{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = true;

  home-manager.users.tess.programs.ssh.settings.hearth.ForwardAgent = true;

  system.stateVersion = 6;
}
