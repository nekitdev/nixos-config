{ pi, ... }:
let
  no-modifications = self: super: { };

  pi-modifications = self: super: {
    python3 = super.python3.override {
      packageOverrides = pySelf: pySuper: {
        cryptography = pySuper.cryptography.overrideAttrs(old: {
          doCheck = false;
        });
      };
    };
    python3Packages = self.python3.pkgs;
  };
in
{
  # adds custom packages as defined in `pkgs`
  additions =
    self: _:
    import ../pkgs {
      inherit pi;

      pkgs = self.pkgs;
    };

  # modifies existing packages
  modifications = if pi then pi-modifications else no-modifications;
}
