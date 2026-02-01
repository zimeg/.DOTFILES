# https://github.com/systemd/systemd
{ pkgs, inputs, ... }:
{
  systemd.services = {
    nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
      };
    };
    "blog" = {
      documentation = [ "https://github.com/zimeg/blog" ];
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
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"npm run host\"";
        ExecStartPre = [
          "${pkgs.git}/bin/git pull origin main"
          "${pkgs.nix}/bin/nix develop --command bash -c \"npm ci --omit=dev\""
          "${pkgs.nix}/bin/nix develop --command bash -c \"npm run build\""
        ];
        Restart = "always";
        RestartSec = 2;
        User = "root";
        WorkingDirectory = /srv/blog;
      };
    };
    "blog:preview" = {
      documentation = [ "https://github.com/zimeg/blog" ];
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
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"npm run host -- --port 3000\"";
        ExecStartPre = [
          "${pkgs.git}/bin/git fetch blog"
          "${pkgs.git}/bin/git checkout blog/dev"
          "${pkgs.git}/bin/git reset --hard blog/dev"
          "${pkgs.nix}/bin/nix develop --command bash -c \"npm ci --omit=dev\""
          "${pkgs.nix}/bin/nix develop --command bash -c \"npm run build\""
        ];
        User = "root";
        WorkingDirectory = /srv/development;
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
        "ollama.service"
      ];
      after = [
        "network-online.target"
        "ollama.service"
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
    "quintus" = {
      documentation = [ "https://github.com/zimeg/quintus" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      serviceConfig = {
        ExecStart = "${inputs.quintus.packages.${pkgs.system}.default}/bin/quintus";
        Restart = "always";
        RestartSec = 2;
        User = "root";
      };
    };
  };
}
