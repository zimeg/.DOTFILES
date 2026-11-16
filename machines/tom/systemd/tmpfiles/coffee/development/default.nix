{ ... }:
{
  systemd = {
    tmpfiles = {
      rules = [
        "a+ /var/lib/hermes - - - - u:ez:--x"
        "a+ /var/lib/hermes/.local - - - - u:ez:--x"
        "a+ /var/lib/hermes/.local/state - - - - u:ez:--x"
        "a+ /var/lib/hermes/.local/state/coffee-dev - - - - u:ez:--x"
        "a+ /var/lib/hermes/.local/state/coffee-dev/output.log - - - - u:ez:r--"
      ];
    };
  };
}
