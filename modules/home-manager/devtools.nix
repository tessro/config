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
    go
    jq
    neovim
    packer
    python3
    ripgrep
    wget

    # lsp
    gopls
    lua-language-server
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
