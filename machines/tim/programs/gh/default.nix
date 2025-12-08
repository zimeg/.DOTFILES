# https://github.com/cli/cli
{
  programs.gh = {
    hosts = {
      "github.com" = {
        git_protocol = "ssh";
        user = "theorderingmachine";
      };
    };
  };
  programs.git = {
    settings = {
      user = {
        email = "tom@deorr.co";
        name = "@theorderingmachine";
      };
    };
  };
}
