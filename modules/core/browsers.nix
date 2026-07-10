{ pkgs, currentPi, ... }:
let
  additional = if currentPi then [ ] else [ pkgs.tor-browser ];
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  environment.systemPackages = additional;
}
