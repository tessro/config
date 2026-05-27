{ den, lib, ... }: {
  den.default = {
    includes = [
      den.provides.define-user
      den.provides.hostname
      den.provides.inputs'
      den.provides.self'
    ];

    nixos.nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # 2026.11+ default
    nixos.boot.zfs.forceImportRoot = false;

    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}
