# https://docs.github.com/actions
{ pkgs, ... }:
{
  services.github-runners = {
    dotfiles = {
      enable = true;
      ephemeral = true;
      extraEnvironment = {
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
        GIT_SSH_COMMAND = "ssh -i /run/secrets/github/accounts/theorderingmachine -o StrictHostKeyChecking=accept-new";
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
    etime-neutral = {
      enable = true;
      ephemeral = true;
      extraEnvironment = {
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
      };
      extraLabels = [
        "tim"
      ];
      extraPackages = [
        pkgs.gh # https://github.com/cli/cli
      ];
      group = "_github-runner";
      name = "neutral";
      replace = true;
      tokenFile = "/run/secrets/github/runners/etime/neutral";
      url = "https://github.com/zimeg/emporia-time";
      user = "_github-runner";
    };
  };
}
