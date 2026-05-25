{ pkgs, ... }:

{
  imports = [
    ../../modules/core.nix
  ];

  hardware.facter.reportPath = ./facter.json;

  networking.hostId = "c84fed97";
  networking.hostName = "hearth";
  time.timeZone = "America/Los_Angeles";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];

    # adopt 2026.11 default
    zfs.forceImportRoot = false;
  };

  fileSystems = {
    "/" = {
      device = "rpool/root";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/home";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/8A27-47BA";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  users.users.tess = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "!";
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
