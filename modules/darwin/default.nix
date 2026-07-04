{
  homeManager,
  inputs,
  lib,
  ...
}:
{
  imports = [
    homeManager.darwinModules.default
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ./homebrew.nix
    ./secrets.nix
  ];

  programs.zsh.enable = true;

  system.primaryUser = lib.mkDefault "tess";
  system.stateVersion = lib.mkDefault 6;
}
