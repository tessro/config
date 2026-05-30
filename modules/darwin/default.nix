{ inputs, ... }: {
  imports = [
    inputs.home-manager.darwinModules.default
    ./secrets.nix
  ];
}
