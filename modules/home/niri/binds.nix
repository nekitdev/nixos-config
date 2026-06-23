{ config, ... }:
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash" = {
      action = show-hotkey-overlay;
      hotkey-overlay.title = "Show binds";
    };

    "Mod+Return" = {
      action = spawn "kitty";
      hotkey-overlay.title = "Open kitty";
    };

    "Mod+Space" = {
      action = spawn "fuzzel";
      hotkey-overlay.title = "Open launcher";
    };

    "Mod+O" = {
      action = toggle-overview;
      repeat = false;
      hotkey-overlay.title = "Toggle overview";
    };

    "Mod+Q" = {
      action = close-window;
      repeat = false;
      hotkey-overlay.title = "Close window";
    };

    "Mod+Left" = {
      action = focus-column-left;
      hotkey-overlay.title = "Focus left";
    };
    "Mod+Down" = {
      action = focus-window-down;
      hotkey-overlay.title = "Focus down";
    };
    "Mod+Up" = {
      action = focus-window-up;
      hotkey-overlay.title = "Focus up";
    };
    "Mod+Right" = {
      action = focus-column-right;
      hotkey-overlay.title = "Focus right";
    };

    "Mod+Shift+Left" = {
      action = move-column-left;
      hotkey-overlay.title = "Move left";
    };
    "Mod+Shift+Down" = {
      action = move-window-down;
      hotkey-overlay.title = "Move down";
    };
    "Mod+Shift+Up" = {
      action = move-window-up;
      hotkey-overlay.title = "Move up";
    };
    "Mod+Shift+Right" = {
      action = move-column-right;
      hotkey-overlay.title = "Move right";
    };

    "Mod+Ctrl+Left" = {
      action = focus-monitor-left;
      hotkey-overlay.title = "Focus left monitor";
    };
    "Mod+Ctrl+Down" = {
      action = focus-monitor-down;
      hotkey-overlay.title = "Focus down monitor";
    };
    "Mod+Ctrl+Up" = {
      action = focus-monitor-up;
      hotkey-overlay.title = "Focus up monitor";
    };
    "Mod+Ctrl+Right" = {
      action = focus-monitor-right;
      hotkey-overlay.title = "Focus right monitor";
    };

    "Mod+Shift+Ctrl+Left" = {
      action = move-column-to-monitor-left;
      hotkey-overlay.title = "Move to monitor left";
    };
    "Mod+Shift+Ctrl+Down" = {
      action = move-column-to-monitor-down;
      hotkey-overlay.title = "Move to monitor down";
    };
    "Mod+Shift+Ctrl+Up" = {
      action = move-column-to-monitor-up;
      hotkey-overlay.title = "Move to monitor up";
    };
    "Mod+Shift+Ctrl+Right" = {
      action = move-column-to-monitor-right;
      hotkey-overlay.title = "Move to monitor right";
    };

    "Mod+Home" = {
      action = focus-column-first;
      hotkey-overlay.title = "Focus column first";
    };
    "Mod+End" = {
      action = focus-column-last;
      hotkey-overlay.title = "Focus column last";
    };

    "Mod+Shift+Home" = {
      action = move-column-to-first;
      hotkey-overlay.title = "Move column to first";
    };
    "Mod+Shift+End" = {
      action = move-column-to-last;
      hotkey-overlay.title = "Move column to last";
    };

    "Mod+Page_Down" = {
      action = focus-workspace-down;
      hotkey-overlay.title = "Focus workspace down";
    };
    "Mod+Page_Up" = {
      action = focus-workspace-up;
      hotkey-overlay.title = "Focus workspace up";
    };

    "Mod+Shift+Page_Down" = {
      action = move-column-to-workspace-down;
      hotkey-overlay.title = "Move to workspace down";
    };
    "Mod+Shift+Page_Up" = {
      action = move-column-to-workspace-up;
      hotkey-overlay.title = "Move to workspace up";
    };

    "Mod+Tab" = {
      action = focus-workspace-previous;
      hotkey-overlay.title = "Focus previous workspace";
    };

    "Mod+BracketLeft" = {
      action = consume-or-expel-window-left;
      hotkey-overlay.title = "Consume or expel window left";
    };
    "Mod+BracketRight" = {
      action = consume-or-expel-window-right;
      hotkey-overlay.title = "Consume or expel window right";
    };

    "Mod+R" = {
      action = switch-preset-column-width;
      hotkey-overlay.title = "Switch preset column width";
    };

    # "Mod+Ctrl+R" = {
    #   action = switch-preset-column-height;
    #   hotkey-overlay.title = "Switch preset column height";
    # };

    "Mod+Shift+R" = {
      action = reset-window-height;
      hotkey-overlay.title = "Reset window height";
    };

    "Mod+F" = {
      action = maximize-column;
      hotkey-overlay.title = "Maximize column";
    };
    "Mod+Ctrl+F" = {
      action = fullscreen-window;
      hotkey-overlay.title = "Fullscreen window";
    };
    "Mod+Shift+F" = {
      action = expand-column-to-available-width;
      hotkey-overlay.title = "Expand column to available width";
    };

    "Mod+C" = {
      action = center-column;
      hotkey-overlay.title = "Center column";
    };
    "Mod+Shift+C" = {
      action = center-visible-columns;
      hotkey-overlay.title = "Center visible columns";
    };

    "Mod+Minus" = {
      action = set-column-width "-10%";
      hotkey-overlay.title = "Decrease column width";
    };
    "Mod+Equal" = {
      action = set-column-width "+10%";
      hotkey-overlay.title = "Increase column width";
    };

    "Mod+Ctrl+Minus" = {
      action = set-window-height "-10%";
      hotkey-overlay.title = "Decrease window height";
    };
    "Mod+Ctrl+Equal" = {
      action = set-window-height "+10%";
      hotkey-overlay.title = "Increase window height";
    };

    "Mod+V" = {
      action = toggle-window-floating;
      hotkey-overlay.title = "Toggle window floating";
    };
    "Mod+Shift+V" = {
      action = switch-focus-between-floating-and-tiling;
      hotkey-overlay.title = "Switch focus between floating and tiling";
    };

    "Mod+W" = {
      action = toggle-column-tabbed-display;
      hotkey-overlay.title = "Toggle column tabbed display";
    };

    "Print" = {
      action = spawn-sh "niri msg action screenshot";
      hotkey-overlay.title = "Screenshot";
    };

    # "Print" = {
    #   action = screenshot;
    #   hotkey-overlay.title = "Screenshot";
    # };

    # "Ctrl+Print" = {
    #   action = screenshot-screen;
    #   hotkey-overlay.title = "Screenshot screen";
    # };

    # "Alt+Print" = {
    #   action = screenshot-window;
    #   hotkey-overlay.title = "Screenshot window";
    # };

    "Mod+Ctrl+Page_Down" = {
      action = move-workspace-down;
      hotkey-overlay.title = "Move workspace down";
    };
    "Mod+Ctrl+Page_Up" = {
      action = move-workspace-up;
      hotkey-overlay.title = "Move workspace up";
    };

    "Mod+WheelScrollDown" = {
      action = focus-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+WheelScrollUp" = {
      action = focus-workspace-up;
      cooldown-ms = 150;
    };
    "Mod+Shift+WheelScrollDown" = {
      action = move-column-to-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+Shift+WheelScrollUp" = {
      action = move-column-to-workspace-up;
      cooldown-ms = 150;
    };

    "Mod+1" = {
      action = focus-workspace 1;
    };
    "Mod+2" = {
      action = focus-workspace 2;
    };
    "Mod+3" = {
      action = focus-workspace 3;
    };
    "Mod+4" = {
      action = focus-workspace 4;
    };
    "Mod+5" = {
      action = focus-workspace 5;
    };
    "Mod+6" = {
      action = focus-workspace 6;
    };
    "Mod+7" = {
      action = focus-workspace 7;
    };
    "Mod+8" = {
      action = focus-workspace 8;
    };
    "Mod+9" = {
      action = focus-workspace 9;
    };

    "Mod+Escape" = {
      action = toggle-keyboard-shortcuts-inhibit;
      allow-inhibiting = false;
    };

    "Mod+Alt+L" = {
      action = spawn "swaylock";
      hotkey-overlay.title = "Lock screen";
    };

    "Mod+Alt+P" = {
      action = power-off-monitors;
      hotkey-overlay.title = "Power monitors off";
    };

    "Mod+Alt+Q" = {
      action = quit;
      hotkey-overlay.title = "Quit";
    };

    "XF86AudioRaiseVolume" = {
      action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ --limit 1.0";
      allow-when-locked = true;
    };
    "XF86AudioLowerVolume" = {
      action = spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      allow-when-locked = true;
    };
    "XF86AudioMute" = {
      action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      allow-when-locked = true;
    };
    "XF86AudioMicMute" = {
      action = spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      allow-when-locked = true;
    };

    "XF86AudioPlay" = {
      action = spawn-sh "playerctl play-pause";
      allow-when-locked = true;
    };
    "XF86AudioPause" = {
      action = spawn-sh "playerctl play-pause";
      allow-when-locked = true;
    };
    "XF86AudioPrev" = {
      action = spawn-sh "playerctl previous";
      allow-when-locked = true;
    };
    "XF86AudioNext" = {
      action = spawn-sh "playerctl next";
      allow-when-locked = true;
    };
  };
}
