{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  system.stateVersion = lib.mkDefault "26.05";

  # 2026.11+ default
  boot.zfs.forceImportRoot = false;

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
}
