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
      wantedBy = [
        "multi-user.target"
      ];
      environment = {
        HOME = "/var/cache/quintus";
        XDG_CACHE_HOME = "/var/cache/quintus";
      };
      serviceConfig = {
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CacheDirectory = "quintus";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/quintus --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "quintus";
        Group = "quintus";
      };
    };
  };
}
