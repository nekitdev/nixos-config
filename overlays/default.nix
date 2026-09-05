{ pkgs-stable, pi, ... }:
let
  pkgs-additions = self: _: import ../pkgs {
    inherit pkgs-stable pi;
    inherit (self) pkgs;
  };

  pi-modifications = _: super: {
    # not sure about this one
    gjs = super.gjs.overrideAttrs (old: {
      doCheck = false;
    });

    pythonPackagesExtensions = super.pythonPackagesExtensions ++ [
      (
        _: python-super: {
          # flaky tests
          cryptography = python-super.cryptography.overridePythonAttrs (old: {
            doCheck = false;
          });
          # same here
          anyio = python-super.anyio.overridePythonAttrs (old: {
            doCheck = false;
          });
          # and here
          uv = python-super.uv.overridePythonAttrs (old: {
            doCheck = false;
          });
          # tries to open display
          mss = python-super.mss.overridePythonAttrs(old: {
            doCheck = false;
          });
        }
      )
    ];
  };

  no-modifications = _: _: { };
in
{
  # adds custom packages as defined in `pkgs`
  additions = pkgs-additions;

  # modifies existing packages
  modifications = if pi then pi-modifications else no-modifications;
}
