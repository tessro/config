{ ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  system.stateVersion = 6;
}
