{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
      "berkeley-mono"
      "claude-code"
      "codex"
    ];

}
