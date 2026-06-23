_: {
  sops = {
    defaultSopsFile = ../../secrets/sops.yaml;
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      password = {
        neededForUsers = true;
      };
    };
  };
}
