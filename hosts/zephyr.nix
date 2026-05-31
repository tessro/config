{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  system.stateVersion = 6;
}
