# https://github.com/zimeg/blog
{ pkgs, ... }:
{
  systemd.services = {
    "blog" = {
      documentation = [ "https://github.com/zimeg/blog" ];
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
        HOME = "/var/cache/blog";
        XDG_CACHE_HOME = "/var/cache/blog";
      };
      serviceConfig = {
        CacheDirectory = "blog";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/blog --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "blog";
        Group = "blog";
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
      environment = {
        HOME = "/var/cache/blog";
        XDG_CACHE_HOME = "/var/cache/blog";
      };
      serviceConfig = {
        CacheDirectory = "blog";
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/blog/dev --refresh -- --port 3000";
        User = "blog";
        Group = "blog";
      };
    };
  };
}
