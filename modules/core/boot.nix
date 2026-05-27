{pkgs, ...}:
let
  packages = pkgs.linuxPackages_latest;

  # kernel = packages.kernel

  # rtw89-nix = pkgs.callPackage ../../derivations/rtw89.nix {
  #   inherit kernel;
  # }
in
{
  boot = {
    kernelPackages = packages;

    # extraModulePackages = [ rtw89-nix ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
