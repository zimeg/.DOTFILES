# https://github.com/cli/cli
{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-poi # https://github.com/seachicken/gh-poi
    ];
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    settings = {
      git_protocol = "ssh";
    };
  };
}
