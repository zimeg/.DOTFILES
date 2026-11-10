{ lib, pkgs, ... }:
let
  readers = {
    follow = "--follow --no-tail";
    history = "";
  };
in
{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "coffee-logs";
      runtimeInputs = [ pkgs.socat ];
      text = ''
        case "''${1:-history}" in
          history|follow) mode="''${1:-history}" ;;
          *) echo 'usage: coffee-logs [history|follow]' >&2; exit 2 ;;
        esac
        if [ "$#" -gt 1 ]; then
          echo 'usage: coffee-logs [history|follow]' >&2
          exit 2
        fi
        exec socat -u "UNIX-CONNECT:/run/coffee-logs/$mode" STDOUT
      '';
    })
  ];

  services.logrotate.settings.coffee-dev = {
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

  systemd = {
    tmpfiles.rules = [ "d /run/coffee-logs 0750 root hermes -" ];
    sockets = lib.mapAttrs' (
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
    ) readers;
    services = lib.mapAttrs' (
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
    ) readers;
  };
}
