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
    userEmail = "tom@deorr.co";
    userName = "@theorderingmachine";
  };
  home.sessionVariables = {
    GITHUB_TOKEN = "$(</run/secrets/github/oauth)";
  };
}
