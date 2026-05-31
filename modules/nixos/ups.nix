{ pkgs, ... }:

let
  upsmonPasswordFile = "/var/lib/secrets/nut/upsmon-password";
in
{
  environment.systemPackages = with pkgs; [
    nut
  ];

  system.activationScripts.generateNutUpsmonPassword = ''
    set -eu

    if [ ! -s "${upsmonPasswordFile}" ]; then
      ${pkgs.coreutils}/bin/install -d -m 0700 -o root -g root /var/lib/secrets/nut

      tmp="$(${pkgs.coreutils}/bin/mktemp "${upsmonPasswordFile}.XXXXXX")"

      ${pkgs.coreutils}/bin/head -c 64 /dev/urandom \
        | ${pkgs.coreutils}/bin/base64 -w0 \
        | ${pkgs.coreutils}/bin/tr -dc 'a-zA-Z0-9' \
        | ${pkgs.coreutils}/bin/head -c 32 \
        > "$tmp"

      ${pkgs.coreutils}/bin/chown root:root "$tmp"
      ${pkgs.coreutils}/bin/chmod 0400 "$tmp"
      ${pkgs.coreutils}/bin/mv -f "$tmp" "${upsmonPasswordFile}"
    fi
  '';

  power.ups = {
    enable = true;
    mode = "netserver";
    openFirewall = true;

    ups.cp1500 = {
      driver = "usbhid-ups";
      port = "auto";
      description = "CyberPower CP1500PFCRM2U";
    };

    upsd.listen = [
      {
        address = "127.0.0.1";
        port = 3493;
      }
      {
        address = "192.168.1.30";
        port = 3493;
      }
    ];

    users.upsmon = {
      passwordFile = upsmonPasswordFile;
      upsmon = "primary";
    };

    upsmon.monitor.cp1500 = {
      system = "cp1500@localhost";
      user = "upsmon";
      passwordFile = upsmonPasswordFile;
      type = "primary";
    };
  };
}
