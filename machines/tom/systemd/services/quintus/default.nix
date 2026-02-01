# https://github.com/zimeg/quintus
{ pkgs, ... }:
{
  systemd.services = {
    "quintus" = {
      documentation = [ "https://github.com/zimeg/quintus" ];
      wants = [
        "network-online.target"
      ];
      after = [
        "network-online.target"
      ];
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/quintus --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "root";
      };
    };
  };
}
