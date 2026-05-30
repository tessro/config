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
    gcc
    gnumake

    # shell
    zsh
  ];

  programs.zsh.enable = true;
}
