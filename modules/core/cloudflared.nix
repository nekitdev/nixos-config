{ config, ... }: {
  services.cloudflared = {
    enable = true;

    tunnels = {
      "49c463b3-1020-43d1-bcdf-9a62f1b5fe98" = {
        credentialsFile = "${config.sops.secrets.cloudflared.path}";

        ingress = {
          "nekit.dev" = "http://127.0.0.1:6942";
          "ssh.nekit.dev" = "ssh://127.0.0.1:22";
          "cache.nekit.dev" = "http://127.0.0.1:5000";
          "battery.nekit.dev" = "http://127.0.0.1:4269";
          "dualizzzm.design" = "http://127.0.0.1:6913";
          "lyrichar.app" = "http://127.0.0.1:4213";
          "open.lyrichar.app" = "http://127.0.0.1:1369";
          "api.lyrichar.app" = "http://127.0.0.1:1342";
        };

        default = "http_status:503";
      };
    };
  };
}
