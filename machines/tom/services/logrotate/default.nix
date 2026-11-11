{ ... }:
{
  services = {
    logrotate = {
      settings = {
        coffee-dev = {
          files = [ "/var/lib/hermes/.local/state/coffee-dev/output.log" ];
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
