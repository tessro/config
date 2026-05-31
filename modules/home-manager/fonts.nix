{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  home.packages = [
    (pkgs.callPackage ../../pkgs/berkeley-mono {
      src = inputs.config-private + "/fonts";
    })
  ];
}
