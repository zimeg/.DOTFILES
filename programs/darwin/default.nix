# https://developer.apple.com/documentation/foundation/userdefaults
{
  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Pop.aiff";
    };
    CustomUserPreferences = {
      "com.apple.dock" = {
        "size-immutable" = true;
      };
      "com.apple.Safari" = {
        AutoFillCreditCardData = false;
        AutoFillPasswords = true;
        AutoOpenSafeDownloads = false;
        IncludeDevelopMenu = true;
        SearchProviderShortName = "DuckDuckGo";
        ShowOverlayStatusBar = true;
      };
    };
    LaunchServices = {
      LSQuarantine = false;
    };
    NSGlobalDomain = {
      AppleEnableSwipeNavigateWithScrolls = true;
      AppleFontSmoothing = 2;
      AppleICUForce24HourTime = true;
      AppleIconAppearanceTheme = "ClearDark";
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 2;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      ApplePressAndHoldEnabled = false;
      AppleScrollerPagingBehavior = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleTemperatureUnit = "Celsius";
      InitialKeyRepeat = 25;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDisableAutomaticTermination = true;
      NSDocumentSaveNewDocumentsToCloud = true;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSScrollAnimationEnabled = true;
      NSStatusItemSelectionPadding = 6;
      NSStatusItemSpacing = 12;
      NSTableViewDefaultSizeMode = 2;
      NSTextShowsControlCharacters = true;
      NSUseAnimatedFocusRing = true;
      NSWindowResizeTime = 0.2;
      NSWindowShouldDragOnGesture = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      _HIHideMenuBar = false;
      "com.apple.keyboard.fnState" = false;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.2;
      "com.apple.springing.delay" = 0.6;
      "com.apple.springing.enabled" = true;
      "com.apple.swipescrolldirection" = true;
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.trackpad.scaling" = 2.4;
    };
    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = false;
    };
    WindowManager = {
      AppWindowGroupingBehavior = true;
      AutoHide = false;
      EnableStandardClickToShowDesktop = true;
      EnableTiledWindowMargins = false;
      EnableTilingByEdgeDrag = false;
      EnableTilingOptionAccelerator = false;
      EnableTopTilingByEdgeDrag = false;
      GloballyEnabled = false;
      HideDesktop = false;
      StageManagerHideWidgets = false;
      StandardHideDesktopIcons = false;
      StandardHideWidgets = false;
    };
    controlcenter = {
      AirDrop = false;
      Bluetooth = false;
      Display = false;
      FocusModes = true;
      NowPlaying = false;
      Sound = true;
    };
    dock = {
      appswitcher-all-displays = false;
      autohide = true;
      autohide-delay = 0.12;
      autohide-time-modifier = 0.48;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = true;
      expose-animation-duration = 1.0;
      expose-group-apps = true;
      largesize = 52;
      launchanim = false;
      magnification = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = false;
      mru-spaces = false;
      orientation = "bottom";
      scroll-to-open = false;
      show-process-indicators = true;
      show-recents = true;
      showhidden = false;
      slow-motion-allowed = false;
      static-only = false;
      tilesize = 48;
      wvous-bl-corner = 1;
      wvous-br-corner = 14;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      NewWindowTarget = "iCloud Drive";
      QuitMenuItem = false;
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = true;
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = false;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };
    hitoolbox = {
      AppleFnUsageType = "Show Emoji & Symbols";
    };
    iCal = {
      CalendarSidebarShown = false;
      "TimeZone support enabled" = false;
      "first day of week" = "Monday";
    };
    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabled = false;
      RestartDisabledWhileLoggedIn = false;
      SHOWFULLNAME = false;
      ShutDownDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      SleepDisabled = false;
    };
    menuExtraClock = {
      FlashDateSeparators = false;
      IsAnalog = false;
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 0;
      ShowDayOfMonth = false;
      ShowDayOfWeek = false;
      ShowSeconds = true;
    };
    screencapture = {
      disable-shadow = false;
      include-date = true;
      location = "~/Desktop";
      show-thumbnail = false;
      target = "file";
      type = "png";
    };
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };
    spaces = {
      spans-displays = false;
    };
    trackpad = {
      ActuationStrength = 1;
      Clicking = true;
      Dragging = false;
      FirstClickThreshold = 1;
      SecondClickThreshold = 2;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
    };
    universalaccess = {
      closeViewScrollWheelToggle = false;
      closeViewZoomFollowsFocus = false;
      mouseDriverCursorSize = 1.0;
      reduceMotion = true;
      reduceTransparency = false;
    };
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
    remapCapsLockToEscape = true;
    swapLeftCommandAndLeftAlt = false;
    swapLeftCtrlAndFn = false;
  };
}
