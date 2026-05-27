{ pkgs, ... }:
let
  rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
in
{
  environment.systemPackages = [
    rust
  ];
}
