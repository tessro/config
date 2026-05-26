{ tessro, ... }: {
  tessro.ups = {
    nixos = { pkgs, ... }:

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

            ${pkgs.coreutils}/bin/head -c 32 /dev/urandom \
              | ${pkgs.coreutils}/bin/base64 -w0 \
              > "$tmp"

            ${pkgs.coreutils}/bin/chown root:root "$tmp"
            ${pkgs.coreutils}/bin/chmod 0400 "$tmp"
            ${pkgs.coreutils}/bin/mv -f "$tmp" "${upsmonPasswordFile}"
          fi
        '';

        power.ups = {
          enable = true;
          mode = "standalone";

          ups.main = {
            driver = "usbhid-ups";
            port = "auto";
          };

          users.upsmon = {
            passwordFile = upsmonPasswordFile;
            upsmon = "primary";
          };

          upsmon = {
            enable = true;

            monitor.main = {
              system = "main@localhost";
              powerValue = 1;
              user = "upsmon";
              passwordFile = upsmonPasswordFile;
              type = "primary";
            };
          };
        };
      };
  };
}
