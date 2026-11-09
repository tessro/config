{
  config,
  inputs,
  pkgs,
  ...
}:
{
  # Fonts are left out: the box is headless and they need the private input.
  # bubblewrap is left out too: the system bwrap carries the AppArmor profile
  # that unprivileged sandboxes need on Ubuntu, and a Nix one would shadow it.
  imports = [
    inputs.sops-nix.homeManagerModules.sops
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

  # Full store path because sudo swaps PATH for secure_path, which has no Nix
  # profile; sudoers env_keep passes SUDO_EDITOR through.
  home.sessionVariables.SUDO_EDITOR = "${pkgs.neovim}/bin/nvim";

  # Depot CLI, installed to ~/.depot/bin by its installer. Expose its install
  # dir and put it first on PATH (home.sessionPath prepends), matching the
  # installer's own shell snippet.
  home.sessionVariables.DEPOT_INSTALL_DIR = "${config.home.homeDirectory}/.depot/bin";
  home.sessionPath = [ "${config.home.homeDirectory}/.depot/bin" ];

  # Cloud config, decrypted at activation. The default profile uses the
  # machine's instance role; `tess` is an SSO profile for work the role can't
  # do. Kept encrypted because the repo is public.
  sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  sops.secrets.aws-config = {
    sopsFile = ./devbox/aws-config;
    format = "binary";
    path = "${config.home.homeDirectory}/.aws/config";
  };

  # Machine-local shell config, sourced by the shared zshrc. Encrypted so it
  # can hold secrets.
  sops.secrets.zshrc-local = {
    sopsFile = ./devbox/zshrc.local;
    format = "binary";
    path = "${config.home.homeDirectory}/.zshrc.local";
  };

  # Nix's ncurses only searches its own store terminfo, so entries that live in
  # the distro's database (e.g. xterm-rex, from the Rex terminal) are invisible
  # to nix-built tools like zsh, which then can't find the terminal definition
  # and drops to no-color. Point ncurses at the system database too; the
  # trailing empty entry keeps the compiled-in nix store path in the search.
  home.sessionVariables.TERMINFO_DIRS =
    "/usr/share/terminfo:/etc/terminfo:/lib/terminfo:";
}
