# https://github.com/zimeg/slacks
{ config, pkgs, ... }:
{
  systemd.services = {
    "todos" = {
      documentation = [ "https://todos.guide" ];
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      environment = {
        HOME = "/var/cache/todos";
        XDG_CACHE_HOME = "/var/cache/todos";
      };
      serviceConfig = {
        CacheDirectory = "todos";
        EnvironmentFile = config.sops.secrets."slack/todos".path;
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/slacks/todos#server --refresh";
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
        StateDirectory = "slack/todos";
        SystemCallArchitectures = "native";
        User = "todos";
        WorkingDirectory = "/var/lib/slack/todos";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
