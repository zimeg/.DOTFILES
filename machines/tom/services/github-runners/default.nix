# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    coffee = {
      enable = true;
      ephemeral = true;
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/coffee";
      url = "https://github.com/maintainersdotcoffee/shop";
    };
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraLabels = [
        "tom"
      ];
      extraPackages = [
        pkgs.fastfetch
      ];
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
    };
    etime = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.time
      ];
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/etime";
      url = "https://github.com/zimeg/emporia-time";
    };
    slacks = {
      enable = true;
      ephemeral = true;
      extraPackages = [
        pkgs.codecov-cli # https://github.com/codecov/codecov-cli
        pkgs.curl # https://github.com/curl/curl
        pkgs.gnupg # https://github.com/gpg/gnupg
        pkgs.rsync # https://github.com/rsyncproject/rsync
        pkgs.which # https://git.savannah.gnu.org/cgit/which.git
      ];
      group = "wheel";
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks";
      url = "https://github.com/zimeg/slack-sandbox";
      user = "root";
    };
  };
}
