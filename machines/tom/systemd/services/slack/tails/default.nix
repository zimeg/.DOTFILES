# https://github.com/zimeg/slack-sandbox
{ config, pkgs, ... }:
{
  systemd.services = {
    "tails" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      path = [ pkgs.bash pkgs.nodejs ];
      environment = {
        HOME = "/var/cache/tails";
        XDG_CACHE_HOME = "/var/cache/tails";
      };
      serviceConfig = {
        CacheDirectory = "tails";
        EnvironmentFile = config.sops.secrets."slack/tails".path;
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/slacks/js.bolt.tails --refresh";
        Restart = "always";
        RestartSec = 120;
        StateDirectory = "slack/tails";
        User = "tails";
        WorkingDirectory = "/var/lib/slack/tails";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
