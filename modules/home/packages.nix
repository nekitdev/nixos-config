{ pkgs, currentPi, ... }:
let
  additional =
    if currentPi then
      [
        pkgs.spotatui
      ]
    else
      with pkgs;
      [
        # config
        yubioath-flutter
        # social
        telegram-desktop
        signal-desktop
        discord-canary
        # games
        osu-lazer-bin
        prismlauncher
        # music
        spotify
        # notes
        obsidian
        # design
        figma-linux
        # development
        postman
        typst
        tinymist
        # java
        jetbrains.idea
        # microcontrollers
        kicad-small
        stlink
      ];
in
{
  home.packages =
    with pkgs;
    [
      # development
      capnproto
      capnproto-rust
      clang
      clang-tools
      nixd
      typos
      typos-lsp
      taplo
      just
      uv
      meilisearch
      dioxus-cli
      tokei
      hexyl
      changelogging
    ]
    ++ additional;
}
