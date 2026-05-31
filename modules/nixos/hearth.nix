{ pkgs, ... }: {
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

  # hearth0 is a NAT bridge for VM traffic: host = 10.26.8.1/22,
  # dnsmasq hands out the rest of 10.26.8.0/22, and the host
  # masquerades out via the per-host externalInterface.
  networking.bridges.hearth0.interfaces = [ ];
  networking.interfaces.hearth0.ipv4.addresses = [{
    address = "10.26.8.1";
    prefixLength = 22;
  }];
  networking.firewall.trustedInterfaces = [ "hearth0" ];
  networking.nat = {
    enable = true;
    internalInterfaces = [ "hearth0" ];
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "hearth0";
      bind-interfaces = true;
      dhcp-range = "10.26.8.2,10.26.11.254,255.255.252.0,12h";
      dhcp-authoritative = true;
      domain-needed = true;
      bogus-priv = true;
    };
  };
}
