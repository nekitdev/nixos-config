{
  # flakes
  nixpkgs,
  nixpkgs-testing,
  nixos-raspberrypi,
  overlays,
  disko,
  home-manager,
  sops-nix,
  # inputs
  inputs,
  ...
}:
let
  defaultPi = false;
  defaultUser = "nekit";
  defaultAllowUnfree = true;
  defaultSpecialArgs = { };
  defaultStateVersion = "26.11";
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

  provided = import ../overlays {
    inherit nixpkgs-testing allowUnfree pi;
  };

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
    sops-nix.nixosModules.sops

    # add disko
    disko.nixosModules.disko

    # add home-manager
    home-manager.nixosModules.home-manager

    {
      nixpkgs = {
        # apply overlays before anything else in order for them to be available globally
        overlays = overlays ++ builtins.attrValues provided;

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
