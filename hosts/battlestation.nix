{ ... }: {
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
