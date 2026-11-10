# https://tinyproxy.github.io/
{
  services.tinyproxy = {
    enable = true;
    settings = {
      Allow = [ "127.0.0.1" ];
      Listen = "127.0.0.1";
      Port = 3128;
      Timeout = 600;
    };
  };
}
