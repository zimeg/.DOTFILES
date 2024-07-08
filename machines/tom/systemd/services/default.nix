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
    "slack:snaek" = {
      documentation = [ "https://github.com/zimeg/slack-sandbox" ];
      wantedBy = [ "default.target" ];
      path = [ pkgs.git ];
      serviceConfig = {
        EnvironmentFile = /home/ez/programming/slack/sandbox/py.bolt.snaek/.env.production;
        ExecStart = "${pkgs.nix}/bin/nix develop --command bash -c \"python3 app.py\"";
        Restart = "always";
        RestartSec = 2;
        WorkingDirectory = /home/ez/programming/slack/sandbox/py.bolt.snaek;
      };
      unitConfig = {
        ConditionPathExists = /home/ez/programming/slack/sandbox/py.bolt.snaek/slack.json;
        StartLimitBurst = 12;
        StartLimitIntervalSec = 24;
      };
    };
  };
}
