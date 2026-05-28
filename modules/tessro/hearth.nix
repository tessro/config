{ lib, tessro, ... }: {
  tessro.hearth = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        cloud-hypervisor
        cloud-utils
        socat
      ];

      boot.kernelModules = [ "kvm" "vhost_vsock" "tun" ];

      users.groups.hearth = { };
      users.users.hearth = {
        isSystemUser = true;
        group = "hearth";
        description = "Hearth daemon";
      };

      systemd.tmpfiles.rules = [
        "d /etc/hearth                  0750 root   hearth -"
        "d /etc/hearth/services         0750 root   hearth -"
        "d /var/lib/hearth              0750 hearth hearth -"
        "d /var/lib/hearth/images       0750 hearth hearth -"
        "d /var/lib/hearth/disks        0750 hearth hearth -"
        "d /var/lib/hearth/seeds        0750 hearth hearth -"
        "d /var/lib/hearth/snapshots    0750 hearth hearth -"
        "d /var/log/hearth              0750 hearth hearth -"
        "d /run/hearth                  0755 hearth hearth -"
        "d /run/hearth/vms              0750 hearth hearth -"
        "d /run/hearth/vsock            0750 hearth hearth -"
      ];

      # br0 carries all VM traffic. Day 1: upstream router does DHCP.
      # The host config must attach a physical interface, e.g.:
      #   networking.bridges.br0.interfaces = [ "enp1s0" ];
      networking.bridges.br0.interfaces = lib.mkDefault [ ];
      networking.interfaces.br0.useDHCP = true;
      networking.firewall.trustedInterfaces = [ "br0" ];
    };
  };
}
