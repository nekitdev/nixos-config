{ pkgs, ... }: {
  home.packages = with pkgs; [
    # social
    discord-canary
    telegram-desktop
    signal-desktop
    # games
    osu-lazer-bin
    prismlauncher
    # music
    spotify
    # config
    yubioath-flutter
    # notes
    obsidian
    # design
    figma-linux
    # development
    omnisharp-roslyn
    capnproto
    capnproto-rust
    avalonia
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
    changelogging
  ];
}
