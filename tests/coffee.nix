# Evaluation-only fixtures reference existing encrypted files; never activate them.
let
  flake = builtins.getFlake (toString ../.);
  lib = flake.inputs.nixpkgs.lib;
  base = flake.nixosConfigurations.tom;
  revision = "112bdbec6930f610e52995226cf4cf0477ab75f1";
  enabled = base.extendModules {
    modules = [
      {
        services.maintainers-coffee = {
          production = {
            enable = true;
            inherit revision;
            sopsFile = ../machines/tom/systemd/services/slack/begut/vault.env;
          };
          staging = {
            enable = true;
            inherit revision;
            sopsFile = ../machines/tom/systemd/services/slack/snaek/vault.env;
          };
        };
      }
    ];
  };
  invalid = base.extendModules {
    modules = [ { services.maintainers-coffee.production.enable = true; } ];
  };
  proxy = flake.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../cloud/coffee.nix
      {
        services.maintainers-coffee-proxy = {
          production.enable = true;
          staging.enable = true;
        };
      }
    ];
  };
  cfg = enabled.config;
  prod = cfg.systemd.services.coffee-production;
  stage = cfg.systemd.services.coffee-staging;
  checks = {
    disabledByDefault =
      !base.config.services.maintainers-coffee.production.enable
      && !base.config.services.maintainers-coffee.staging.enable
      && !(base.config.systemd.services ? coffee-production)
      && !(base.config.systemd.services ? coffee-staging)
      && !(base.config.sops.secrets ? "coffee/production/env");
    activationRequirements =
      builtins.length (
        builtins.filter (
          a: !a.assertion && lib.hasPrefix "maintainers-coffee" a.message
        ) invalid.config.assertions
      ) == 2;
    enabledAssertions =
      builtins.length (
        builtins.filter (a: !a.assertion && lib.hasPrefix "maintainers-coffee" a.message) cfg.assertions
      ) == 0;
    isolatedAccounts =
      prod.serviceConfig.User == "coffee-production"
      && stage.serviceConfig.User == "coffee-staging"
      && prod.serviceConfig.Group != "coffee"
      && stage.serviceConfig.Group != "coffee";
    isolatedSecrets =
      cfg.sops.secrets."coffee/production/env".owner == "coffee-production"
      && cfg.sops.secrets."coffee/staging/env".owner == "coffee-staging"
      && cfg.sops.secrets."coffee/production/env".mode == "0400"
      && prod.serviceConfig.EnvironmentFile != stage.serviceConfig.EnvironmentFile;
    environments =
      prod.environment.APP_ENV == "production"
      && stage.environment.APP_ENV == "staging"
      && prod.environment.APP_ORIGIN == "https://maintainers.coffee"
      && stage.environment.APP_ORIGIN == "https://dev.maintainers.coffee"
      && prod.environment.NODE_ENV == "production"
      && stage.environment.NODE_ENV == "production";
    pinnedSource = lib.hasSuffix "nix run github:maintainersdotcoffee/shop/${revision}" prod.serviceConfig.ExecStart;
    wireguardOnly =
      prod.environment.HOST == "10.100.0.2"
      && stage.environment.HOST == "10.100.0.2"
      &&
        cfg.networking.firewall.interfaces.wg0.allowedTCPPorts == [
          8084
          8085
        ]
      && !(builtins.elem 8084 cfg.networking.firewall.allowedTCPPorts)
      && !(builtins.elem 8085 cfg.networking.firewall.allowedTCPPorts);
    separateState =
      prod.serviceConfig.StateDirectory != stage.serviceConfig.StateDirectory
      && prod.serviceConfig.CacheDirectory != stage.serviceConfig.CacheDirectory;
    tlsProxy =
      proxy.config.services.nginx.virtualHosts."maintainers.coffee".forceSSL
      && proxy.config.services.nginx.virtualHosts."maintainers.coffee".enableACME
      && proxy.config.services.nginx.virtualHosts."dev.maintainers.coffee".forceSSL
      &&
        proxy.config.services.nginx.virtualHosts."maintainers.coffee".locations."/".proxyPass
        == "http://10.100.0.2:8084"
      &&
        proxy.config.services.nginx.virtualHosts."dev.maintainers.coffee".locations."/".proxyPass
        == "http://10.100.0.2:8085";
  };
in
assert builtins.all (value: value) (builtins.attrValues checks);
checks
