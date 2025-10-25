# https://github.com/dandavison/delta
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      syntax-theme = "ansi";
    };
  };
}
