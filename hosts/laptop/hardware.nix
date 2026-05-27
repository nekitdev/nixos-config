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

    kernelModules = [ "kvm-intel" ];

    # TODO: rtw89
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
