_: {
  boot = {
    kernelModules = [
      "rtw89_8922au_git"
    ];
    extraModprobeConfig = ''
      options rtw89_core disable_ps_mode=y
    '';
    loader.raspberry-pi.bootloader = "kernel";
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
