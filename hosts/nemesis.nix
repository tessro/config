{ inputs, pkgs, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;

  home-manager.users.tess =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.packages = [ pkgs.ssm-session-manager-plugin ];
      home.sessionVariables = {
        AWS_PROFILE = "prod";
        # sops on macOS otherwise looks in ~/Library/Application Support.
        SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
      };

      # Instinct AWS config (SSO profile `prod`). Kept in sops because the repo is public.
      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sops.secrets.aws-config = {
        sopsFile = ./nemesis/aws-config;
        format = "binary";
        path = "${config.home.homeDirectory}/.aws/config";
      };

      # Instinct devbox: SSH tunnelled over SSM. HostName is the instance ID and changes after `devbox down`/`up`.
      programs.ssh.settings.devbox = {
        HostName = "i-0791b9f88a49c9adf";
        User = "ubuntu";
        ProxyCommand = "env PATH=${pkgs.ssm-session-manager-plugin}/bin:/usr/bin:/bin ${pkgs.awscli2}/bin/aws ssm start-session --region us-west-2 --profile prod --target %h --document-name AWS-StartSSHSession --parameters portNumber=%p";
        ForwardAgent = true;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 4;
        StrictHostKeyChecking = "accept-new";
      };
    };

  system.stateVersion = 6;
}
