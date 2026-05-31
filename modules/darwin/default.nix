{ inputs, lib, ... }: {
  imports = [
    inputs.home-manager.darwinModules.default
    ./secrets.nix
  ];

  system.stateVersion = lib.mkDefault 6;
}
