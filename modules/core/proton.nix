{ pkgs, currentPi, ... }:
let
  additional =
    if currentPi then
      [ ]
    else
      with pkgs;
      [
        proton-pass
        protonmail-desktop
      ];
in
{
  environment.systemPackages =
    with pkgs;
    [
      proton-pass-cli
      proton-vpn
      proton-vpn-cli
      protonmail-bridge
    ]
    ++ additional;
}
