{ modulesPath, ... }:
{
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../modules/nixos
    ../modules/core.nix
    ../modules/bootable.nix
    ../modules/nix.nix
    ../modules/users/tess.nix
  ];

  system.stateVersion = "26.11";

  services.openssh.settings.PermitRootLogin = "prohibit-password";

  networking.networkmanager.enable = true;
}
