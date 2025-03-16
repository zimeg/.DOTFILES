# https://docs.github.com/actions
{ pkgs }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      name = "tom";
      replace = true;
      tokenFile = "/home/ez/.secrets/gh.dotfiles.token";
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
      tokenFile = "/home/ez/.secrets/gh.etime.token";
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
      tokenFile = "/home/ez/.secrets/gh.slacks.token";
      url = "https://github.com/zimeg/slack-sandbox";
    };
  };
}
