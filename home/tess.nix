{ pkgs, lib, inputs, ... }: {
  # claude-code and codex are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "codex"
    ];

  users.users.tess = {
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"

      # sshid.io/tessro
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDS6fhFpU3zjYkFfVDtgGEhZYPZPcguinnn/fhq7EA7r"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+SmQ/0M3NZJ5rBAW/82JAGcwIjLdo0EYAVz6CKs3b1"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIj76DVPyrEs1z69PWwxudQWYYSTqjoSNMi4NVlDr1kY"
    ];
  };

  home-manager.users.tess = import ./tess-home.nix;
}
