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
    signing = {
      key = "~/.ssh/id_ed25519";
    };
  };
  home.file.".config/git/allowed_signers".text = ''
    tom@deorr.co ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWGLeFO/h/8B3u8gq6N1s1/sHnQK7Su7+4elRm3eS4W
  '';
  home.sessionVariables = {
    GITHUB_TOKEN = "$(</run/secrets/github/oauth)";
  };
}
