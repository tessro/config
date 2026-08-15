{ config, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../modules/nixos
    ../modules/nixos/workstation.nix
    ../modules/users/tess.nix
  ];

  system.stateVersion = "25.11";

  wsl.enable = true;
  wsl.useWindowsDriver = true;
  programs.nix-ld.libraries = [
    config.wsl.wslLib
  ];

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
