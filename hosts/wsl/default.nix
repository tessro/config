{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/core.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "tess";

  users.users.tess = {
    uid = 1100;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";
}
