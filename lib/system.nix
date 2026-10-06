{
  # flakes
  nixpkgs,
  nixpkgs-stable,
  nixos-hardware,
  disko,
  home-manager,
  sops-nix,
  niri,
  rust-overlay,
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
  nixosSystem = nixpkgs.lib.nixosSystem;

  host = ../hosts/${name};
  core = ../modules/core;

  pkgs-stable = import nixpkgs-stable {
    inherit system;

    config.allowUnfree = allowUnfree;

    hostPlatform = system;
  };

  base =
    if pi then
      [
        nixos-hardware.nixosModules.raspberry-pi-5
      ]
    else
      [ ];

  defined = [
    niri.overlays.niri
    rust-overlay.overlays.default
  ];

  provided = import ../overlays { };

  overlays = defined ++ builtins.attrValues provided;

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
  // specialArgs;
in
nixosSystem {
  inherit system;

  specialArgs = mergedSpecialArgs;

  modules = base ++ [
    # add sops
    sops-nix.nixosModules.sops

    # add disko
    disko.nixosModules.disko

    # add home-manager
    home-manager.nixosModules.home-manager

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
