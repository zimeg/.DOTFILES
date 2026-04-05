# https://github.com/zimeg/endpoints
{ pkgs, ... }:
{
  systemd.services = {
    "endpoints" = {
      documentation = [ "https://github.com/zimeg/endpoints" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      wantedBy = [
        "multi-user.target"
      ];
      environment = {
        HOME = "/var/cache/endpoints";
        PORT = "8083";
        XDG_CACHE_HOME = "/var/cache/endpoints";
      };
      serviceConfig = {
        CacheDirectory = "endpoints";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/endpoints --refresh";
        Group = "endpoints";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        Restart = "always";
        RestartSec = 120;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        User = "endpoints";
      };
    };
  };
}
