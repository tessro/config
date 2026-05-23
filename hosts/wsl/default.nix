{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  users.users.nixos = {
    uid = 1100;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # core
    curl
    git
    htop
    tree
    wget
    zsh

    # build tools
    cmake
    gcc
    gnumake

    # developer tools
    fzf
    gh
    neovim
    ripgrep
  ];

  system.stateVersion = "25.11";
}
