# https://github.com/systemd/systemd
{ pkgs }:
{
  systemd.services = {
    nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
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
    "slack:git" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
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
        RestartSec = 2;
        WorkingDirectory = /home/ez/productions/slack/sandbox;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/productions/slack/sandbox;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
    "slack:snaek" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "default.target" ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        EnvironmentFile = /home/ez/productions/slack/sandbox/py.bolt.snaek/.env.production;
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"python3 app.py\"";
        Restart = "always";
        RestartSec = 2;
        WorkingDirectory = /home/ez/productions/slack/sandbox/py.bolt.snaek;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/productions/slack/sandbox/py.bolt.snaek/.slack/hooks.json;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
    "slack:tails" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "default.target" ];
      path = [
        pkgs.git
      ];
      serviceConfig = {
        EnvironmentFile = /home/ez/productions/slack/sandbox/js.bolt.tails/.env.production;
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"npm run start\"";
        ExecStartPre = "${pkgs.nix}/bin/nix develop --command bash -c \"npm ci --omit=dev --omit=optional\"";
        Restart = "always";
        RestartSec = 2;
        WorkingDirectory = /home/ez/productions/slack/sandbox/js.bolt.tails;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/productions/slack/sandbox/js.bolt.tails/.slack/hooks.json;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
