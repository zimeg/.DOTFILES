# https://github.com/maintainersdotcoffee/shop
{ config, pkgs, ... }:
{
  systemd.services = {
    "coffee" = {
      documentation = [ "https://github.com/maintainersdotcoffee/shop" ];
      wants = [ "network-online.target" ];
      after = [
        "network-online.target"
        "wireguard-wg0.service"
        "sops-nix.service"
      ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        APP_ENV = "production";
        APP_ORIGIN = "https://maintainers.coffee";
        HOME = "/var/cache/coffee";
        HOST = "10.100.0.2";
        NIX_USER_CONF_FILES = config.sops.templates."coffee".path;
        NODE_ENV = "production";
        PORT = "8084";
        XDG_CACHE_HOME = "/var/cache/coffee";
      };
      serviceConfig = {
        CacheDirectory = "coffee";
        CacheDirectoryMode = "0700";
        EnvironmentFile = config.sops.secrets."coffee/env".path;
        ExecStart = "${pkgs.nix}/bin/nix run github:maintainersdotcoffee/shop# --refresh";
        Group = "coffee";
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
        Restart = "on-failure";
        RestartSec = 120;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        UMask = "0077";
        User = "coffee";
      };
    };
  };
}
