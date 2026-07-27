{
  pkgs,
  lib,
  currentName,
  ...
}:
{
  networking = {
    hostName = currentName;

    usePredictableInterfaceNames = false;

    useDHCP = lib.mkDefault true;

    # cloudflare <3
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # ssh
        80 # http
        443 # https
        8080 # alternative
      ];
      trustedInterfaces = [
        "virbr0" # virtualization
        "wlan1" # wifi
      ];
    };
  };

  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    mitmproxy
  ];
}
