{
  description = "NixOS configuration by nekitdev";

  inputs = {
    # primary nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # secrets.url = "github:nekitdev/secrets";

    # nixpkgs for testing purposes
    nixpkgs-testing.url = "github:nixos/nixpkgs";

    # declarative disk management
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home manager is used to configure non-core aspects of the system
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secure secrets storage
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri is an amazing compositor! ~ nekit
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # up-to-date rust toolchains
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-testing,
      disko,
      home-manager,
      sops-nix,
      niri,
      rust-overlay,
      ...
    }@inputs:
    let
      overlays = [
        rust-overlay.overlays.default
        niri.overlays.niri
      ];

      mkSystem = import ./lib/system.nix {
        inherit
          nixpkgs
          nixpkgs-testing
          overlays
          disko
          home-manager
          sops-nix
          inputs
          ;
      };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem "laptop" {
          system = "x86_64-linux";
          profile = "nvidia-laptop";
        };
        # pi = mkSystem "pi" {
        #   system = "aarch64-linux";
        #   profile = "pi";
        # };
      };
    };
}
