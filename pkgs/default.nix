{ pkgs, ... }:
{
  happ = pkgs.qt6.callPackage ./happ.nix { };
}
