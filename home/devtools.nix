# Developer CLI tooling for tess.
#
# A home-manager module imported by ./tess-home.nix, so these follow the user
# to every host (NixOS + darwin) rather than living in environment.systemPackages.
{ pkgs, ... }: {
  home.packages = with pkgs; [
    # shell
    fastfetch
    zellij

    # development
    cmake
    fd
    fzf
    jq
    neovim
    ripgrep
  ];
}
