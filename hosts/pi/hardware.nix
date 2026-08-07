_: {
  boot = {
    blacklistedKernelModules = [ "vc4" ]; # `modprobe` later
    loader.raspberry-pi.bootloader = "kernelboot";
    initrd = {
      kernelModules = [ "usb_storage" "usbhid" "xhci_pci" ];
      systemd = {
        enable = true;
        services.usb-delay = {
          wantedBy = [ "initrd.target" ];
          before = [ "systemd-cryptsetup@crypted.service" ];
          serviceConfig = {
            Type = "oneshot";
          };
          script = "sleep 2";
        };
      };
    };
    zfs.forceImportRoot = false;
  };

  systemd.services.modprobe-vc4 = {
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    before = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    script = "/run/current-system/sw/bin/modprobe vc4";
  };

  # ignore partitions with "required partition" attribute
  services.udev.extraRules = ''
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
}
