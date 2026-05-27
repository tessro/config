{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    den.url = "github:denful/den";
    nix-claude-code.url = "github:ryoppippi/nix-claude-code";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
