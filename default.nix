let
  sources = import ./npins;
  with-inputs = import sources.with-inputs sources { };
  outputs = inputs:
    (inputs.nixpkgs.lib.evalModules {
      modules = [ (inputs.import-tree ./modules) ];
      specialArgs = {
        inherit inputs;
      };
    }).config;
in
with-inputs outputs
