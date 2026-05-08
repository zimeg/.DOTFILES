# https://github.com/nix-community/home-manager
{
  imports = [
    ./programs/git
  ];
  home.sessionVariables = {
    CIRCLECI_TOKEN = "$(</run/secrets/ci/circleci)";
  };
  programs.zsh.shellAliases = {
    claude = "slack-claude --dangerously-skip-permissions";
  };
}
