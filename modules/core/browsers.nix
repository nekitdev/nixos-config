{ pkgs, currentPi, ... }:
let
  additional = if currentPi then [ ] else with pkgs; [ tor-browser ];
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  environment.systemPackages = additional;
}
