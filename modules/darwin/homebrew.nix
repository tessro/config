{ config, inputs, ... }:
{
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

    casks = [
      "1password"
      "claude"
      "cleanshot"
      "discord"
      "docker-desktop"
      "dropbox"
      "espanso"
      "google-chrome"
      "ledger-wallet"
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

    masApps = {
      Amphetamine = 937984704;
      Xcode = 497799835;
    };
  };
}
