# https://github.com/maintainersdotcoffee/shop
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.maintainers-coffee;
  environments = {
    production = {
      origin = "https://maintainers.coffee";
      port = 8084;
    };
    staging = {
      origin = "https://dev.maintainers.coffee";
      port = 8085;
    };
  };
  enabled = lib.filterAttrs (name: _: cfg.${name}.enable) environments;
  account = name: "coffee-${name}";
in
{
  options.services.maintainers-coffee = lib.mapAttrs (name: defaults: {
    enable = lib.mkEnableOption "the ${name} maintainers.coffee app";
    revision = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Reviewed shop commit (full SHA); required before enabling.";
    };
    sopsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Separate encrypted dotenv containing GitHub, Stripe and session secrets.";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = defaults.port;
      description = "WireGuard-only listener port; match the cloud proxy.";
    };
  }) environments;

  config = lib.mkMerge [
    {
      assertions =
        lib.flatten (
          lib.mapAttrsToList (name: _: [
            {
              assertion =
                !cfg.${name}.enable
                || (cfg.${name}.revision != null && builtins.match "[0-9a-f]{40}" cfg.${name}.revision != null);
              message = "maintainers-coffee ${name} requires a pinned 40-character commit.";
            }
            {
              assertion = !cfg.${name}.enable || cfg.${name}.sopsFile != null;
              message = "maintainers-coffee ${name} requires a real encrypted dotenv sopsFile.";
            }
          ]) environments
        )
        ++ [
          {
            assertion =
              !(cfg.production.enable && cfg.staging.enable)
              || (cfg.production.port != cfg.staging.port && cfg.production.sopsFile != cfg.staging.sopsFile);
            message = "maintainers-coffee environments require separate ports and secret files.";
          }
        ];
    }
    (lib.mkIf (enabled != { }) {
      networking.firewall.interfaces.wg0.allowedTCPPorts = lib.mapAttrsToList (
        name: _: cfg.${name}.port
      ) enabled;
      users = {
        users = lib.mapAttrs' (
          name: _:
          lib.nameValuePair (account name) {
            isSystemUser = true;
            group = account name;
            home = "/var/cache/${account name}";
          }
        ) enabled;
        groups = lib.mapAttrs' (name: _: lib.nameValuePair (account name) { }) enabled;
      };
      environment.persistence."/persistent".directories = lib.mapAttrsToList (name: _: {
        directory = "/var/lib/${account name}";
        user = account name;
        group = account name;
        mode = "0700";
      }) enabled;
      sops.secrets = lib.mapAttrs' (
        name: _:
        lib.nameValuePair "coffee/${name}/env" {
          format = "dotenv";
          key = "";
          owner = account name;
          group = account name;
          mode = "0400";
          sopsFile = cfg.${name}.sopsFile;
          restartUnits = [ "${account name}.service" ];
        }
      ) (lib.filterAttrs (name: _: cfg.${name}.sopsFile != null) enabled);
      systemd.services = lib.mapAttrs' (
        name: defaults:
        lib.nameValuePair (account name) {
          documentation = [ "https://github.com/maintainersdotcoffee/shop" ];
          wants = [ "network-online.target" ];
          after = [
            "network-online.target"
            "wireguard-wg0.service"
            "sops-nix.service"
          ];
          wantedBy = [ "multi-user.target" ];
          environment = {
            APP_ENV = name;
            APP_ORIGIN = defaults.origin;
            HOME = "/var/cache/${account name}";
            HOST = "10.100.0.2";
            NODE_ENV = "production";
            PORT = toString cfg.${name}.port;
            XDG_CACHE_HOME = "/var/cache/${account name}";
          };
          serviceConfig = {
            CacheDirectory = account name;
            CacheDirectoryMode = "0700";
            EnvironmentFile = "/run/secrets/coffee/${name}/env";
            ExecStart = "${pkgs.nix}/bin/nix run github:maintainersdotcoffee/shop/${toString cfg.${name}.revision}";
            Group = account name;
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
            StateDirectory = account name;
            StateDirectoryMode = "0700";
            SystemCallArchitectures = "native";
            UMask = "0077";
            User = account name;
            WorkingDirectory = "/var/lib/${account name}";
          };
        }
      ) enabled;
    })
  ];
}
