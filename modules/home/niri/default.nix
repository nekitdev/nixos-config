{
  pkgs,
  currentName,
  ...
}:
let
  image = ../../../wallpapers/dark.jpg;

  outputs = import ../../../hosts/${currentName}/outputs.nix { };
in
{
  imports = [
    ./binds.nix
  ];

  home.packages = with pkgs; [
    awww # wallpaper manager
    wl-clipboard # clipboard manager
    nautilus # file manager
  ];

  programs.niri = {
    enable = true;

    package = pkgs.niri-unstable;

    settings = {
      spawn-at-startup = [
        {
          # save text
          sh = "wl-paste --type text --watch cliphist store";
        }
        {
          # save images
          sh = "wl-paste --type image --watch cliphist store";
        }
        {
          # set wallpaper
          sh = "awww-daemon && awww img ${image}";
        }
      ];

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d@%H:%M:%S.png";

      prefer-no-csd = true;

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

      # simply inherit outputs
      inherit outputs;

      layout = {
        gaps = 16;

        center-focused-column = "never";

        preset-column-widths = [
          {
            proportion = 0.5;
          }
        ];

        # preset-column-heights = [
        #   {
        #     proportion = 0.5;
        #   }
        # ];

        default-column-width.proportion = 0.5;

        struts = {
          left = 16;
          right = 16;
        };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 10.0;
            bottom-right = 10.0;
            top-left = 10.0;
            top-right = 10.0;
          };
          clip-to-geometry = true;
          background-effect.blur = true;
        }
      ];
    };
  };
}
