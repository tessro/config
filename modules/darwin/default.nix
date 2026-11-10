{
  homeManager,
  inputs,
  lib,
  pkgs,
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

  environment.systemPackages = [
    pkgs.ghostty-bin
  ];

  home-manager.users.tess.home.packages = [
    (pkgs.writeShellScriptBin "ns" ''exec nh darwin switch "$@"'')
  ];

  system.primaryUser = lib.mkDefault "tess";
  system.stateVersion = lib.mkDefault 6;
}
