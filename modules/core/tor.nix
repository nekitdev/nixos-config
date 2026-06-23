{
  currentUser,
  ...
}:
let
  users = import ../../users {
    inherit currentUser;
  };

  info = users.current.info;
in
{
  services = {
    tor = {
      enable = true;
      openFirewall = true;

      relay = {
        enable = true;
        role = "relay";
      };

      settings = {
        ContactInfo = info.email;
        Nickname = currentUser;
        ORPort = 9001;
        ControlPort = 9051;
        BandwidthRate = "1 MBytes";
      };
    };
  };
}
