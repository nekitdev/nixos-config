_: {
  services = {
    libinput.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us,ru";
    };
  };
}
