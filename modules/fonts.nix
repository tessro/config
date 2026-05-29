# System-wide fonts.
#
# Works on both nix-darwin and NixOS: both expose the `fonts.packages` option.
# On darwin this installs into /Library/Fonts; on NixOS into the font path.
{ pkgs, lib, inputs, ... }: {
  # Berkeley Mono is unfree (licensed per-seat from U.S. Graphics).
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "berkeley-mono" ];

  fonts.packages = [
    (pkgs.callPackage ../pkgs/berkeley-mono {
      # Licensed .otf files come from the private assets repo.
      src = inputs.config-private + "/fonts";
    })
  ];
}
