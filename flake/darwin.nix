{ inputs, ... }:

let
  inherit (inputs) nix-darwin;
in
{
  # nix-darwin system configs.
  #   darwin-rebuild switch --flake .#zephyr
  flake.darwinConfigurations.zephyr = nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../modules/nix-settings.nix
      ../modules/fonts.nix
      {
        nixpkgs.hostPlatform = "aarch64-darwin";

        # nix-darwin state version (integer, not a date like NixOS).
        system.stateVersion = 6;
        system.primaryUser = "tess";
      }
    ];
  };
}
