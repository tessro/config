{ inputs, lib, ... }:

let
  inherit (inputs)
    nix-darwin
    ;

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

  mkNixos =
    name:
    {
      system,
      modules,
      nixpkgs ? inputs.nixpkgs,
      homeManager ? inputs.home-manager,
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs homeManager; };
      modules = common name system ++ modules;
    };

  mkDarwin =
    name:
    {
      modules,
      system ? "aarch64-darwin",
      nixpkgs ? inputs.nixpkgs-darwin,
      homeManager ? inputs.home-manager,
    }:
    nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs homeManager; };
      modules =
        common name system
        ++ [
          {
            nixpkgs.source = lib.mkDefault nixpkgs;
            nixpkgs.flake.source = lib.mkDefault nixpkgs.outPath;
          }
        ]
        ++ modules;
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
      nixpkgs = inputs.nixpkgs-stable;
      homeManager = inputs.home-manager-stable;
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
