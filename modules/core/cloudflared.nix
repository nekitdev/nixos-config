{ config, ... }: {
  services.cloudflared = {
    enable = true;

    tunnels = {
      "49c463b3-1020-43d1-bcdf-9a62f1b5fe98" = {
        credentialsFile = "${config.sops.secrets.cloudflared.path}";
      };
    };
  };
}
