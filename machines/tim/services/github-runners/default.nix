# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraLabels = [
        "tim"
      ];
      extraPackages = [
        pkgs.fastfetch
      ];
      name = "tim";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
    };
  };
}
