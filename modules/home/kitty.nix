_: {
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;

    enableGitIntegration = true;

    settings = {
      font_size = 14;
      confirm_os_window_close = 0;
      cursor_trail = 1;
      hide_window_decorations = "yes";
      background_opacity = 0.8;

      # TODO: add more settings?
    };
  };
}
