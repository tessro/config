{ tessro, ... }: {
  den.aspects.battlestation = {
    includes = [
      tessro.core
      tessro.nix
    ];

    nixos = {
      boot.loader.grub.enable = false;

      fileSystems."/" = {
        device = "/dev/noroot";
        fsType = "auto";
      };

      wsl.defaultUser = "tess";

      users.users.tess = {
        uid = 1100;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };
  };
}
