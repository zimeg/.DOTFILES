# https://gitlab.freedesktop.org/xorg/xserver
{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
