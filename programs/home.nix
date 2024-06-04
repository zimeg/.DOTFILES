{ pkgs, ... }:
let
  tools = with pkgs; [
    cowsay # https://github.com/tnalpgge/rank-amateur-cowsay
    curl # https://github.com/curl/curl
    gnumake # https://github.com/mirror/make
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
  home.sessionVariables = {
    JDTLS_PATH = "${pkgs.jdt-language-server}/bin/jdtls";
  };
  programs.home-manager.enable = true;
  imports = [
    ./dircolors
    ./direnv
    ./eza
    ./fd
    ./fzf
    ./gh
    ./git
    ./jq
    ./man
    ./neovim
    ./ripgrep
    ./tmux
    ./zsh
  ];
}
