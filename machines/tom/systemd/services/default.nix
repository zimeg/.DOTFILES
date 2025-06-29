# https://github.com/systemd/systemd
{ pkgs, ... }:
{
  systemd.services = {
    nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
      };
    };
    "slack:git" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      requiredBy = [
        "slack:snaek.service"
        "slack:tails.service"
      ];
      path = [
        pkgs.openssh
      ];
      serviceConfig = {
        ExecStart = "${pkgs.git}/bin/git pull origin main";
        Restart = "on-failure";
        User = "root";
        WorkingDirectory = /srv/slack;
      };
      unitConfig = {
        ConditionPathExists = /srv/slack;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
    "slack:snaek" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "default.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        EnvironmentFile = /srv/slack/py.bolt.snaek/.env;
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"python3 app.py\"";
        ExecStartPre = "${pkgs.ollama}/bin/ollama create snaek --file models/Modelfile";
        Restart = "always";
        RestartSec = 2;
        User = "root";
        WorkingDirectory = /srv/slack/py.bolt.snaek;
      };
      unitConfig = {
        ConditionPathExists = /srv/slack/py.bolt.snaek/.slack/hooks.json;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
    "slack:tails" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "default.target" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        EnvironmentFile = /srv/slack/js.bolt.tails/.env;
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"npm run start\"";
        ExecStartPre = "${pkgs.nix}/bin/nix develop --command bash -c \"npm ci --omit=dev --omit=optional\"";
        Restart = "always";
        RestartSec = 2;
        User = "root";
        WorkingDirectory = /srv/slack/js.bolt.tails;
      };
      unitConfig = {
        ConditionPathExists = /srv/slack/js.bolt.tails/.slack/hooks.json;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
  systemd.user.services = {
    "minecraft:backup" = {
      documentation = [ "https://github.com/zimeg/minecraft" ];
      wantedBy = [ "default.target" ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix develop .#backup --command bash -c \"./backup/backup.sh\"";
        WorkingDirectory = /home/ez/games/minecraft/server;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/games/minecraft/server/backup/backup.sh;
      };
    };
    "minecraft:server" = {
      documentation = [ "https://github.com/zimeg/minecraft" ];
      wantedBy = [ "default.target" ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"minecraft-server\"";
        Restart = "always";
        RestartSec = 2;
        WorkingDirectory = /home/ez/games/minecraft/server;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/games/minecraft/server/server.properties;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
