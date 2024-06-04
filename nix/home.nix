{ config, pkgs, ... }:

let
  tools = with pkgs; [
    cowsay # https://github.com/tnalpgge/rank-amateur-cowsay
    curl # https://github.com/curl/curl
    fd # https://github.com/sharkdp/fd
    gnumake # https://github.com/mirror/make
    ripgrep # https://github.com/BurntSushi/ripgrep
    wget # https://github.com/mirror/wget
  ];
  languages = with pkgs; with pkgs.nodePackages_latest; with pkgs.python311Packages; [
    bash-language-server # https://github.com/bash-lsp/bash-language-server
    black # https://github.com/psf/black
    cargo # https://github.com/rust-lang/cargo
    delve # https://github.com/go-delve/delve
    deno # https://github.com/denoland/deno
    dockerfile-language-server-nodejs # https://github.com/rcjsuen/dockerfile-language-server
    go # https://github.com/golang/go
    gofumpt # https://github.com/mvdan/gofumpt
    golangci-lint # https://github.com/golangci/golangci-lint
    golangci-lint-langserver # https://github.com/nametake/golangci-lint-langserver
    gopls # https://github.com/golang/tools/tree/master/gopls
    gradle_7 # https://github.com/gradle/gradle/tree/v7.6.4
    groovy # https://github.com/apache/groovy
    htmx-lsp # https://github.com/ThePrimeagen/htmx-lsp
    isort # https://github.com/PyCQA/isort
    jdk19 # https://github.com/openjdk/jdk/releases/tag/jdk-19-ga
    jdt-language-server # https://github.com/eclipse-jdtls/eclipse.jdt.ls
    jq-lsp # https://github.com/wader/jq-lsp
    lua-language-server # https://github.com/LuaLS/lua-language-server
    luajit # https://github.com/LuaJIT/LuaJIT
    marksman # https://github.com/artempyanykh/marksman
    nil # https://github.com/oxalica/nil
    nixpkgs-fmt # https://github.com/nix-community/nixpkgs-fmt
    nodejs_22 # https://github.com/nodejs/node
    prettierd # https://github.com/fsouza/prettierd
    pyright # https://github.com/microsoft/pyright
    python3 # https://github.com/python/cpython
    ruff # https://github.com/astral-sh/ruff
    ruff-lsp # https://github.com/astral-sh/ruff-lsp
    rust-analyzer # https://github.com/rust-lang/rust-analyzer
    rustc # https://github.com/rust-lang/rust
    rustfmt # https://github.com/rust-lang/rustfmt
    shellcheck # https://github.com/koalaman/shellcheck
    shfmt # https://github.com/mvdan/sh
    stylua # https://github.com/johnnymorganz/stylua
    tailwindcss # https://tailwindcss.com/blog/standalone-cli
    tailwindcss-language-server # https://github.com/tailwindlabs/tailwindcss-intellisense
    terraform-ls # https://github.com/hashicorp/terraform-ls
    tflint # https://github.com/terraform-linters/tflint
    tree-sitter # https://github.com/tree-sitter/tree-sitter
    typescript-language-server # https://github.com/typescript-language-server/typescript-language-server
    vscode-langservers-extracted # https://github.com/hrsh7th/vscode-langservers-extracted
    yaml-language-server # https://github.com/redhat-developer/yaml-language-server
    yamllint # https://github.com/adrienverge/yamllint
  ];
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.05";
  home.packages = tools ++ languages;
  home.file = {
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
    JDTLS_PATH = "${pkgs.jdt-language-server}/bin/jdtls";
  };
  programs.home-manager.enable = true;
  imports = [
    ./fzf
    ./neovim
  ];
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
    lfs = {
      enable = true;
    };
  };
  programs.jq = {
    enable = true;
  };
  programs.man = {
    enable = true;
    generateCaches = true;
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
