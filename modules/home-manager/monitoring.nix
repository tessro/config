{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fastfetch
      htop
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      sysstat
    ];
}
