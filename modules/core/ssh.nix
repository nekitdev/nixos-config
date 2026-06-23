_: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
    };
  };
}
