# https://github.com/git/git
{
  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519";
    };
  };
}
