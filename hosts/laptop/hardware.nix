{
  config,
  lib,
  modulesPath,
  ...
}:
let
  notDetected = "/installer/scan/not-detected.nix";
in
{
  imports = [
    (modulesPath + notDetected)
  ];

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "ahci"
        "nvme"
        "usbhid"
      ];
      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"
      "rtw89_8922au_git"
    ];

    # disable power saving mode for rtw89
    extraModprobeConfig = ''
      options rtw89_core disable_ps_mode=y
    '';
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
