# https://github.com/systemd/systemd
{
  systemd.targets = {
    hibernate = {
      enable = false;
    };
    hybrid-sleep = {
      enable = false;
    };
    sleep = {
      enable = false;
    };
    suspend = {
      enable = false;
    };
  };
}
