_: {
  sops = {
    defaultSopsFile = ../../secrets/sops.yaml;
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      cache = { };
      password = {
        neededForUsers = true;
      };
      wifi = { };
      cloudflared = { };
    };
  };
}
