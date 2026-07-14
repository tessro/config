{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../home-manager/devtools.nix
    ../home-manager/dots.nix
    ../home-manager/fonts.nix
    ../home-manager/git.nix
    ../home-manager/nix.nix
    ../home-manager/secrets.nix
    ../home-manager/shell.nix
    ../home-manager/utils.nix
  ];

  home.packages =
    with pkgs;
    [
      inputs.nix-claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Claude sandbox (Linux namespaces; not available on darwin)
      bubblewrap
      socat
    ];
}
