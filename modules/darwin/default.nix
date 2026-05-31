{ inputs, lib, ... }: {
  imports = [
    inputs.home-manager.darwinModules.default
    ./secrets.nix
  ];

  programs.zsh.enable = true;

  system.primaryUser = lib.mkDefault "tess";
  system.stateVersion = lib.mkDefault 6;
}
