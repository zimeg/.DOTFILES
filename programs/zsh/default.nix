# https://sourceforge.net/p/zsh/code/ci/master/tree
{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      path = "$HOME/.config/zsh/.zsh_history";
      save = 1010101;
      saveNoDups = true;
    };
    initContent = ''
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
        src = pkgs.zsh-wd;
        file = "share/wd/wd.plugin.zsh";
        completions = [ "share/zsh/site-functions" ];
      }
    ];
  };
  home.sessionVariables = {
    WD_CONFIG = "$HOME/.config/wd/.warprc";
  };
}
