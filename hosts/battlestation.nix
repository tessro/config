{ inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../modules/nixos
    ../modules/nixos/workstation.nix
    ../modules/users/tess.nix
  ];

  system.stateVersion = "25.11";

  wsl.enable = true;
  wsl.defaultUser = "tess";

  boot.loader.grub.enable = false;

  fileSystems."/" = {
    device = "/dev/noroot";
    fsType = "auto";
  };

  users.users.tess = {
    uid = 1100;
    extraGroups = [ "wheel" ];
  };
}
