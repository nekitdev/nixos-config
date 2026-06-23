{ pkgs, ... }:
let
  transparent = "00000000";
  translucent = "0000007f";

  red = "ff00007f";
  yellow = "ffff007f";
  green = "00ff007f";
  blue = "0000ff7f";
  text = "ffffffff";
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      indicator = true;

      disable-caps-lock-text = true;

      ignore-empty-password = true;
      show-failed-attempts = true;

      show-keyboard-layout = true;

      image = ../../wallpapers/lock.jpg;

      color = transparent;
      font = "Fira Mono";
      font-size = 20;

      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 10;

      inside-color = translucent;
      inside-clear-color = yellow;
      inside-ver-color = blue;
      inside-wrong-color = red;

      bs-hl-color = red;
      key-hl-color = green;

      layout-bg-color = transparent;
      layout-border-color = transparent;
      layout-text-color = text;

      line-color = transparent;
      line-clear-color = transparent;
      line-ver-color = transparent;
      line-wrong-color = transparent;

      ring-color = translucent;
      ring-clear-color = translucent;
      ring-ver-color = translucent;
      ring-wrong-color = translucent;

      separator-color = transparent;

      text-color = text;
      text-clear-color = text;
      text-ver-color = text;
      text-wrong-color = text;
    };
  };
}
