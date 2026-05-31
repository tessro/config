{ pkgs, ... }: {
  home.packages = with pkgs; [
    zellij
    zsh
  ];

  #programs.zsh.enable = true;
}
