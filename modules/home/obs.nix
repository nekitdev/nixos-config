{ pkgs, currentPi, ... }: {
  programs.obs-studio =
    if currentPi then
      { }
    else
      {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-composite-blur
          obs-pipewire-audio-capture
          obs-vkcapture
        ];
      };
}
