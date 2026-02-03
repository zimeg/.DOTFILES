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
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/blog --refresh";
        Restart = "always";
        RestartSec = 2;
        User = "root";
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
      serviceConfig = {
        ExecStart = "${pkgs.nix}/bin/nix run github:zimeg/blog/dev --refresh -- --port 3000";
        User = "root";
      };
    };
  };
}
