{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zellij
    zsh
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig.settings.all_compile = false;
  };

  #programs.zsh.enable = true;
}
