# https://github.com/git/git
{
  programs.git = {
    settings = {
      gpg = {
        ssh = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      user = {
        email = "eden.zimbelman@salesforce.com";
        name = "Eden Zimbelman";
      };
    };
    signing = {
      key = "~/.ssh/id_ed25519";
    };
  };
  home.file.".config/git/allowed_signers".text = ''
    eden.zimbelman@salesforce.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN56hpEg6OYyzNHNm5j8lGNYkE0nHYRIT5Tg1IJZk3oH
  '';
}
