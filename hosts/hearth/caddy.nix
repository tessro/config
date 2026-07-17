{ config, pkgs, ... }:
let
  caddyWithCloudflare = pkgs.caddy.withPlugins {
    plugins = [
      "github.com/caddy-dns/cloudflare@v0.2.4"
    ];
    hash = "sha256-hEHgAG0F0ozHRAPuxEqLyTATBrE+pajeXDiSNwniorg=";
  };
in
{
  imports = [
    ../../modules/nixos/secrets.nix
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.cloudflareApiToken = { };
    templates."caddy.env" = {
      owner = config.services.caddy.user;
      group = config.services.caddy.group;
      mode = "0400";
      restartUnits = [ "caddy.service" ];
      content = ''
        CLOUDFLARE_API_TOKEN=${config.sops.placeholder.cloudflareApiToken}
      '';
    };
  };

  services.caddy = {
    enable = true;
    package = caddyWithCloudflare;
    environmentFile = config.sops.templates."caddy.env".path;

    globalConfig = ''
      acme_ca https://acme-v02.api.letsencrypt.org/directory
      acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    '';

    virtualHosts."hearth.home.rosania.org".extraConfig = ''
      reverse_proxy 127.0.0.1:5173
    '';
  };

  # Caddy serves HTTP/3 over QUIC. TCP ports 80 and 443 are opened in
  # modules/nixos/hearth.nix.
  networking.firewall.allowedUDPPorts = [ 443 ];
}
