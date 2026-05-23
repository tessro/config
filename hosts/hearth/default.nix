{ pkgs, ... }:

{
  imports = [
    ../../modules/core.nix
  ];

  networking.hostName = "hearth";
  time.timeZone = "America/Los_Angeles";

  # adopt 2026.11 default
  boot.zfs.forceImportRoot = false;

  users.users.tess = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "changeme";
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"
    ];
  };

  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = "25.11";
}
