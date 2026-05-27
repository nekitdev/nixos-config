{
  nixpkgs,
  nixpkgs-testing,
  overlays,
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
in
name:
{
  profile,
  system,
  pi ? defaultPi,
  user ? defaultUser,
  allowUnfree ? defaultAllowUnfree,
  specialArgs ? defaultSpecialArgs,
}:
let
  nixosSystem = nixpkgs.lib.nixosSystem;

  host = ../hosts/${name};

  provided = import ../overlays {
    inherit nixpkgs-testing allowUnfree;
  };

  mergedSpecialArgs = {
    inherit inputs;

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

    # apply overlays before anything else in order for them to be available globally
    {
      nixpkgs.overlays = overlays ++ builtins.attrValues provided;
    }

    # allow unfree packages is desired
    {
      nixpkgs.config.allowUnfree = allowUnfree;
    }

    # specify the host platform

    {
      nixpkgs.hostPlatform = system;
    }

    host

    # TODO: profiles, user and home-manager
  ];
}
