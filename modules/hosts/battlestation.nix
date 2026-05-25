{ tessro, ... }: {
  den.aspects.battlestation = {
    includes = [
      tessro.core
      tessro.nix
    ];

    nixos = { pkgs, ... }: {
      wsl.defaultUser = "tess";

      users.users.tess = {
        uid = 1100;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };

      system.stateVersion = "25.11";
    };
  };
}
