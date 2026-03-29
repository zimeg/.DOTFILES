# https://github.com/git/git
{
  programs.git = {
    signing = {
      key = "~/.ssh/id_ed25519";
    };
    settings = {
      gpg = {
        ssh = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      user = {
        email = "zim@o526.net";
        name = "@zimeg";
      };
    };
  };
  home.file.".config/git/allowed_signers".text = ''
    zim@o526.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZQSWnGNtSoSAaK90h3FYsxTlevad8+BpTzR2DwiT1C
  '';
}
