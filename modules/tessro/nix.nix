{ tessro, ... }: {
  tessro.nix = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        npins
        nvd
      ];
    };
  };
}
