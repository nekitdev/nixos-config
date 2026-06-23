{ pkgs, ... }:
let
  packages = pkgs.linuxPackages_latest;
in
{
  happ = pkgs.qt6.callPackage ./happ.nix { };

  rtw89 = pkgs.callPackage ./rtw89.nix {
    inherit (packages) kernel;
  };
}
