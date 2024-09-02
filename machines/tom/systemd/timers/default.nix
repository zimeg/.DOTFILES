# https://github.com/systemd/systemd
{
  systemd.user.timers = {
    "minecraft:backup" = {
      timerConfig = {
        OnCalendar = "weekly";
        Unit = "minecraft:backup.service";
      };
    };
  };
}
