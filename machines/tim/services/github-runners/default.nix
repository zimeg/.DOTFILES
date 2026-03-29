# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraEnvironment = {
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
        GIT_SSH_COMMAND = "ssh -i /run/secrets/github/theorderingmachine -o StrictHostKeyChecking=accept-new";
      };
      extraLabels = [
        "tim"
      ];
      extraPackages = [
        pkgs.openssh # https://github.com/openssh/openssh-portable
        pkgs.fastfetch # https://github.com/fastfetch-cli/fastfetch
      ];
      group = "_github-runner";
      name = "tim";
      replace = true;
      tokenFile = "/run/secrets/github/runners/dotfiles";
      url = "https://github.com/zimeg/.DOTFILES";
      user = "_github-runner";
    };
  };
}
