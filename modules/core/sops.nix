_: {
  sops = {
    defaultSopsFile = ../../secrets/sops.yaml;
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      zfs = { }; # TODO: initrd
      password = {
        neededForUsers = true;
      };
      wifi = { };
      cloudflared = { };
    };
  };
}
