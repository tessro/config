{ inputs, ... }:

let
  inherit (inputs) nixpkgs home-manager;

  # Standalone home-manager for hosts where neither NixOS nor nix-darwin manages
  # the user — e.g. an Ubuntu box. NixOS hosts and zephyr (nix-darwin) import
  # ../home/tess-home.nix directly instead, so this is purely the standalone path.
  #   home-manager switch --flake .#tess
  mkHome = system: home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      # Unfree: claude-code + codex (CLIs) and berkeley-mono (the font).
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
