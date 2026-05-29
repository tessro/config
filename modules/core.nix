{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # monitoring
    htop
    sysstat

    # net
    curl
    git
    wget

    # build tools
    cmake
    gcc
    gnumake

    # shell
    fastfetch
    zellij
    zsh

    # development
    fd
    fzf
    gh
    jq
    neovim
    ripgrep
  ];

  programs.zsh.enable = true;
}
