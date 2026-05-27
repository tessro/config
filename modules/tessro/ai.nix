{ tessro, ... }: {
  tessro.ai = {
    homeManager = { inputs', ... }: {
      home.packages = [
        inputs'.nix-claude-code.packages.default
      ];
    };
  };
}
