{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libnotify
    xwayland-satellite
  ];
}
