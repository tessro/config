{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmake
    curl
    devenv
    fd
    fzf
    gcc
    gh
    git
    gnumake
    jq
    neovim
    packer
    ripgrep
    wget
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
