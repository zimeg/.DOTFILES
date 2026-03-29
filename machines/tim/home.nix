# https://github.com/nix-community/home-manager
{ pkgs, ... }:
{
  imports = [
    ./programs/gh
    ./programs/ssh
    ./programs/wd
  ];
  home.packages = with pkgs; [
    pnpm # https://github.com/pnpm/pnpm
  ];
}
