_: {
  sops = {
    defaultSopsFile = ../../secrets/sops.yaml;
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      matrix = {
        owner = "tuwunel";
        mode = "0400";
      };
      subscription = { };
      cache = { };
      password = {
        neededForUsers = true;
      };
      wifi = { };
      cloudflared = { };
    };
  };
}
