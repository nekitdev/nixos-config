{ pkgs, currentUser, ... }: {
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        user = currentUser;
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd niri-session";
      };
    };
  };
}
