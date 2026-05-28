{ den, tessro, ... }: {
  den.aspects.tess = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      #(den.batteries.user-shell "zsh")
      tessro.ai
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        devenv
      ];
    };

    os = { pkgs, ... }: {
      users.users.tess.shell = pkgs.zsh;
      users.users.tess.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgixMp9vffZXwMH/oHanhXgis2yn6xLhA4vUPR4924N"

        # sshid.io/tessro
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDS6fhFpU3zjYkFfVDtgGEhZYPZPcguinnn/fhq7EA7r"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+SmQ/0M3NZJ5rBAW/82JAGcwIjLdo0EYAVz6CKs3b1"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIj76DVPyrEs1z69PWwxudQWYYSTqjoSNMi4NVlDr1kY"
      ];
    };
  };
}
