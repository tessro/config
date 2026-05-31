{ inputs, lib, ... }:

let
  inherit (inputs)
    nixpkgs
    nix-darwin
    home-manager
    ;

  # Modules every host shares.
  common = name: system: [
    ../modules/nix-settings.nix
    ../modules/unfree.nix
    {
      networking.hostName = lib.mkDefault name;
      nixpkgs.hostPlatform = system;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
    }
  ];

  mkNixos = name: { system, modules }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = common name system ++ modules ++ [
        home-manager.nixosModules.home-manager
        {
          system.stateVersion = lib.mkDefault "25.11";
          # 2026.11+ default
          boot.zfs.forceImportRoot = false;
        }
      ];
    };

  mkDarwin = name: { modules }:
    nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = common name "aarch64-darwin" ++ modules ++ [
        home-manager.darwinModules.home-manager
        {
          system.stateVersion = lib.mkDefault 6;
        }
      ];
    };
in
{
  flake.nixosConfigurations = {
    battlestation = mkNixos "battlestation" {
      system = "x86_64-linux";
      modules = [
        ../hosts/battlestation.nix
      ];
    };

    forge = mkNixos "forge" {
      system = "x86_64-linux";
      modules = [
        ../hosts/forge.nix
      ];
    };

    hearth = mkNixos "hearth" {
      system = "x86_64-linux";
      modules = [
        ../hosts/hearth/default.nix
      ];
    };
  };

  flake.darwinConfigurations = {
    zephyr = mkDarwin "zephyr" {
      modules = [
        ../hosts/zephyr.nix
      ];
    };
  };
}
