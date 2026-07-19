{ pi, ... }:
let
  pkgs-additions = self: _: import ../pkgs {
    inherit pi;
    inherit (self) pkgs;
  };

  no-modifications = _: _: { };
in
{
  # adds custom packages as defined in `pkgs`
  additions = pkgs-additions;

  # modifies existing packages
  modifications = no-modifications;
}
