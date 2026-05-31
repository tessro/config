{ inputs, pkgs, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
  ];

  home-manager.users.tess.home.packages = with pkgs; [
    _1password-cli
  ];
}
