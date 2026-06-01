{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fastfetch
      file
      htop
      killall
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      sysstat
    ];
}
