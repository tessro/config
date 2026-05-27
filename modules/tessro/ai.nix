{ tessro, den, ... }: {
  tessro.ai = {
    includes = [
      (den.provides.unfree [ "claude" ])
    ];

    homeManager = { inputs', ... }: {
      home.packages = [
        inputs'.nix-claude-code.packages.default
      ];
    };
  };
}
