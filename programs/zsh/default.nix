# https://sourceforge.net/p/zsh/code/ci/master/tree
{ pkgs, ... }:
{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    initExtra = ''
      bindkey '^Y' autosuggest-accept
      bindkey '^ ' autosuggest-toggle
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward
      PROMPT='%B%F{black}%(!.#.$)%b%f '
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=0
    '';
    plugins = [
      {
        # https://github.com/mfaerevaag/wd
        name = "wd";
        src = pkgs.fetchFromGitHub {
          owner = "mfaerevaag";
          repo = "wd";
          rev = "v0.7.0";
          sha256 = "sha256-u3n+JzInv8VajWAFXECuEOWuQurX8iWklwV2LG4Tj24=";
        };
      }
    ];
  };
}
