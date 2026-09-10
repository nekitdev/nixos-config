{ lib, ... }:
let
  modules = [
    "ahci"
    "ata_piix"
    "autofs"
    "clk-rp1"
    "efivarfs"
    "ehci_hcd"
    "ehci_pci"
    "hid_generic"
    "hid_logitech_hidpp"
    "mmc_block"
    "nvme"
    "ohci_hcd"
    "ohci_pci"
    "pata_marvell"
    "pcie-brcmstb"
    "rp1"
    "sata_nv"
    "sata_sis"
    "sata_uli"
    "sata_via"
    "sd_mod"
    "sr_mod"
    "uhci_hcd"
    "usb-storage"
    "usbhid"
    "vc4"
    "xhci_hcd"
    "xhci_pci"
  ];
in
{
  boot = {
    initrd = {
      availableKernelModules = lib.mkForce modules;
      systemd.enable = true;
    };
    zfs.forceImportRoot = false;
  };

  hardware.raspberry-pi.firmware = {
    enable = true;
    uboot.enable = true;
  };

  systemd.services.zfs-mount.enable = false;

  # ignore partitions with "required partition" attribute
  services.udev.extraRules = ''
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
}
