{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  environment.systemPackages = with pkgs; [
    tor-browser
  ];
}
