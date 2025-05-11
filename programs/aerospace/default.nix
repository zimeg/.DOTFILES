# https://github.com/nikitabobko/AeroSpace
{ pkgs, ... }:
{
  programs.aerospace = {
    enable = pkgs.stdenv.isDarwin;
    userSettings = {
      automatically-unhide-macos-hidden-apps = false;
      gaps = {
        outer = {
          top = 8;
          right = 8;
          bottom = 8;
          left = 8;
        };
      };
      mode = {
        main = {
          binding = {
            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-minus = "resize smart -50";
            alt-equal = "resize smart +50";
            alt-shift-equal = "balance-sizes";
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";
            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";
            alt-t = "layout tiling floating";
            alt-f = "fullscreen";
            alt-shift-f = "macos-native-fullscreen";
            alt-shift-semicolon = "mode service";
          };
        };
        service = {
          binding = {
            esc = [
              "reload-config"
              "mode main"
            ];
            alt-shift-equal = [
              "flatten-workspace-tree"
              "mode main"
            ];
            alt-shift-h = [
              "join-with left"
              "mode main"
            ];
            alt-shift-j = [
              "join-with down"
              "mode main"
            ];
            alt-shift-k = [
              "join-with up"
              "mode main"
            ];
            alt-shift-l = [
              "join-with right"
              "mode main"
            ];
          };
        };
      };
      start-at-login = true;
    };
  };
}
