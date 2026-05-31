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

  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
}
