{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      name = "tom";
      tokenFile = "/home/ez/.secrets/gh.dotfiles.token";
      url = "https://github.com/zimeg/.DOTFILES";
    };
  };
}
