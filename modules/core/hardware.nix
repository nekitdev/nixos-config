_: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    sane.enable = true;

    logitech.wireless.enable = true;

    usb-modeswitch.enable = true;
  };

  time.hardwareClockInLocalTime = false;
}
