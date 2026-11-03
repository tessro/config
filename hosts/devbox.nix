{ pkgs, ... }:
{
  # Fonts are left out: the box is headless and they need the private input.
  # bubblewrap is left out too: the system bwrap carries the AppArmor profile
  # that unprivileged sandboxes need on Ubuntu, and a Nix one would shadow it.
  imports = [
    ../modules/home-manager/devtools.nix
    ../modules/home-manager/dots.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/nix.nix
    ../modules/home-manager/secrets.nix
    ../modules/home-manager/shell.nix
    ../modules/home-manager/utils.nix
  ];

  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home.packages = [ pkgs.socat ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";
  home.stateVersion = "26.11";

  home.sessionVariables.NH_FLAKE = "/home/ubuntu/repos/config";

  # Nix's ncurses only searches its own store terminfo, so entries that live in
  # the distro's database (e.g. xterm-rex, from the Rex terminal) are invisible
  # to nix-built tools like zsh, which then can't find the terminal definition
  # and drops to no-color. Point ncurses at the system database too; the
  # trailing empty entry keeps the compiled-in nix store path in the search.
  home.sessionVariables.TERMINFO_DIRS =
    "/usr/share/terminfo:/etc/terminfo:/lib/terminfo:";
}
