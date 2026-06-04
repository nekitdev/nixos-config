{
  nixpkgs,
  nixpkgs-testing,
  overlays,
  disko,
  home-manager,
  sops-nix,
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
  profile,
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

  provided = import ../overlays {
    inherit nixpkgs-testing allowUnfree;
  };

  mergedSpecialArgs = {
    inherit inputs;

    inherit stateVersion;

    currentName = name;
    currentProfile = profile;
    currentSystem = system;
    currentUser = user;
    currentAllowUnfree = allowUnfree;
  }
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

    # TODO: profiles
  ];
}
