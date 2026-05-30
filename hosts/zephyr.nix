{ lib, ... }: {
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  system.primaryUser = "tess";
}
