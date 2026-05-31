{ pkgs, ... }: {
  home.packages = with pkgs; [
    cachix
    nh
    nixd
    nixfmt
    nvd
  ];

  programs.nh.enable = true;
}
