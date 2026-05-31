{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    age
    sops
  ];
}
