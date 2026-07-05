{ pkgs, ... }: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      services = {
        swaylock.enable = true;
      };
    };
    sudo.package = pkgs.sudo.override {
      withInsults = true;
    };
  };
}
