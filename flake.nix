{
  description = "NixOS configuration by nekitdev";

  nixConfig = {
    extra-substituters = [
      # additional caches
      # "https://nekitdev-pi.cachix.org"
      # "https://nekitbot-pi.cachix.org"
      # main cache
      "https://cache.nekit.dev"
    ];
    extra-trusted-public-keys = [
      # additional caches
      # "nekitdev-pi.cachix.org-1:+8KLtRZ1lDW2gNXyxwe/uSVr4coYmZZrOcoNxf5HnRQ="
      # "nekitbot-pi.cachix.org-1:tQFIFF7zpVUt+5FGLbZeRAsOUq0srZt248QdDE/ObkA="
      # main caches
      "cache.nekit.dev-1:Bp0/bwOBNHle6gaxPfdjtk5EI8uXm8d8NuyFz4/l7eE="
    ];
  };

  # NOTE: when bumping `nixpkgs-pi`, also update `home-manager-pi` :)

  inputs = {
    # primary nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs for pi
    nixpkgs-pi.url = "github:nixos/nixpkgs/nixos-26.05";

    # nixos for raspberry pi
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };

    # declarative disk management

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko-pi = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };

    # home manager is used to configure non-core aspects of the system

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-pi = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };

    # secure secrets storage

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix-pi = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };

    # niri is an amazing compositor! ~ nekit

    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-pi = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };

    # up-to-date rust toolchains

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay-pi = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-pi";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-pi,
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
      ...
    }@inputs:
    let
      mkSystem = import ./lib/system.nix {
        inherit
          nixpkgs
          nixpkgs-pi
          nixos-raspberrypi
          disko
          disko-pi
          home-manager
          home-manager-pi
          sops-nix
          sops-nix-pi
          niri
          niri-pi
          rust-overlay
          rust-overlay-pi
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
