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
  home.sessionVariables = {
    GITHUB_TOKEN = "$(</run/secrets/github/oauth)";
  };
}
