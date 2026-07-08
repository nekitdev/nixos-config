{ pkgs, currentPi, ... }:
let

in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    extraModulePackages = [ pkgs.rtw89 ];

    loader = {
      # enable systemd-boot on non-pi
      systemd-boot.enable = !currentPi;
      efi.canTouchEfiVariables = true;
    };
  };
}
