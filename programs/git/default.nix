# https://github.com/git/git
{ pkgs, ... }:
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
  home.packages = [
    pkgs.git-open # https://github.com/paulirish/git-open
  ];
}
