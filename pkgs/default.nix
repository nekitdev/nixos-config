{ pkgs, pi, ... }:
let
  packages = if pi then pkgs.linuxPackages_6_18 else pkgs.linuxPackages_latest;
in
{
  happ = pkgs.qt6.callPackage ./happ.nix { };

  rtw89 = pkgs.callPackage ./rtw89.nix {
    inherit (packages) kernel;
  };
}
