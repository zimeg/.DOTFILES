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
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
