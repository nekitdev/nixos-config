{ currentPi, ... }: {
  sops = {
    defaultSopsFile = ../../secrets/sops.yaml;
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      matrix =
        if currentPi then
          {
            owner = "tuwunel";
            mode = "0400";
          }
        else
          { };
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
