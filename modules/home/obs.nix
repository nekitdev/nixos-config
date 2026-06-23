{ pkgs, ... }: {
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-composite-blur
      obs-move-transition
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };
}
