{ currentUser, ... }:
let
  users = import ../../users {
    inherit currentUser;
  };
  info = users.current.info;
in
{
  programs = {
    gh = {
      enable = true;
      settings = {
        editor = "hx";
      };
    };

    git = {
      enable = true;

      lfs.enable = true;

      signing = {
        format = "openpgp";
        key = info.fingerprint;
        signByDefault = true;
      };

      settings = {
        core = {
          editor = "hx";
          autocrlf = "input";
        };

        user = {
          name = info.name;
          email = info.email;
        };

        init.defaultBranch = "main";
      };
    };
  };
}
