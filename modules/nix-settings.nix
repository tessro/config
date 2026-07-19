{ pkgs, config, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [ "https://tessro.cachix.org" ];
      trusted-public-keys = [
        "tessro.cachix.org-1:Du6hKWIx/04tOlXfv8dsJiBNwhYOB15KQAZRgQfl7+o="
      ];
    };

    # https://nixos.wiki/wiki/Storage_optimization
    optimise.automatic = true;
    gc = pkgs.lib.optionalAttrs config.nix.enable {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
