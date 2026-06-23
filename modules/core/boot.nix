{ pkgs, ... }:
let

in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    extraModulePackages = [ pkgs.rtw89 ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
