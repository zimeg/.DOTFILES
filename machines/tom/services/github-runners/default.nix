# https://docs.github.com/actions
{ pkgs }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
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
        pkgs.rsync
      ];
      name = "tom";
      replace = true;
      tokenFile = "/run/secrets/github/runners/slacks";
      url = "https://github.com/zimeg/slack-sandbox";
    };
  };
}
