{ pkgs, config, ... }: {
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
    };

    # https://nixos.wiki/wiki/Storage_optimization
    optimise.automatic = true;
    gc = pkgs.lib.optionalAttrs config.nix.enable {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
