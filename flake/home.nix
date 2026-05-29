{ inputs, ... }:

let
  inherit (inputs) nixpkgs home-manager;

  system = "aarch64-darwin";

  pkgs = import nixpkgs {
    inherit system;
    # claude-code and codex are unfree.
    config.allowUnfreePredicate = pkg:
      builtins.elem (nixpkgs.lib.getName pkg) [
        "claude-code"
        "codex"
      ];
  };
in
{
  # Standalone home-manager configs (not tied to a NixOS host).
  #   home-manager switch --flake .#tess
  flake.homeConfigurations.tess = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs; };
    modules = [
      ../home/tess-home.nix
      {
        home.username = "tess";
        home.homeDirectory = "/Users/tess";

        # Install the home-manager CLI so future `home-manager switch` works.
        programs.home-manager.enable = true;
      }
    ];
  };
}
