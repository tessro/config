{ homeManager, lib, ... }:
{
  imports = [
    homeManager.darwinModules.default
    ./secrets.nix
  ];

  programs.zsh.enable = true;

  system.primaryUser = lib.mkDefault "tess";
  system.stateVersion = lib.mkDefault 6;
}
