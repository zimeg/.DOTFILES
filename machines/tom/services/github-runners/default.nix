# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    blog = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
      ];
      group = "blog";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/blog";
      url = "https://github.com/zimeg/blog";
      user = "blog";
    };
    coffee = {
      enable = true;
      ephemeral = true;
      group = "coffee";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/coffee";
      url = "https://github.com/maintainersdotcoffee/shop";
      user = "coffee";
    };
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraLabels = [
        "tom"
      ];
      extraPackages = [
        pkgs.fastfetch # https://github.com/fastfetch-cli/fastfetch
      ];
      group = "dotfiles";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
      user = "dotfiles";
    };
    etime = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.time
      ];
      group = "etime";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/etime";
      url = "https://github.com/zimeg/emporia-time";
      user = "etime";
    };
    slacks-mercury = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "mercury";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/mercury";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-venus = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "venus";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/venus";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-earth = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "earth";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/earth";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-mars = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "mars";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/mars";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-jupiter = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "jupiter";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/jupiter";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-saturn = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "saturn";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/saturn";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-uranus = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "uranus";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/uranus";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-neptune = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "neptune";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/neptune";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    slacks-pluto = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
        pkgs.rsync # https://rsync.samba.org
      ];
      group = "slacks";
      name = "pluto";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks/pluto";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
    };
    endpoints = {
      enable = true;
      ephemeral = true;
      group = "endpoints";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/endpoints";
      url = "https://github.com/zimeg/endpoints";
      user = "endpoints";
    };
    quintus = {
      enable = true;
      ephemeral = true;
      group = "quintus";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/quintus";
      url = "https://github.com/zimeg/quintus";
      user = "quintus";
    };
  };
}
