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
    signing = {
      key = "~/.ssh/accounts/theorderingmachine";
    };
    settings = {
      gpg = {
        ssh = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      user = {
        email = "tom@deorr.co";
        name = "@theorderingmachine";
      };
    };
  };
  home.file.".config/git/allowed_signers".text = ''
    tom@deorr.co ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEZymM2zPOY+aa0nDpUlvWqA5q74zrNS8uzJN6/84DQ
    zim@o526.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+dGTTCom1yRR0tjxJSFMSgMpGhAULcMqeTA6dF0hrD
  '';
}
