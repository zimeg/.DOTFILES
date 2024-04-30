{ config, pkgs, ... }:

let
  tools = [
    pkgs.cowsay
    pkgs.curl
    pkgs.fd
    pkgs.ripgrep
    pkgs.wget
  ];
  languages = [
    pkgs.deno
    pkgs.groovy
    pkgs.jdt-language-server
    pkgs.nodejs_20
  ];
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "23.11";
  home.packages = tools ++ languages;
  home.file = {
    ".config/nvim" = {
      source = ~/.DOTFILES/nvim;
      recursive = true;
    };
    ".gitconfig" = {
      source = ~/.DOTFILES/.gitconfig;
    };
    ".tmux.conf" = {
      source = ~/.DOTFILES/.tmux.conf;
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
    JDTLS_PATH="${pkgs.jdt-language-server}/bin/jdtls";
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      PROMPT='%B%F{black}%(!.#.$)%b%f '
    '';
    plugins = [
      {
        name = "wd";
        src = pkgs.fetchFromGitHub {
          owner = "mfaerevaag";
          repo = "wd";
          rev = "v0.5.2";
          sha256 = "sha256-4yJ1qhqhNULbQmt6Z9G22gURfDLe30uV1ascbzqgdhg=";
        };
      }
    ];
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
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
    ];
  };
  programs.jq = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  programs.tmux = {
    enable = true;
    newSession = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "cowboy";
          version = "75702b6d";
          src = pkgs.fetchFromGitHub {
            owner = "tmux-plugins";
            repo = "tmux-cowboy";
            rev = "75702b6d0a866769dd14f3896e9d19f7e0acd4f2";
            sha256 = "sha256-KJNsdDLqT2Uzc25U4GLSB2O1SA/PThmDj9Aej5XjmJs=";
            };
        };
      }
      {
        plugin = tmuxPlugins.pain-control;
      }
      {
        plugin = tmuxPlugins.sessionist;
      }
    ];
  };
}
