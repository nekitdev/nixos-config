{ pkgs, currentPi, ... }:
if currentPi then
  { }
else
  {
    programs.vscode = {
      enable = true;

      profiles.default.extensions = with pkgs.vscode-extensions; [
        platformio.platformio-vscode-ide
      ];
    };
  }
