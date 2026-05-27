{ nixpkgs-testing, allowUnfree, ... }:
{
  # adds custom packages as defined in `pkgs`
  additions =
    self: _:
    import ../pkgs {
      pkgs = self.pkgs;
    };

  # modifies existing packages
  modifications = self: super: { };

  # makes `nixpkgs-testing` (in the flake inputs) available through `pkgs.testing`
  testing = self: _: {
    testing = import nixpkgs-testing {
      system = self.system;
      config.allowUnfree = allowUnfree;
    };
  };
}
