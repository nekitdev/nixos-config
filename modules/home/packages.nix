{ pkgs, currentPi, ... }:
let
  just-unchecked = pkgs.just.overrideAttrs (old: {
    doCheck = false;
  });

  additional =
    if currentPi then
      [
        pkgs.spotatui
      ]
    else
      with pkgs;
      [
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
        clang
        clang-tools
        postman
        typst
        tinymist
        # microcontrollers
        kicad-small
        stlink
      ];
in
{
  home.packages =
    with pkgs;
    [
      # config
      yubioath-flutter
      # development
      capnproto
      capnproto-rust
      nixd
      typos
      typos-lsp
      taplo
      just-unchecked
      uv
      meilisearch
      dioxus-cli
      tokei
      hexyl
      changelogging
    ]
    ++ additional;
}
