{ pkgs, currentPi, ... }:
let
  additional =
    if currentPi then
      with pkgs;
      [
        spotatui
      ]
    else
      with pkgs;
      [
        # social
        discord-canary
        # games
        osu-lazer-bin
        prismlauncher
        # music
        spotify
      ];
in
{
  home.packages =
    with pkgs;
    [
      # social
      telegram-desktop
      signal-desktop
      # config
      yubioath-flutter
      # notes
      obsidian
      # design
      figma-linux
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
      postman
      meilisearch
      typst
      tinymist
      dioxus-cli
      tokei
      hexyl
      changelogging
    ]
    ++ additional;
}
