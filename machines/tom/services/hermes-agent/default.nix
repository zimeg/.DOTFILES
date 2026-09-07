# https://github.com/NousResearch/hermes-agent
{ config, pkgs, ... }:
{
  services.hermes-agent = {
    addToSystemPackages = true;
    documents = {
      "AGENTS.md" = ./AGENTS.md;
    };
    enable = true;
    environmentFiles = [
      config.sops.secrets."hermes/env".path
    ];
    extraPackages = [
      pkgs.curl # https://github.com/curl/curl
      pkgs.fd # https://github.com/sharkdp/fd
      pkgs.gh # https://github.com/cli/cli
      pkgs.git # https://github.com/git/git
      pkgs.jq # https://github.com/jqlang/jq
      pkgs.ripgrep # https://github.com/BurntSushi/ripgrep
    ];
    group = "hermes";
    hermesHomeFiles = {
      "SOUL.md" = ./SOUL.md;
    };
    settings = {
      model = {
        base_url = "http://localhost:11434/v1";
        default = "gemma4:26b";
        provider = "custom";
      };
    };
    user = "hermes";
    workingDirectory = "/var/lib/hermes/workspace";
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/hermes/.config 0700 hermes hermes -"
    "d /var/lib/hermes/.config/gh 0700 hermes hermes -"
    "d /var/lib/hermes/.ssh 0700 hermes hermes -"
    "L+ /var/lib/hermes/.gitconfig - - - - ${./gitconfig}"
  ];
  systemd.services.hermes-agent.serviceConfig.ExecStartPre = [
    "${pkgs.coreutils}/bin/install -m 0600 ${
      config.sops.secrets."hermes/github".path
    } /var/lib/hermes/.config/gh/hosts.yml"
    # Build allowed_signers so ssh-verified commits validate for this identity.
    "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/install -m 0644 /dev/stdin /var/lib/hermes/.ssh/allowed_signers <<<\"tom@deorr.co $(${pkgs.coreutils}/bin/cat ${
      config.sops.secrets."hermes/ssh/public".path
    })\"'"
  ];
}
