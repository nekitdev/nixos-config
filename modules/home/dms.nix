{ config, pkgs, currentName, ... }:
let
  outputs = import ../../hosts/${currentName}/outputs.nix { };
in
{
  programs = {
    niri = {
      enable = true;

      package = pkgs.niri-unstable;

      settings = {
        prefer-no-csd = true;

        screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d@%H:%M:%S.png";

        hotkey-overlay.skip-at-startup = true;

        input = {
          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:alt_shift_toggle";
            };

            repeat-delay = 500;
            repeat-rate = 30;
          };

          touchpad = {
            tap = true;
            natural-scroll = true;
          };

          focus-follows-mouse.enable = true;
        };

        inherit outputs;

        layout = {
          gaps = 4;

          preset-column-widths = [
            {
              proportion = 0.5;
            }
          ];

          default-column-width.proportion = 0.5;

          struts = {
            left = 4;
            right = 4;
          };
        };

        binds = with config.lib.niri.actions; {
          "Mod+Return" = {
            action = spawn "kitty";
            hotkey-overlay.title = "Open terminal";
          };
        };
      };
    };

    dank-material-shell = {
      enable = true;

      enableSystemMonitoring = true;
      enableVPN = false;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = false;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      niri = {
        enableSpawn = false; # systemd handles startup
        enableKeybinds = false; # handled by `includes`
        includes = {
          enable = true;
          override = true;
          originalFileName = "niri-flake";
          filesToInclude = [
            "alttab" # alt-tab functionality
            "binds" # keybinds
            "colors" # colors
            "cursor" # cursor settings
            "layout" # layout settings
            "windowrules" # window rules
          ];
        };
      };
    };
  };
}
