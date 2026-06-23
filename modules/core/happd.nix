{ pkgs, ... }: {
  systemd.services.happd = {
    description = "Happ Control Process Daemon";

    after = [ "network.target" ];

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = "${pkgs.happ}/bin/happd";
      Restart = "on-failure";
      RestartSec = 5;
      NoNewPrivileges = true;
      TimeoutStopSec = 10;
      KillMode = "mixed";
      KillSignal = "SIGTERM";
    };
  };

  environment.systemPackages = [ pkgs.happ ];
}
