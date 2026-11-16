# https://github.com/logrotate/logrotate
{ ... }:
{
  services = {
    logrotate = {
      settings = {
        coffee-dev = {
          files = [ "/var/log/coffee/development.log" ];
          frequency = "daily";
          rotate = 7;
          maxsize = "10M";
          compress = true;
          delaycompress = true;
          copytruncate = true;
          missingok = true;
          notifempty = true;
          su = "hermes hermes";
        };
      };
    };
  };
}
