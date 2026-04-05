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
        Group = "blog";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        Restart = "always";
        RestartSec = 120;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        User = "blog";
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
        Group = "blog";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        User = "blog";
      };
    };
  };
}
