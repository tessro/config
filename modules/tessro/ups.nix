{ tessro, ... }: {
  tessro.ups = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        nut
      ];

      power.ups = {
        enable = true;
        mode = "standalone";

        ups.main = {
          driver = "usbhid-ups";
          port = "auto";
        };

        upsmon.enable = false;
      };
    };
  };
}
