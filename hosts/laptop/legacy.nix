_: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/687eff8f-70ff-4584-8af0-97e3815973b0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4FC1-4336";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/9ff81834-d54d-4278-aa4b-6bb07fa56343"; }
  ];
}
