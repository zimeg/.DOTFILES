# https://github.com/zimeg/slacks
{ config, pkgs, ... }:
{
  systemd.services = {
    "todos:production" = {
      documentation = [ "https://todos.guide" ];
      wantedBy = [ "default.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      serviceConfig = {
        EnvironmentFile = config.sops.secrets."slack/todos".path;
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/slack-sandbox/a#server --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "todos";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
