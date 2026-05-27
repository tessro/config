{ den, lib, tessro, ... }: {
  den.default = {
    includes = [
      den.provides.define-user
      den.provides.hostname
      den.provides.mutual-provider
      den.provides.inputs'
      den.provides.self'

      tessro.nix-settings
    ];

    # 2026.11+ default
    nixos.boot.zfs.forceImportRoot = false;

    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}
