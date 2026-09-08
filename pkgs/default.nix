{ pkgs-stable, ... }:
{
  happ = pkgs-stable.qt6.callPackage ./happ.nix { };
}
