{ config, ... }:
let
dot = path: {
  name = ".${path}";
  value.source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/r/config/dots/${path}";
};
in {
  home.file = builtins.listToAttrs [
    (dot "claude/settings.json")
    (dot "config/espanso")
    (dot "config/fnox")
    (dot "config/fortune")
    (dot "config/gh")
    (dot "config/ghostty")
    (dot "config/mise")
    (dot "config/neofetch")
    (dot "config/nvim")
    (dot "config/zellij")
    (dot "zsh")
    (dot "gitconfig")
    (dot "gitignore")
    (dot "inputrc")
    (dot "zshrc")
    (dot "zshrc.darwin")
    (dot "zshrc.wsl2")
  ];
}
