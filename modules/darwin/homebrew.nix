{ config, inputs, lib, ... }:
let
  cfg = config.tess.homebrew;

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
    "zoom"
  ];

  personalCasks = [
    "dropbox"
    "ledger-wallet"
  ];

  commonMasApps = {
    Amphetamine = 937984704;
    Xcode = 497799835;
  };

  personalMasApps = { };
in
{
  options.tess.homebrew.includePersonal = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to install apps from the personal Homebrew and MAS buckets.";
  };

  config = {
    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;

      taps = {
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
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
