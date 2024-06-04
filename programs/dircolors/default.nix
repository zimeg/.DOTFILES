# https://github.com/coreutils/coreutils/blob/master/src/dircolors.c
{
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "bu" = "38;5;181";
      "da" = "2";
      "di" = "38;5;73";
      "ex" = "38;5;174";
      "ln" = "38;5;224";
      "nb" = "38;5;189";
      "nk" = "38;5;188";
      "nm" = "38;5;183";
      "ng" = "38;5;140";
      "nt" = "38;5;134";
      "oc" = "2";
      ".*" = "38;5;246";
      "*.*" = "37";
      "*.md" = "38;5;248";
    };
  };
}
