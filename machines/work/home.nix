# https://github.com/nix-community/home-manager
{
  imports = [
    ./programs/git
  ];
  programs.zsh.shellAliases = {
    claude = "slack-claude --dangerously-skip-permissions";
  };
}
