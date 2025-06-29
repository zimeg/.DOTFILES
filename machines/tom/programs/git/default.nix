# https://github.com/git/git
{
  programs.git = {
    enable = true;
    config = {
      safe = {
        directory = [
          "/srv/slack"
        ];
      };
    };
  };
}
