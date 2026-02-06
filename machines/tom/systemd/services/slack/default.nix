# https://github.com/zimeg/slack-sandbox
{ pkgs, ... }:
{
  systemd.services = {
    "snaek" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
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
        EnvironmentFile = "/run/secrets/slack/snaek";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/slacks/py.bolt.snaek --refresh";
        Restart = "always";
        RestartSec = 120;
        StateDirectory = "slack/snaek";
        User = "snaek";
        WorkingDirectory = "/var/lib/slack/snaek";
      };
      unitConfig = {
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
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
        EnvironmentFile = "/run/secrets/slack/tails";
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
