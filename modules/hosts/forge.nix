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

      system.stateVersion = "26.11";

      services.openssh.settings.PermitRootLogin = "prohibit-password";

      networking.networkmanager.enable = true;
    };
  };
}
