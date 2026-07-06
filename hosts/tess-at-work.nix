{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  nix-homebrew.autoMigrate = true;

  system.stateVersion = 6;
}
