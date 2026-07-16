{ config, ... }: {
  services.harmonia.cache = {
    enable = true;
    signKeyPaths = [ config.sops.secrets.cache.path ];
    settings.real_nix_store = "/var/lib/harmonia/nix/store";
  };
}
