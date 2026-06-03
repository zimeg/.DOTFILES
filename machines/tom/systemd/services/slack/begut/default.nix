# https://github.com/zimeg/slack-sandbox
{ config, pkgs, ... }:
{
  systemd.services = {
    "begut" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      path = [
        pkgs.git
        pkgs.openssh
      ];
      environment = {
        GIT_AUTHOR_EMAIL = "tom@deorr.co";
        GIT_AUTHOR_NAME = "@theorderingmachine";
        GIT_COMMITTER_EMAIL = "tom@deorr.co";
        GIT_COMMITTER_NAME = "@theorderingmachine";
        GIT_SSH_COMMAND = "${pkgs.openssh}/bin/ssh -i ${config.sops.secrets."slack/begut/ssh/private".path} -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=/var/lib/slack/begut/.ssh/known_hosts";
        HOME = "/var/cache/begut";
        XDG_CACHE_HOME = "/var/cache/begut";
      };
      serviceConfig = {
        CacheDirectory = "begut";
        EnvironmentFile = config.sops.secrets."slack/begut/env".path;
        ExecStart = "${pkgs.nix}/bin/nix run 'github:zimeg/slack-sandbox?ref=c&dir=py.bolt.begut' --refresh";
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
        StateDirectory = "slack/begut";
        SystemCallArchitectures = "native";
        User = "begut";
        WorkingDirectory = "/var/lib/slack/begut";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
