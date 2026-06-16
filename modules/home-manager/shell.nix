{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zellij
    zsh
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  #programs.zsh.enable = true;
}
