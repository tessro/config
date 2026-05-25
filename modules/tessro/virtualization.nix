{ tessro, ... }: {
  tessro.virtualization = {
    nixos = { pkgs, ... }: {
      virtualisation.libvirtd.enable = true;

      environment.systemPackages = with pkgs; [
        qemu
        libvirt
        virtiofsd
      ];
    };
  };
}
