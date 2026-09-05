{
  # flakes
  nixpkgs,
  nixpkgs-stable,
  # nixpkgs-pi,
  nixos-raspberrypi,
  disko,
  disko-pi,
  home-manager,
  home-manager-pi,
  sops-nix,
  sops-nix-pi,
  niri,
  niri-pi,
  rust-overlay,
  rust-overlay-pi,
  # inputs
  inputs,
  ...
}:
let
  defaultPi = false;
  defaultUser = "nekit";
  defaultAllowUnfree = true;
  defaultSpecialArgs = { };
  defaultStateVersion = "26.05";
in
name:
{
  system,
  pi ? defaultPi,
  user ? defaultUser,
  allowUnfree ? defaultAllowUnfree,
  specialArgs ? defaultSpecialArgs,
  stateVersion ? defaultStateVersion,
}:
let
  nixSystem = nixpkgs.lib.nixosSystem;
  piSystem = nixos-raspberrypi.lib.nixosSystemFull;

  nixosSystem = if pi then piSystem else nixSystem;

  host = ../hosts/${name};
  core = ../modules/core;

  pkgs-stable = import nixpkgs-stable {
    inherit system;

    config.allowUnfree = allowUnfree;

    hostPlatform = system;
  };

  disko-system = if pi then disko-pi else disko;
  home-manager-system = if pi then home-manager-pi else home-manager;
  sops-nix-system = if pi then sops-nix-pi else sops-nix;
  niri-system = if pi then niri-pi else niri;
  rust-overlay-system = if pi then rust-overlay-pi else rust-overlay;

  defined = [
    niri-system.overlays.niri
    rust-overlay-system.overlays.default
  ];

  provided = import ../overlays {
    inherit pkgs-stable pi;
  };

  overlays = defined ++ builtins.attrValues provided;

  piSpecialArgs =
    if pi then
      {
        rpi = nixos-raspberrypi;
      }
    else
      { };

  mergedSpecialArgs = {
    inherit inputs;

    inherit stateVersion;

    inherit pkgs-stable;

    currentName = name;
    currentSystem = system;
    currentPi = pi;
    currentUser = user;
    currentAllowUnfree = allowUnfree;
  }
  // piSpecialArgs
  // specialArgs;
in
nixosSystem {
  inherit system;

  specialArgs = mergedSpecialArgs;

  modules = [
    # add sops
    sops-nix-system.nixosModules.sops

    # add disko
    disko-system.nixosModules.disko

    # add home-manager
    home-manager-system.nixosModules.home-manager

    {
      nixpkgs = {
        inherit overlays;

        # allow unfree packages if desired
        config.allowUnfree = allowUnfree;

        # specify the host platform
        hostPlatform = system;
      };
    }

    # host-specific configuration
    host

    # generic configuration
    core
  ];
}
