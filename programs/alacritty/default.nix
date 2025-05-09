# https://github.com/alacritty/alacritty
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          background = "#000000";
        };
      };
      env = {
        TERM = "xterm-256color";
      };
      mouse = {
        hide_when_typing = true;
      };
      window = {
        dimensions = {
          columns = 80;
          lines = 24;
        };
        resize_increments = true;
        startup_mode = "Fullscreen";
        title = "term";
      };
    };
  };
}
