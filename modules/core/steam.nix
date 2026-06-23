_: {
  programs = {
    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };

    gamescope = {
      enable = true;

      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
}
