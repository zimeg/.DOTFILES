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
  };
}
