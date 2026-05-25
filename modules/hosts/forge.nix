{ tessro, ... }: {
  den.aspects.forge = {
    includes = [
      tessro.core
      tessro.bootable
      tessro.nix
    ];

    nixos = { modulesPath, ... }: {
      imports = [
        "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];

      networking.networkmanager.enable = true;

      time.timeZone = "America/Los_Angeles";
    };
  };
}
