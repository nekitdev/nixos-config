{
  config,
  pkgs,
  currentPi,
  ...
}:
let
  rtw89 = config.boot.kernelPackages.callPackage ../../kernel/rtw89.nix { };

  loader =
    if currentPi then
      {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      }
    else
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
in
{
  boot =
    if currentPi then
      { }
    else
      {
        binfmt.emulatedSystems = [ "aarch64-linux" ];

        kernelPackages = pkgs.linuxPackages_latest;
      }
      // {
        inherit loader;

        extraModulePackages = [ rtw89 ];

        # disable power saving mode for rtw89
        extraModprobeConfig = ''
          options rtw89_core_git disable_ps_mode=y
        '';
      };
}
