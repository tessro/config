{ config, inputs, lib, ... }:
let
  cfg = config.tess.homebrew;
  homebrewCore = builtins.fetchTree {
    type = "github";
    owner = "homebrew";
    repo = "homebrew-core";
    rev = "d64e94408210615114922f7be48f0817edef91db";
    narHash = "sha256-dSlg8gIC2DFbhAUzg8z+tnjm+hnrigD72k9cGPv3+aw=";
  };

  commonCasks = [
    "1password"
    "claude"
    "cleanshot"
    "discord"
    "docker-desktop"
    "espanso"
    "google-chrome"
    "obsidian"
    "pixelsnap"
    "raycast"
    "signal"
    "spotify"
    "tailscale-app"
    "telegram"
    "thaw"
    "whatsapp"
  ];

  personalCasks = [
    "dropbox"
    "ledger-wallet"
    "zoom"
  ];

  commonMasApps = {
    Amphetamine = 937984704;
    Xcode = 497799835;
  };

  personalMasApps = { };
in
{
  options.tess.homebrew = {
    includePersonal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install apps from the personal Homebrew and MAS buckets.";
    };

    includeCore = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to add the homebrew/core tap.";
    };
  };

  config = {
    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;

      taps = {
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      } // lib.optionalAttrs cfg.includeCore {
        "homebrew/homebrew-core" = homebrewCore;
      };

      mutableTaps = false;
    };

    homebrew = {
      enable = true;
      enableZshIntegration = true;

      taps = builtins.attrNames config.nix-homebrew.taps;

      greedyCasks = false;

      casks = commonCasks ++ lib.optionals cfg.includePersonal personalCasks;
      masApps = commonMasApps // lib.optionalAttrs cfg.includePersonal personalMasApps;
    };
  };
}
