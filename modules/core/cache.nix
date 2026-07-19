{ config, ... }: {
  services.harmonia.cache = {
    enable = true;
    signKeyPaths = [ config.sops.secrets.cache.path ];
  };
}
