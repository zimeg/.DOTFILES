# https://github.com/zimeg/endpoints
{ pkgs, ... }:
{
  systemd.services = {
    "endpoints" = {
      documentation = [ "https://github.com/zimeg/endpoints" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      wantedBy = [
        "multi-user.target"
      ];
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/endpoints --refresh";
        Environment = "PORT=8083";
        Restart = "always";
        RestartSec = 2;
        User = "endpoints";
        Group = "endpoints";
      };
    };
  };
}
