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
    };

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
        widgets = [
          "org.kde.plasma.kickoff"
          # icon-only task manager (the labelled one looks poor when vertical)
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "24h";
            };
          }
        ];
      }
    ];

    # Natural scrolling for mice. Plasma keys this per physical device, so each
    # mouse must be listed by name/vendorId/productId (see
    # /proc/bus/input/devices). Add more entries here for other machines' mice.
    input.mice = [
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

    # Keep whatever isn't declared here under manual control so the desktop
    # stays usable while this config grows.
    overrideConfig = false;
  };
}
