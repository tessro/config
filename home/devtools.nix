{ pkgs, ... }: {
  home.packages = with pkgs; [
    # shell
    fastfetch
    zellij

    # development
    cmake
    fd
    fzf
    jq
    neovim
    ripgrep
  ];
}
