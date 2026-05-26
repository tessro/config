{ tessro, ... }: {
  den.aspects.hearth = {
    includes = [
      tessro.core
      tessro.nix
      tessro.ups
      tessro.bootable
      tessro.tailscale
      tessro.virtualization
    ];

    nixos = { pkgs, ... }: {
      hardware.facter.reportPath = ./facter.json;

      networking.hostId = "c84fed97";
      networking.hostName = "hearth";
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        supportedFilesystems = [ "zfs" ];
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
        extraGroups = [
          "wheel"
          "libvirtd"
          "kvm"
        ];
        hashedPassword = "!";
        shell = pkgs.zsh;

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"

          # sshid.io/tessro
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDS6fhFpU3zjYkFfVDtgGEhZYPZPcguinnn/fhq7EA7r"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+SmQ/0M3NZJ5rBAW/82JAGcwIjLdo0EYAVz6CKs3b1"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIj76DVPyrEs1z69PWwxudQWYYSTqjoSNMi4NVlDr1kY"
        ];
      };

      services.openssh = {
        enable = true;

        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      services.zfs.autoScrub.enable = true;
      services.zfs.trim.enable = true;
    };
  };
}
