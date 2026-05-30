{ inputs, ... }:

let
  inherit (inputs) nix-darwin home-manager nixpkgs;
in
{
  flake.darwinConfigurations.zephyr = nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; };
    modules = [
      home-manager.darwinModules.home-manager
      ../modules/nix-settings.nix
      {
        nixpkgs.hostPlatform = "aarch64-darwin";

        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "claude-code"
            "codex"
            "berkeley-mono"
          ];

        system.stateVersion = 6;
        system.primaryUser = "tess";
        users.users.tess.home = "/Users/tess";

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.tess = {
          imports = [ ../home/tess-home.nix ];
          programs.home-manager.enable = true;
        };
      }
    ];
  };
}
