{ config, pkgs, ... }:

{
  home.username = "ez";
  home.homeDirectory = "/home/ez";
  home.stateVersion = "23.11";
  home.packages = [
    pkgs.cowsay
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
  };
}
