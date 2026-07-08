_: {
  hardware.raspberry-pi.config = {
    all = {
      base-dt-params = {
        # enable the cooling fan
        cooling_fan = {
          enable = true;
          value = "on";
        };
      };
    };
  };
}
