{
  description = "NixOS configuration by nekitdev";

  nixConfig = {
    extra-substituters = [
      "https://nekitdev-pi.cachix.org"
      "https://nekitbot-pi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nekitdev-pi.cachix.org-1:+8KLtRZ1lDW2gNXyxwe/uSVr4coYmZZrOcoNxf5HnRQ="
      "nekitbot-pi.cachix.org-1:tQFIFF7zpVUt+5FGLbZeRAsOUq0srZt248QdDE/ObkA="
    ];
  };

  inputs = {
    # primary nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs for testing purposes
    nixpkgs-testing.url = "github:nixos/nixpkgs";

    # nixos for raspberry pi
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:epireyn/niri-flake";
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
      nixos-raspberrypi,
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
          nixos-raspberrypi
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
        };
        pi = mkSystem "pi" {
          system = "aarch64-linux";
          pi = true;
        };
      };
    };
}
