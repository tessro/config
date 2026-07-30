{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fastfetch
      file
      htop
      killall
      pstree
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      sysstat
    ];
}
