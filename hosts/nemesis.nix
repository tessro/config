{ ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  homebrew.casks = [ "session-manager-plugin" ];

  system.stateVersion = 6;
}
