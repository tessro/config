{
  pkgs,
  lib,
  ...
}:
let
  username = "tess";
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/tess" else "/home/tess";
in
{
  users.users.tess.home = homeDirectory;

  home-manager.users.tess = {
    imports =
      [
        ../home-manager/default.nix
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        ../home-manager/darwin.nix
      ];

    home.username = username;
    home.homeDirectory = homeDirectory;
    home.stateVersion = lib.mkDefault "25.11";

    home.sessionVariables.NH_FLAKE = "${homeDirectory}/repos/config";
  };
}
