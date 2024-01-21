{ config, pkgs, ... }:

{
  home.username = "ez";
  home.homeDirectory = "/home/ez";
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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
