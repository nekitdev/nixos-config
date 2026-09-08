{
  description = "NixOS configuration by nekitdev";

  nixConfig = {
    extra-substituters = [
      # community cache
      # "https://nix-community.cachix.org"
      # main cache
      # "https://cache.nekit.dev"
    ];
    extra-trusted-public-keys = [
      # community cache
      # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # main cache
      # "cache.nekit.dev-1:Bp0/bwOBNHle6gaxPfdjtk5EI8uXm8d8NuyFz4/l7eE="
    ];
  };

  inputs = {
    # primary nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixos hardware (used for pi)

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stable nixpkgs channel
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

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

    # shell to use with niri

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixos-hardware,
      disko,
      home-manager,
      sops-nix,
      niri,
      rust-overlay,
      ...
    }@inputs:
    let
      mkSystem = import ./lib/system.nix {
        inherit
          nixpkgs
          nixpkgs-stable
          nixos-hardware
          disko
          home-manager
          sops-nix
          niri
          rust-overlay
          inputs
          ;
      };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem "laptop" {
          system = "x86_64-linux";
        };
        pi = mkSystem "pi" {
          system = "aarch64-linux";
          pi = true;
        };
      };
    };
}
