{ pkgs, ... }: let
  syncEfiFallback = ''
    ${pkgs.coreutils}/bin/mkdir -p /boot-fallback

    mounted=0
    if ! ${pkgs.util-linux}/bin/mountpoint -q /boot-fallback; then
      ${pkgs.util-linux}/bin/mount /boot-fallback
      mounted=1
    fi

    cleanup() {
      if [ "$mounted" = 1 ]; then
        ${pkgs.util-linux}/bin/umount /boot-fallback
      fi
    }
    trap cleanup EXIT

    ${pkgs.rsync}/bin/rsync -a --delete /boot/ /boot-fallback/
  '';
in {
  facter.reportPath = ./facter.json;

  networking.hostId = "c84fed97";
  networking.nat.externalInterface = "enp4s0";
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        extraInstallCommands = syncEfiFallback;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
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

    "/boot-fallback" = {
      device = "/dev/disk/by-uuid/8AB3-FA98";
      fsType = "vfat";
      options = [ "noauto" "fmask=0022" "dmask=0022" ];
    };
  };

  systemd.services.sync-efi-fallback = {
    description = "Sync fallback EFI system partition";
    wantedBy = [ "multi-user.target" ];
    after = [ "boot.mount" ];
    requires = [ "boot.mount" ];
    serviceConfig.Type = "oneshot";
    script = syncEfiFallback;
  };

  users.users.tess = {
    extraGroups = [
      "wheel"
      "libvirtd"
      "kvm"
    ];
    hashedPassword = "!";
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
}
