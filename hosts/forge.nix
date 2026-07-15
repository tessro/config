{ lib, modulesPath, ... }:
{
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../modules/nixos
    ../modules/nixos/bootable.nix
    ../modules/users/tess.nix
  ];

  system.stateVersion = "26.11";

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  networking.networkmanager.enable = true;
}
