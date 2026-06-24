_: {
  imports = [
    # sops before others
    ./sops.nix
    # the rest of modules
    ./aliases.nix
    ./audio.nix
    ./boot.nix
    ./browsers.nix
    # ./cloudflared.nix
    ./fonts.nix
    ./gpg.nix
    ./greet.nix
    ./happd.nix
    ./hardware.nix
    ./home.nix
    ./keyboard.nix
    ./keyring.nix
    ./network.nix
    ./nh.nix
    ./nix-related.nix
    ./paths.nix
    ./proton.nix
    ./rust.nix
    ./security.nix
    ./ssh.nix
    ./steam.nix
    ./system.nix
    ./tailscale.nix
    ./tor.nix
    ./virtual.nix
    ./wm.nix
  ];
}
