_: {
  boot = {
    blacklistedKernelModules = [ "vc4" ]; # `modprobe` later
    kernelModules = [
      "usb_storage"
      "usbhid"
      "xhci_hcd"
      "xhci_pci"
      "rtw89_8922au_git"
    ];
    extraModprobeConfig = ''
      options rtw89_core disable_ps_mode=y
    '';
    loader.raspberry-pi.bootloader = "kernelboot-legacy-unsupported";
    initrd.systemd.enable = true;
    zfs.forceImportRoot = false;
  };

  systemd.services = {
    zfs-mount.enable = false;

    modprobe-vc4 = {
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      before = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      script = "/run/current-system/sw/bin/modprobe vc4";
    };
  };

  # ignore partitions with "required partition" attribute
  services.udev.extraRules = ''
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
}
