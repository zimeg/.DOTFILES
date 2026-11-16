{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [
        "d /var/log/coffee 0700 hermes hermes -"
        "f /var/log/coffee/development.log 0600 hermes hermes -"
        "a+ /var/log/coffee - - - - u:ez:--x"
        "a+ /var/log/coffee/development.log - - - - u:ez:r--"
      ];
    };
  };
}
