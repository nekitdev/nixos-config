{ pkgs, currentUser, ... }:
{
  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };

    flake = "/home/${currentUser}/Documents/nixos-config";
  };

  environment.systemPackages = [ pkgs.nix-output-monitor ];
}
