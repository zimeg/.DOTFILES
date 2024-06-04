# https://github.com/cli/cli
{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
