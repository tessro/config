{ homeManager, ... }:
{
  imports = [
    ../modules/darwin
    ../modules/users/tess.nix
  ];

  tess.homebrew.includePersonal = false;
  tess.homebrew.includeCore = true;

  home-manager.users.tess.programs.ssh.settings = {
    cloud-2 = {
      ForwardAgent = true;
      SetEnv.TERM = "xterm-256color";
    };

    pinecone-staging-internal = homeManager.lib.hm.dag.entryBefore [ "pinecone-internal" ] {
      header = "Host *.staging.pinecone.internal";
      User = "runner";
      Port = 2222;
      ProxyJump = "bastion@ssh.staging.pinecone.cloud";
    };

    pinecone-internal = {
      header = "Host *.pinecone.internal";
      User = "runner";
      Port = 2222;
      ProxyJump = "bastion@ssh.pinecone.cloud";
    };
  };

  nix-homebrew.autoMigrate = true;

  system.stateVersion = 6;
}
