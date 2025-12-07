# https://docs.github.com/actions
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraLabels = [
        "tim"
      ];
      name = "tim";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
    };
  };
}
