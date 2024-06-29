# https://github.com/tmux/tmux
{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    newSession = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    plugins = with pkgs; [
      {
        # https://github.com/tmux-plugins/tmux-resurrect
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        # https://github.com/tmux-plugins/tmux-continuum
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        # https://github.com/tmux-plugins/tmux-cowboy
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
        # https://github.com/tmux-plugins/tmux-pain-control
        plugin = tmuxPlugins.pain-control;
      }
      {
        # https://github.com/tmux-plugins/tmux-sessionist
        plugin = tmuxPlugins.sessionist;
      }
    ];
  };
  home.file.".tmux.conf" = {
    source = ./.tmux.conf;
  };
}
