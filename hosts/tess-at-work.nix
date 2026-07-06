{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;
  tess.homebrew.includeCore = true;

  nix-homebrew.autoMigrate = true;

  system.stateVersion = 6;
}
