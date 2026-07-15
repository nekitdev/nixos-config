_: {
  boot = {
    loader.raspberry-pi.bootloader = "kernel";
    initrd.systemd.enable = true;
    zfs.forceImportRoot = false;
  };
}
