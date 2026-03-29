# https://github.com/git/git
{
  programs.git = {
    signing = {
      key = "~/.ssh/id_ed25519";
    };
    settings = {
      user = {
        email = "zim@o526.net";
        name = "@zimeg";
      };
    };
  };
}
