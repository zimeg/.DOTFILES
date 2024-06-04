# https://github.com/git/git
{
  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
    ];
    lfs = {
      enable = true;
    };
  };
  home.file.".gitconfig" = {
    source = ./.gitconfig;
  };
}
