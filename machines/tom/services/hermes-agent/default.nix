# https://github.com/NousResearch/hermes-agent
{ config, pkgs, ... }:
{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    group = "hermes";
    user = "hermes";
    workingDirectory = "/var/lib/hermes/workspace";
    documents = {
      "AGENTS.md" = ./AGENTS.md;
    };
    environmentFiles = [
      config.sops.secrets."hermes/env".path
    ];
    extraPackages = [
      pkgs.claude-code # https://github.com/anthropics/claude-code
      pkgs.curl # https://github.com/curl/curl
      pkgs.fd # https://github.com/sharkdp/fd
      pkgs.gh # https://github.com/cli/cli
      pkgs.git # https://github.com/git/git
      pkgs.jq # https://github.com/jqlang/jq
      pkgs.ripgrep # https://github.com/BurntSushi/ripgrep
    ];
    hermesHomeFiles = {
      "SOUL.md" = ./SOUL.md;
    };
    settings = {
      # https://hermes-agent.nousresearch.com/docs/user-guide/features/browser
      browser = {
        backend = "browser-use";
        cdp_url = "http://127.0.0.1:9222";
      };
      model = {
        default = "gpt-6.1-sol";
        provider = "openai-api";
      };
      fallback_providers = [
        {
          model = "claude-opus-5-5";
          provider = "anthropic";
        }
        {
          base_url = "http://localhost:11434/v1";
          model = "gemma4:26b";
          provider = "custom";
        }
      ];
      # https://hermes-agent.nousresearch.com/docs/user-guide/messaging/slack
      platforms.slack = {
        extra = {
          native_task_cards = true;
          rich_blocks = true;
        };
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/hermes/.config 0700 hermes hermes -"
    "d /var/lib/hermes/.config/gh 0700 hermes hermes -"
    "d /var/lib/hermes/.ssh 0700 hermes hermes -"
    "L+ /var/lib/hermes/.gitconfig - - - - ${./gitconfig}"
  ];
  systemd.services = {
    hermes-agent = {
      after = [ "hermes-browser.service" ];
      wants = [ "hermes-browser.service" ];
      serviceConfig.ExecStartPre = [
        "${pkgs.coreutils}/bin/install -m 0600 ${
          config.sops.secrets."hermes/github".path
        } /var/lib/hermes/.config/gh/hosts.yml"
        "${pkgs.curl}/bin/curl --fail --silent --retry 20 --retry-connrefused --retry-delay 1 http://127.0.0.1:9222/json/version"
      ];
    };
    hermes-browser = {
      description = "Hermes browser automation";
      after = [
        "hermes-browser-access.service"
        "network.target"
      ];
      bindsTo = [ "hermes-browser-access.service" ];
      partOf = [ "hermes-browser-access.service" ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        HOME = "/var/lib/hermes";
      };
      serviceConfig = {
        ExecStart = "${pkgs.chromium}/bin/chromium --headless --remote-debugging-address=127.0.0.1 --remote-debugging-port=9222 --user-data-dir=/var/lib/hermes/.hermes/browser-cdp --no-first-run --no-default-browser-check";
        Group = "hermes";
        Restart = "always";
        RestartSec = 2;
        UMask = "0077";
        User = "hermes";
      };
    };
    hermes-browser-access = {
      description = "Restrict Hermes browser CDP to its service user";
      after = [ "firewall.service" ];
      # Match both source and destination ports: untrusted clients must not
      # connect, and an untrusted process binding 9222 must not impersonate CDP.
      # Keep this OUTPUT rule outside firewall reload hooks: those temporarily
      # remove extraStopCommands rules while the browser remains running.
      serviceConfig = {
        ExecStart = "${config.networking.firewall.package}/bin/iptables -w -I OUTPUT -o lo -p tcp -m multiport --ports 9222 -m owner ! --uid-owner hermes -j REJECT";
        ExecStop = "${config.networking.firewall.package}/bin/iptables -w -D OUTPUT -o lo -p tcp -m multiport --ports 9222 -m owner ! --uid-owner hermes -j REJECT";
        RemainAfterExit = true;
        Type = "oneshot";
        User = "root";
      };
    };
  };
  assertions = [
    {
      assertion = config.networking.firewall.backend == "iptables";
      message = "Hermes browser access isolation requires the iptables firewall backend.";
    }
  ];
}
