# DNS remains owned by shop/infra until an explicitly reviewed cutover.
{ config, lib, ... }:
let
  cfg = config.services.maintainers-coffee-proxy;
  environments = {
    production = {
      domain = "maintainers.coffee";
      port = 8084;
    };
    staging = {
      domain = "dev.maintainers.coffee";
      port = 8085;
    };
  };
  enabled = lib.filterAttrs (name: _: cfg.${name}.enable) environments;
in
{
  options.services.maintainers-coffee-proxy = lib.mapAttrs (name: defaults: {
    enable = lib.mkEnableOption "the ${name} maintainers.coffee proxy after DNS cutover";
    port = lib.mkOption {
      type = lib.types.port;
      default = defaults.port;
      description = "TOM WireGuard listener port.";
    };
  }) environments;
  config = lib.mkIf (enabled != { }) {
    security.acme.certs = lib.mapAttrs' (
      _: defaults:
      lib.nameValuePair defaults.domain {
        email = "zim@o526.net";
        group = "nginx";
      }
    ) enabled;
    services.nginx.virtualHosts = lib.mapAttrs' (
      name: defaults:
      lib.nameValuePair defaults.domain {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://10.100.0.2:${toString cfg.${name}.port}";
          proxyWebsockets = false;
          extraConfig = ''
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $host;
          '';
        };
      }
    ) enabled;
  };
}
