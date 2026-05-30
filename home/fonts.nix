# Personal fonts, installed per-user via home-manager.
#
# Berkeley Mono is a personal-license font — it's "mine", not a machine asset —
# so home-manager owns it and places it per target: ~/Library/Fonts on darwin,
# the fontconfig user path on Linux. This follows the user to every host rather
# than living in the nix-darwin / NixOS system config.
{ pkgs, inputs, ... }: {
  home.packages = [
    (pkgs.callPackage ../pkgs/berkeley-mono {
      # Licensed .otf files come from the private assets repo.
      src = inputs.config-private + "/fonts";
    })
  ];

  # Make profile-installed fonts discoverable via fontconfig — Linux-only
  # infrastructure. On darwin home-manager links fonts into
  # ~/Library/Fonts/HomeManager where CoreText finds them, so fontconfig has no
  # role and would just drop inert config.
  fonts.fontconfig.enable = pkgs.stdenv.isLinux;
}
