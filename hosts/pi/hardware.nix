_: {
  boot = {
    initrd.systemd.enable = true;
    zfs.forceImportRoot = false;
  };

  systemd.services.zfs-mount.enable = false;

  # ignore partitions with "required partition" attribute
  services.udev.extraRules = ''
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
}
