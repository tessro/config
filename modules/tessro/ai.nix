{ tessro, den, ... }: {
  tessro.ai = {
    includes = [
      (den.provides.unfree [ "claude" ])
    ];

    homeManager = { inputs', pkgs, ... }: {
      home.packages = with pkgs; [
        inputs'.nix-claude-code.packages.default
        inputs'.codex-cli-nix.packages.default

        # Claude sandbox
        bubblewrap
        socat
      ];
    };
  };
}
