{ inputs, lib, ... }:

let
  inherit (inputs)
    nixpkgs
    home-manager
    nixos-wsl
    nixos-facter-modules
    sops-nix
    ;

  # Modules every host shares.
  common = name: system: [
    ../modules/nix-settings.nix
    home-manager.nixosModules.home-manager
    sops-nix.nixosModules.sops
    {
      networking.hostName = lib.mkDefault name;
      nixpkgs.hostPlatform = system;

      # 2026.11+ default
      boot.zfs.forceImportRoot = false;

      system.stateVersion = lib.mkDefault "25.11";

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
    }
  ];

  mkHost = name: { system, modules }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = common name system ++ modules;
    };
in
{
  flake.nixosConfigurations = {
    battlestation = mkHost "battlestation" {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        ../modules/core.nix
        ../modules/nix.nix
        ../home/tess.nix
        ../hosts/battlestation.nix
      ];
    };

    forge = mkHost "forge" {
      system = "x86_64-linux";
      modules = [
        ../modules/core.nix
        ../modules/bootable.nix
        ../modules/nix.nix
        ../home/tess.nix
        ../hosts/forge.nix
      ];
    };

    hearth = mkHost "hearth" {
      system = "x86_64-linux";
      modules = [
        nixos-facter-modules.nixosModules.facter
        ../modules/core.nix
        ../modules/nix.nix
        ../modules/ups.nix
        ../modules/bootable.nix
        ../modules/tailscale.nix
        ../modules/virtualization.nix
        ../modules/hearth.nix
        ../home/tess.nix
        ../hosts/hearth/default.nix
      ];
    };
  };
}
