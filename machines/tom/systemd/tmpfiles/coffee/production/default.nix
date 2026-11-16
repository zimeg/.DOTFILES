# https://github.com/maintainersdotcoffee/shop

{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [ "d /run/receipts 0750 root hermes -" ];
    };
  };
}
