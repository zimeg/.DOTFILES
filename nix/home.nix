{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "23.11";
  home.packages = [
    pkgs.cowsay
    pkgs.fd
    pkgs.ripgrep
  ];
  home.file = {
    ".config/nvim" = {
      source = ~/.DOTFILES/nvim;
      recursive = true;
    };
  };
  home.sessionVariables = {
    EZA_COLORS =
      let
        settingsList = builtins.attrNames config.programs.dircolors.settings;
        formatKeyValue = k: "${k}=${builtins.getAttr k config.programs.dircolors.settings}";
        settings = map formatKeyValue settingsList;
      in
        builtins.concatStringsSep ":" settings;
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      PROMPT='%B%F{black}%(!.#.$)%b%f '
    '';
  };
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
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.eza = {
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--all"
      "--classify"
      "--group-directories-first"
      "--long"
      "--no-permissions"
      "--no-user"
      "--octal-permissions"
      "--sort=Name"
      "--time-style=long-iso"
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
