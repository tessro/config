{ pkgs, ... }:

{
  imports = [
    ../../modules/core.nix
  ];

  networking.hostName = "hearth-installer";
  time.timeZone = "America/Los_Angeles";

  # adopt 2026.11 default
  boot.zfs.forceImportRoot = false;

  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    nvme-cli
    smartmontools
    lm_sensors
  ];

  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"
  ];

  system.stateVersion = "25.11";
}
