{ config, ... }:
{
  environment.etc = {
    "stalin/config.toml".source = ./stalin.toml;
    # The CA certificate is public. Only its key is a secret.
    "stalin/ca.pem".source = ./stalin-ca.pem;
  };

  sops.secrets = {
    "stalin-ca-key".restartUnits = [ "stalin.service" ];
    "openrouter-api-key".restartUnits = [ "stalin.service" ];
  };

  services.hearth.egressProxy = {
    enable = true;
    stalinConfigFile = "/etc/stalin/config.toml";
    caCertificateFile = "/etc/stalin/ca.pem";

    # Attribute names are the systemd credential names that stalin.toml refers to.
    credentials = {
      mitm_ca_key = config.sops.secrets."stalin-ca-key".path;
      openrouter_api_key = config.sops.secrets."openrouter-api-key".path;
    };

    # Public dummy value. Stalin replaces the header before the request leaves.
    placeholderEnvironment.OPENROUTER_API_KEY = "stalin-managed";

    blockDirectHttps = true;
  };
}
