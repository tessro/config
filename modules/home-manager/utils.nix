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
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      sysstat
    ];
}
