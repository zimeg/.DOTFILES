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
      environment = {
        HOME = "/var/cache/endpoints";
        PORT = "8083";
        XDG_CACHE_HOME = "/var/cache/endpoints";
      };
      serviceConfig = {
        CacheDirectory = "endpoints";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/endpoints --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "endpoints";
        Group = "endpoints";
      };
    };
  };
}
