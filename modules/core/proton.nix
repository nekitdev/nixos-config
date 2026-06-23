{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-pass
    proton-pass-cli
    proton-vpn
    proton-vpn-cli
    protonmail-desktop
    protonmail-bridge
  ];
}
