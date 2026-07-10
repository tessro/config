{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      btop
      cmake
      curl
      devenv
      fd
      fzf
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
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      gcc
      gnumake
    ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
