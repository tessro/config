{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    cmake
    curl
    devenv
    fd
    fzf
    gcc
    gh
    git
    git-lfs
    gnumake
    go
    jq
    neovim
    packer
    python3
    ripgrep
    wget

    # infra
    awscli2
    opentofu

    # lsp
    gopls
    lua-language-server
    tofu-ls
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
