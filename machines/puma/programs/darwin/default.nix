# https://developer.apple.com/documentation/foundation/userdefaults
{
  system.primaryUser = "ez";
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
          app = "/System/Applications/Mail.app";
        }
        {
          app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
        }
        {
          app = "/System/Applications/Utilities/Terminal.app";
        }
        {
          app = "/System/Applications/Maps.app";
        }
        {
          app = "/System/Applications/Preview.app";
        }
        {
          app = "/System/Applications/Messages.app";
        }
        {
          app = "/Applications/Spotify.app";
        }
        {
          app = "/System/Applications/Music.app";
        }
        {
          app = "/System/Applications/Dictionary.app";
        }
        {
          app = "/System/Applications/Notes.app";
        }
      ];
    };
  };
}
