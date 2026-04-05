# https://github.com/zimeg/quintus
{ pkgs, ... }:
{
  systemd.services = {
    "quintus" = {
      documentation = [ "https://github.com/zimeg/quintus" ];
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
        HOME = "/var/cache/quintus";
        XDG_CACHE_HOME = "/var/cache/quintus";
      };
      serviceConfig = {
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CacheDirectory = "quintus";
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/quintus --refresh";
        Group = "quintus";
        LockPersonality = true;
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
        User = "quintus";
      };
    };
  };
}
