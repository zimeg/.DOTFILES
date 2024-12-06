# https://github.com/cli/cli
{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-poi # https://github.com/seachicken/gh-poi
    ];
    settings = {
      git_protocol = "ssh";
    };
  };
}
