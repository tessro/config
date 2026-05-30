{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    sops
  ];
}
