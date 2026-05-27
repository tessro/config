{ tessro, ... }: {
  den.aspects.battlestation = {
    includes = [
      tessro.core
      tessro.nix
    ];

    nixos = { pkgs, ... }: {
      boot.loader.grub.enable = false;

      filesystems."/" = {
        device = "/dev/noroot";
        fsType = "auto";
      };

      wsl.defaultUser = "tess";

      users.users.tess = {
        uid = 1100;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
    };
  };
}
