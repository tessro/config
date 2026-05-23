{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    # core
    curl
    git
    wget

    # build tools
    cmake
    gcc
    gnumake

    # shell
    fastfetch
    htop
    zellij
    zsh

    # development
    fzf
    gh
    neovim
    ripgrep
  ];

  programs.zsh.enable = true;
}
