{ den, lib, ... }: {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];

    # 2026.11+ default
    nixos.boot.zfs.forceImportRoot = false;

    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}
