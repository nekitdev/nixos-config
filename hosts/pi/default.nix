{ rpi, ... }: {
  imports = with rpi.nixosModules; [
    # raspberry pi 5
    raspberry-pi-5.base
    raspberry-pi-5.display-vc4
    raspberry-pi-5.bluetooth
    raspberry-pi-5.page-size-16k
    # config.txt
    ./config.nix
    # disks
    ./disko.nix
    # hardware
    ./hardware.nix
    # network
    ./network.nix
  ];
}
