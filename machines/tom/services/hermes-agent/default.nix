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
      model = {
        default = "gpt-5.6-terra";
        provider = "openai-api";
      };
      fallback_providers = [
        {
          model = "claude-opus-4-8";
          provider = "anthropic";
        }
        {
          base_url = "http://localhost:11434/v1";
          model = "gemma4:26b";
          provider = "custom";
        }
      ];
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/hermes/.ssh 0700 hermes hermes -"
    "L+ /var/lib/hermes/.gitconfig - - - - ${./gitconfig}"
  ];
}
