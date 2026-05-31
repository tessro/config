{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    virtiofsd
    virt-manager
    virt-viewer
  ];

  networking.firewall.interfaces.virbr0 = {
    allowedUDPPorts = [
      53
      67
    ];
    allowedTCPPorts = [ 53 ];
  };
}
