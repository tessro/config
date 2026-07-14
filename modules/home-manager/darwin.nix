{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      SetEnv = {
        # Masquerade Ghostty as Xterm to avoid confusing NixOS
        TERM = "xterm-256color";
      };
    };
  };
}
