# https://github.com/maintainersdotcoffee/shop
{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [
        "d /run/coffee 0750 root hermes -"
        "d /run/coffee/receipts 0750 root hermes -"
      ];
    };
  };
}
