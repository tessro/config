{ ... }:
{
  imports = [
    ./fontconfig.nix
  ];

  programs.nix-ld.enable = true;
}
