# https://gitlab.com/man-db/man-db
{
  programs.man = {
    enable = true;
    generateCaches = true;
  };
  home.sessionVariables = {
    MANPAGER = "nvim +Man!"; # https://github.com/zimeg/.DOTFILES/issues/37
  };
}
