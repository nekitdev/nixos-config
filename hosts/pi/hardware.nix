_: {
  boot = {
    blacklistedKernelModules = [ "vc4" ]; # `modprobe` later
    loader.raspberry-pi.bootloader = "kernelboot";
    initrd.systemd.enable = true;
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
