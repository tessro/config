{ tessro, ... }: {
  tessro.bootable = {
    nixos = { lib, pkgs, ... }: {
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
          PermitRootLogin = lib.mkDefault "no";
        };
      };

      time.timeZone = "America/Los_Angeles";

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"
      ];
    };
  };
}
