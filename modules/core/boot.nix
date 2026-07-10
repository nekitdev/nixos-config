{ pkgs, currentPi, ... }:
let
  kernel = if currentPi then pkgs.linuxPackages_6_18 else pkgs.linuxPackages_latest;
in
{
  boot = {
    kernelPackages = kernel;

    extraModulePackages = [ pkgs.rtw89 ];

    loader = {
      # enable systemd-boot on non-pi
      systemd-boot.enable = !currentPi;
      efi.canTouchEfiVariables = true;
    };
  };
}
