{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.hearth.nixosModules.default ];

  services.hearth = {
    enable = true;
    authorizedKeys = config.users.users.tess.openssh.authorizedKeys.keys;
    operatorUsers = [ "tess" ];

    agentPlane = {
      enable = true;
      httpTokenFile = config.sops.secrets."hearth-http-token".path;
      refKeyFile = config.sops.secrets."hearth-ref-key".path;
    };

    networking = {
      manage = true;
      uplinkInterface = "enp4s0";
    };
  };

  sops.secrets = {
    "hearth-http-token".restartUnits = [ "hearth-agentd.service" ];
    "hearth-ref-key".restartUnits = [ "hearth-agentd.service" ];
  };

  # make dev-restart replaces ExecStart, so keep the Nix-built kernel path in
  # the service environment as a fallback for the development binary.
  systemd.services.hearth.environment.HEARTH_GUEST_KERNEL =
    "${config.services.hearth.guestKernel}/lib/hearth/kernel/vmlinux";

  environment.systemPackages = with pkgs; [
    buildah
    e2fsprogs
    umoci
  ];

  environment.etc = {
    "containers/policy.json".text = ''
      {
        "default": [
          {
            "type": "insecureAcceptAnything"
          }
        ]
      }
    '';
    "containers/registries.conf".text = ''
      unqualified-search-registries = ["docker.io"]
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.trustedInterfaces = [ "hearth0" ];
}
