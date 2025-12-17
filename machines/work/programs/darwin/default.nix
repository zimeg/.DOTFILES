# https://developer.apple.com/documentation/foundation/userdefaults
{
  system.primaryUser = "eden.zimbelman";
  system.defaults = {
    controlcenter = {
      BatteryShowPercentage = true;
    };
    dock = {
      persistent-apps = [
        {
          app = "/System/Applications/System Settings.app";
        }
        {
          app = "/System/Applications/Calendar.app";
        }
        {
          app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
        }
        {
          app = "/System/Applications/Utilities/Activity Monitor.app";
        }
        {
          app = "/System/Applications/Stocks.app";
        }
        {
          app = "/Applications/Slack.app";
        }
        {
          app = "/System/Applications/Maps.app";
        }
        {
          app = "/System/Applications/Utilities/Terminal.app";
        }
        {
          app = "/System/Applications/Music.app";
        }
        {
          app = "/Applications/Spotify.app";
        }
      ];
    };
  };
}
