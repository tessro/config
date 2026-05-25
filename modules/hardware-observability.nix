{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lm_sensors
    smartmontools
    nvme-cli
    pciutils
    usbutils
  ];
}
