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
    slacks = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.curl # https://github.com/curl/curl
        pkgs.gnupg # https://github.com/gpg/gnupg
        pkgs.rsync # https://github.com/rsyncproject/rsync
        pkgs.which # https://git.savannah.gnu.org/cgit/which.git
      ];
      group = "slacks";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "slacks";
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
