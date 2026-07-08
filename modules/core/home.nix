{
  pkgs,
  config,
  inputs,
  currentName,
  currentSystem,
  currentPi,
  currentUser,
  currentAllowUnfree,
  stateVersion,
  ...
}:
let
  users = import ../../users {
    inherit currentUser;
  };

  info = users.current.info;
in
{
  home-manager = {
    # packages
    useUserPackages = true;
    useGlobalPkgs = true;

    # backups
    backupFileExtension = "backup";

    # special args
    extraSpecialArgs = {
      inherit
        currentName
        currentSystem
        currentPi
        currentUser
        currentAllowUnfree
        ;

      inherit stateVersion;
    };

    # users
    users.${currentUser} = {
      imports = [
        # niri
        inputs.niri.homeModules.niri
        # home
        ../home
      ];

      home = {
        username = currentUser;
        homeDirectory = "/home/${currentUser}";

        inherit stateVersion;
      };

      programs.home-manager.enable = true;
    };
  };

  users = {
    # `fish` is the default shell
    defaultUserShell = pkgs.fish;

    # allow mutable users
    mutableUsers = true;

    # users
    users.${currentUser} = {
      # normal user
      isNormalUser = true;

      # do not create password files, `sops` will handle that
      hashedPasswordFile = config.sops.secrets.password.path;

      # set description to full name
      description = info.name;

      extraGroups = [
        "adbusers" # android
        "docker" # allow docker as non-root
        "libvirtd" # virtualization
        "lp" # parallel port devices
        "networkmanager" # network
        "scanner" # self-explanatory
        "wheel" # `sudo` access
      ];
    };
  };

  # enable `fish`
  programs.fish.enable = true;
}
