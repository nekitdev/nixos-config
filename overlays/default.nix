{ pi, ... }: {
  # adds custom packages as defined in `pkgs`
  additions =
    self: _:
    import ../pkgs {
      inherit pi;

      pkgs = self.pkgs;
    };

  # modifies existing packages
  modifications = self: super: { };
}
