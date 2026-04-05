# https://github.com/zimeg/slacks
{ config, pkgs, ... }:
{
  systemd.services = {
    "snaek" = {
      documentation = [ "https://github.com/zimeg/slacks" ];
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
        "ollama.service"
      ];
      after = [
        "network-online.target"
        "ollama.service"
      ];
      environment = {
        DATABASE_PATH = "/var/lib/slack/snaek/caduceus.db";
        HOME = "/var/cache/snaek";
        XDG_CACHE_HOME = "/var/cache/snaek";
      };
      serviceConfig = {
        CacheDirectory = "snaek";
        EnvironmentFile = config.sops.secrets."slack/snaek".path;
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/slacks/snaek --refresh";
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
        StateDirectory = "slack/snaek";
        SystemCallArchitectures = "native";
        User = "snaek";
        WorkingDirectory = "/var/lib/slack/snaek";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
