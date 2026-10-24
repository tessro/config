{ pkgs, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  home-manager.users.tess.home.packages = [ pkgs.ssm-session-manager-plugin ];

  # Instinct devbox: SSH tunnelled over SSM. HostName is the instance ID and changes after `devbox down`/`up`.
  home-manager.users.tess.programs.ssh.settings.devbox = {
    HostName = "i-0791b9f88a49c9adf";
    User = "ubuntu";
    ProxyCommand = "env PATH=${pkgs.ssm-session-manager-plugin}/bin:/usr/bin:/bin ${pkgs.awscli2}/bin/aws ssm start-session --region us-west-2 --profile PowerUserAccess-442946609573 --target %h --document-name AWS-StartSSHSession --parameters portNumber=%p";
    ForwardAgent = true;
    ServerAliveInterval = 30;
    ServerAliveCountMax = 4;
    StrictHostKeyChecking = "accept-new";
  };

  system.stateVersion = 6;
}
