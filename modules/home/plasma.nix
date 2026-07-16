{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  # Import unconditionally (conditioning `imports` on `pkgs` causes infinite
  # recursion). home.nix is shared with the Darwin host, so the actual config
  # below is gated on Linux where Plasma exists.
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = lib.mkIf isLinux {
    enable = true;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus-Dark";

      # Rotate the wallpaper once an hour (interval is in seconds).
      wallpaperSlideShow = {
        path = "${config.home.homeDirectory}/Pictures/backgrounds";
        interval = 3600;
      };

      # "Scaled, keep proportions" in the KDE wallpaper dropdown.
      wallpaperFillMode = "preserveAspectFit";
    };

    # Always boot into a clean session instead of reopening last session's windows.
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    kwin = {
      virtualDesktops = {
        rows = 1;
        number = 4;
      };
    };

    # A single vertical panel anchored to the right edge of the screen.
    # NOTE: declaring `panels` makes plasma-manager rebuild the entire panel
    # layout (it wipes plasma-org.kde.plasma.desktop-appletsrc), so this fully
    # replaces the default bottom panel.
    panels = [
      {
        location = "right";
        # The live panel floats with a 46px thickness (plasmashellrc).
        floating = true;
        height = 46;
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
          # Virtual-desktop pager.
          "org.kde.plasma.pager"
          # icon-only task manager (the labelled one looks poor when vertical)
          {
            iconTasks.launchers = [
              "applications:com.mitchellh.ghostty.desktop"
              "applications:firefox.desktop"
              "applications:vivaldi-stable.desktop"
              "applications:dev.zed.Zed.desktop"
              "applications:xivlauncher.desktop"
            ];
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              calendar = {
                firstDayOfWeek = "sunday";
                showWeekNumbers = true;
              };
              date.format = "isoDate";
              time.format = "24h";
            };
          }
          # Show-desktop button pinned to the far end of the panel.
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    # Natural scrolling for mice. Plasma keys this per physical device, so each
    # mouse must be listed by name/vendorId/productId (see
    # /proc/bus/input/devices). Add more entries here for other machines' mice.
    input.mice = [
      # Framework16 pointing devices.
      {
        name = "ELECOM TrackBall Mouse HUGE TrackBall";
        vendorId = "056e";
        productId = "010c";
        enable = true;
        naturalScroll = true;
      }
      {
        name = "Keychron Keychron Q6 Mouse";
        vendorId = "3434";
        productId = "0161";
        enable = true;
        naturalScroll = true;
      }
      # Framework13: the Keychron C2 exposes a pointer device, and the
      # built-in consumer-control device also carries scroll settings.
      {
        name = "Keychron Keychron C2";
        vendorId = "05ac";
        productId = "024f";
        enable = true;
        naturalScroll = true;
        acceleration = 1;
        scrollSpeed = 7;
      }
      {
        name = "FRMW0001:00 32AC:0006 Consumer Control";
        vendorId = "32ac";
        productId = "0006";
        enable = true;
        naturalScroll = true;
      }
    ];

    # Framework13 touchpad (PIXA3854). Mirrors the tap-to-click, natural
    # scroll and acceleration tuning from kcminputrc.
    input.touchpads = [
      {
        name = "PIXA3854:00 093A:0274 Touchpad";
        vendorId = "093a";
        productId = "0274";
        enable = true;
        naturalScroll = true;
        tapDragLock = true;
        middleButtonEmulation = true;
        pointerSpeed = 0.4;
        scrollSpeed = 3;
        rightClickMethod = "twoFingers"; # ClickMethod=2 (clickfinger/two-finger)
      }
    ];

    # Power management. turnOffDisplay.idleTimeout is in seconds.
    powerdevil = {
      AC = {
        powerButtonAction = "hibernate";
        turnOffDisplay = {
          idleTimeout = 1800; # 30 minutes on AC
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "hibernate";
        turnOffDisplay = {
          idleTimeout = 600; # 10 minutes on battery
          idleTimeoutWhenLocked = "immediately";
        };
      };
      lowBattery = {
        powerButtonAction = "hibernate";
      };
      # Hibernate automatically when the battery gets critically low.
      batteryLevels.criticalAction = "hibernate";
    };

    # Screen locking. KDE's auto-lock timeout is a single global value (no
    # per-power-profile split), set to 30 minutes here.
    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      timeout = 30;
      appearance.wallpaper = "${config.home.homeDirectory}/Pictures/backgrounds/Maomao.jpg";
    };

    # plasma-manager has no fill-mode option for the lock screen, so set it on
    # the same config group it writes the wallpaper to. FillMode 1 =
    # preserveAspectFit, i.e. "Scaled, keep proportions".
    configFile.kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General".FillMode = 1;

    # Assorted settings with no dedicated plasma-manager option.
    configFile = {
      # Default web browser.
      kdeglobals."General".BrowserApplication = "vivaldi-stable.desktop";
      # Hide Dolphin's menu bar (hamburger menu instead).
      dolphinrc."MainWindow".MenuBar = "Disabled";
      # Don't autoload the browser-integration reminder or the device automounter.
      kded5rc."Module-browserintegrationreminder".autoload = false;
      kded5rc."Module-device_automounter".autoload = false;
    };

    # Keep whatever isn't declared here under manual control so the desktop
    # stays usable while this config grows.
    overrideConfig = false;
  };
}
