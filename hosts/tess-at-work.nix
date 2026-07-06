{ lib, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;
  tess.homebrew.includeCore = true;

  home-manager.users.tess.programs.ssh.extraConfig = lib.mkAfter ''
    Host cloud-2
      ForwardAgent yes
      SetEnv TERM=xterm-256color

    # Staging has to be first or prod will match it.
    Host *.staging.pinecone.internal
      User runner
      Port 2222
      ProxyJump bastion@ssh.staging.pinecone.cloud

    Host *.pinecone.internal
      User runner
      Port 2222
      ProxyJump bastion@ssh.pinecone.cloud
  '';

  nix-homebrew.autoMigrate = true;

  system.stateVersion = 6;
}
