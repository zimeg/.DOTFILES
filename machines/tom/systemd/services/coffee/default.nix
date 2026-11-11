# https://github.com/maintainersdotcoffee/shop
{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      (pkgs.writeShellApplication {
        name = "coffee-logs";
        runtimeInputs = [ pkgs.socat ];
        text = ''
          exec socat -u "UNIX-CONNECT:/run/coffee-logs/''${1:-history}" STDOUT
        '';
      })
    ];
  };
  services = {
    logrotate = {
      settings = {
        coffee-dev = {
          files = [ "/var/lib/hermes/.local/state/coffee-dev/output.log" ];
          frequency = "daily";
          rotate = 7;
          maxsize = "10M";
          compress = true;
          delaycompress = true;
          copytruncate = true;
          missingok = true;
          notifempty = true;
          su = "hermes hermes";
        };
      };
    };
  };
  systemd = {
    tmpfiles = {
      rules = [ "d /run/coffee-logs 0750 root hermes -" ];
    };
    sockets =
      lib.mapAttrs'
        (
          name: _:
          lib.nameValuePair "coffee-logs-${name}" {
            description = "Coffee ${name} log reader";
            wantedBy = [ "sockets.target" ];
            listenStreams = [ "/run/coffee-logs/${name}" ];
            socketConfig = {
              Accept = true;
              MaxConnections = 4;
              RemoveOnStop = true;
              SocketGroup = "hermes";
              SocketMode = "0660";
              SocketUser = "root";
            };
          }
        )
        {
          follow = "--follow --no-tail";
          history = "";
        };
    services = {
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
    }
    //
      lib.mapAttrs'
        (
          name: args:
          lib.nameValuePair "coffee-logs-${name}@" {
            description = "Read only Coffee service journal records";
            serviceConfig = {
              # The client cannot supply arguments or broaden this trusted-field match.
              ExecStart = "${pkgs.systemd}/bin/journalctl --system --no-pager --all --output=json ${args} _SYSTEMD_UNIT=coffee.service";
              DynamicUser = true;
              NoNewPrivileges = true;
              PrivateDevices = true;
              PrivateTmp = true;
              ProtectHome = true;
              ProtectSystem = "strict";
              RestrictAddressFamilies = [ "AF_UNIX" ];
              StandardError = "journal";
              StandardInput = "socket";
              StandardOutput = "socket";
              SupplementaryGroups = [ "systemd-journal" ];
            };
          }
        )
        {
          follow = "--follow --no-tail";
          history = "";
        };
  };
}
