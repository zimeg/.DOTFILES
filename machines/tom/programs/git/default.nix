# https://github.com/git/git
{
  programs.git = {
    enable = true;
    config = {
      commit = {
        gpgSign = true;
      };
      gpg = {
        format = "ssh";
      };
      user = {
        signingKey = "~/.ssh/id_ed25519";
      };
    };
  };
}
