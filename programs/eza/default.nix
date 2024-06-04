# https://github.com/eza-community/eza
{ config, ... }:
{
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
  home.sessionVariables = {
    EZA_COLORS =
      let
        settingsList = builtins.attrNames config.programs.dircolors.settings;
        formatKeyValue = k: "${k}=${builtins.getAttr k config.programs.dircolors.settings}";
        settings = map formatKeyValue settingsList;
      in
      builtins.concatStringsSep ":" settings;
  };
}
