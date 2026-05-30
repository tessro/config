{ pkgs, inputs, ... }: {
  home.packages = [
    (pkgs.callPackage ../pkgs/berkeley-mono {
      src = inputs.config-private + "/fonts";
    })
  ];

  fonts.fontconfig.enable = pkgs.stdenv.isLinux;
}
