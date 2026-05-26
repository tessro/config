{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    import-tree.url = "github:denful/import-tree";
    den.url = "github:denful/den";
  };

  outputs = inputs:
  let
   den = (inputs.nixpkgs.lib.evalModules {
     modules = [ (inputs.import-tree ./modules) ];
     specialArgs.inputs = inputs;
   }).config;
  in
  {
    inherit (den.flake) nixosConfigurations darwinConfigurations;
  };
}
