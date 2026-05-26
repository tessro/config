{ den, lib, ... }: {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];

    nixos.nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # 2026.11+ default
    nixos.boot.zfs.forceImportRoot = false;

    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}
