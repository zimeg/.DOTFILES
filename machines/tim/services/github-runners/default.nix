# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraLabels = [
        "tim"
      ];
      extraEnvironment = {
        GIT_SSH_COMMAND = "ssh -i /run/secrets/github/ssh -o StrictHostKeyChecking=accept-new";
      };
      extraPackages = [
        pkgs.openssh # https://github.com/openssh/openssh-portable
        pkgs.fastfetch # https://github.com/fastfetch-cli/fastfetch
      ];
      name = "tim";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
    };
  };
}
