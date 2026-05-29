{ pkgs, ... }: {
  programs.nh.enable = true;
  environment.systemPackages = with pkgs; [
    cachix
    nixfmt
    nvd
  ];
}
