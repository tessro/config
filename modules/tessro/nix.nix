{ tessro, ... }: {
  tessro.nix = {
    nixos = { pkgs, ... }: {
      programs.nh.enable = true;
      environment.systemPackages = with pkgs; [
        nvd
      ];
    };
  };
}
