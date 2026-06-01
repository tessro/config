{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fastfetch
      htop
      killall
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      sysstat
    ];
}
