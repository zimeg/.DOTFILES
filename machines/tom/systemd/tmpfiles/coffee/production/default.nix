{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [ "d /run/receipts 0750 root hermes -" ];
    };
  };
}
