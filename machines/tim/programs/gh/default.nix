# https://github.com/cli/cli
{
  programs.gh = {
    hosts = {
      "github.com" = {
        git_protocol = "ssh";
        user = "zimeg";
      };
    };
  };
  programs.git = {
    settings = {
      user = {
        email = "zim@o526.net";
        name = "@zimeg";
      };
    };
  };
}
