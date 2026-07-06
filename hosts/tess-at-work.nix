{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  nix-homebrew.autoMigrate = true;

  system.stateVersion = 6;
}
