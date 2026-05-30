{ inputs, ... }:

let
  inherit (inputs) nixpkgs home-manager;

  # Standalone home-manager for non-NixOS, non-Darwin hosts
  mkHome = system: home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" "codex" "berkeley-mono" ];
    };
    extraSpecialArgs = { inherit inputs; };
    modules = [
      ../home/tess-home.nix
      {
        home.username = "tess";
        home.homeDirectory = "/home/tess";
        programs.home-manager.enable = true;
      }
    ];
  };
in
{
  flake.homeConfigurations.tess = mkHome "x86_64-linux";
}
