{
  config,
  pkgs,
  currentPi,
  ...
}:
if currentPi then
  let
    unchecked-tuwunel = pkgs.matrix-tuwunel.overrideAttrs (old: {
      doCheck = false;
    });
  in
  {
    services.matrix-tuwunel = {
      enable = true;
      package = unchecked-tuwunel;
      settings = {
        global = {
          # allow registration with sops-managed token
          allow_registration = true;
          registration_token_file = "${config.sops.secrets.matrix.path}";
          # allow federation with other servers
          allow_federation = true;
          # allow encryption
          allow_encryption = true;
          # server setup
          server_name = "nekit.dev";
          address = [ "127.0.0.1" ];
          port = [ 6167 ];
          well_known = {
            client = "https://nekit.dev";
            server = "matrix.nekit.dev:443";
          };
          # requests
          max_request_size = 1073741824; # 1 GiB
        };
        misc = {
          new_user_displayname_prefix = "";
        };
      };
    };
  }
else
  { }
