# https://github.com/nix-community/home-manager
{ pkgs, ... }:
let
  tools = with pkgs; [
    age # https://github.com/FiloSottile/age
    cachix # https://github.com/cachix/cachix
    cowsay # https://github.com/tnalpgge/rank-amateur-cowsay
    curl # https://github.com/curl/curl
    file # https://github.com/file/file
    gimp # https://gitlab.gnome.org/GNOME/gimp
    gnumake # https://github.com/mirror/make
    gnused # https://git.savannah.gnu.org/cgit/sed.git
    less # https://github.com/gwsw/less
    pciutils # https://github.com/pciutils/pciutils
    sops # https://github.com/getsops/sops
    wget # https://github.com/mirror/wget
  ];
  languages = with pkgs; [
    biome # https://github.com/biomejs/biome
    black # https://github.com/psf/black
    cargo # https://github.com/rust-lang/cargo
    delve # https://github.com/go-delve/delve
    deno # https://github.com/denoland/deno
    dockerfile-language-server-nodejs # https://github.com/rcjsuen/dockerfile-language-server
    go_1_24 # https://github.com/golang/go
    gofumpt # https://github.com/mvdan/gofumpt
    golangci-lint # https://github.com/golangci/golangci-lint
    golangci-lint-langserver # https://github.com/nametake/golangci-lint-langserver
    gotools # https://github.com/golang/tools
    gradle # https://github.com/gradle/gradle
    groovy # https://github.com/apache/groovy
    htmx-lsp # https://github.com/ThePrimeagen/htmx-lsp
    isort # https://github.com/PyCQA/isort
    jdk23 # https://github.com/openjdk/jdk/releases/tag/jdk-23-ga
    jdt-language-server # https://github.com/eclipse-jdtls/eclipse.jdt.ls
    jq-lsp # https://github.com/wader/jq-lsp
    lua-language-server # https://github.com/LuaLS/lua-language-server
    luajit # https://github.com/LuaJIT/LuaJIT
    marksman # https://github.com/artempyanykh/marksman
    nil # https://github.com/oxalica/nil
    nixfmt-rfc-style # https://github.com/NixOS/nixfmt
    nodePackages_latest."@astrojs/language-server" # https://github.com/withastro/language-tools/tree/main/packages/language-server
    nodePackages_latest.bash-language-server # https://github.com/bash-lsp/bash-language-server
    nodePackages_latest.prettier # https://github.com/prettier/prettier
    nodePackages_latest.typescript-language-server # https://github.com/typescript-language-server/typescript-language-server
    nodejs_22 # https://github.com/nodejs/node
    pyright # https://github.com/microsoft/pyright
    python3 # https://github.com/python/cpython
    ruff # https://github.com/astral-sh/ruff
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
    vscode-langservers-extracted # https://github.com/hrsh7th/vscode-langservers-extracted
    yaml-language-server # https://github.com/redhat-developer/yaml-language-server
    yamllint # https://github.com/adrienverge/yamllint
    zls # https://github.com/zigtools/zls
  ];
in
{
  home.stateVersion = "24.05";
  home.packages = tools ++ languages;
  home.sessionVariables = {
    JDTLS_PATH = "${pkgs.jdt-language-server}/bin/jdtls";
  };
  programs.home-manager.enable = true;
  imports = [
    ./alacritty
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
    ./ssh
    ./tmux
    ./zsh
  ];
}
