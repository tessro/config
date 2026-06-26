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
      git
      git-lfs
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

  programs.gh = {
    enable = true;

    hosts."github.com".user = "tessro";

    settings.aliases = {
      co = "pr checkout";
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
