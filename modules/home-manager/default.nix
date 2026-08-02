{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../home-manager/devtools.nix
    ../home-manager/dots.nix
    ../home-manager/fonts.nix
    ../home-manager/git.nix
    ../home-manager/nix.nix
    ../home-manager/secrets.nix
    ../home-manager/shell.nix
    ../home-manager/utils.nix
  ];

  home.packages = lib.optionals pkgs.stdenv.isLinux [
    pkgs.bubblewrap
    pkgs.socat
  ];
}
