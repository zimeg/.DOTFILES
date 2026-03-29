# https://github.com/git/git
{
  programs.git = {
    signing = {
      key = "~/.ssh/id_ed25519";
    };
    settings = {
      user = {
        email = "eden.zimbelman@salesforce.com";
        name = "Eden Zimbelman";
      };
    };
  };
}
