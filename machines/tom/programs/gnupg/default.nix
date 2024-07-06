# https://github.com/gpg/gnupg
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
