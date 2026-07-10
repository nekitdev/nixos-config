{ currentUser, stateVersion, ... }:
{
  nix = {
    settings = {
      # allow the current user to connect to nix
      allowed-users = [ currentUser ];
      # allow the current user to trust substituters
      trusted-users = [ currentUser ];

      # automatically optimize store
      auto-optimise-store = true;

      # enable the `nix` command and flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # UTC+3
  time.timeZone = "Europe/Moscow";

  # self-explanatory
  i18n.defaultLocale = "en_US.UTF-8";

  # set the state version
  system.stateVersion = stateVersion;
}
