{ inputs, ... }:

let
  inherit (inputs) nix-darwin home-manager nixpkgs;
in
{
  # nix-darwin system configs. `darwin-rebuild switch` also activates
  # home-manager for tess — no separate `home-manager switch` needed.
  #   darwin-rebuild switch --flake .#zephyr
  flake.darwinConfigurations.zephyr = nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; };
    modules = [
      home-manager.darwinModules.home-manager
      ../modules/nix-settings.nix
      {
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Unfree packages reach the system pkgs via home-manager (useGlobalPkgs):
        # claude-code + codex (CLIs) and berkeley-mono (the font). Only one
        # module may define the predicate, so it lives here.
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "claude-code"
            "codex"
            "berkeley-mono"
          ];

        # nix-darwin state version (integer, not a date like NixOS).
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
