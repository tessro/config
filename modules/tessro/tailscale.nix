{ tessro, ... }: {
  tessro.tailscale = {
    nixos = {
      services.tailscale.enable = true;
      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
    };
  };
}
