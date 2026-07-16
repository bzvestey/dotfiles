{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Per-host user identity. Each host's home.nix sets these; the rest of the
  # home-manager modules read them instead of hard-coding a user.
  options.local.user = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The login username for this host.";
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
      example = "/home/bzvestey";
      description = "The absolute path to the user's home directory on this host.";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "The user's full name, used for VCS (git/jujutsu) identities.";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "The user's email address, used for VCS (git/jujutsu) identities.";
    };
  };

  config = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = config.local.user.username;
    home.homeDirectory = config.local.user.homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
      pkgs.discord
    ];

    xdg.userDirs = {
      enable = true;
      setSessionVariables = true;
      projects = "${config.home.homeDirectory}/dev";
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      ".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;

      "${config.xdg.configHome}/cosmic".source = ../../dotfiles/config/cosmic;
      "${config.xdg.configHome}/hypr".source = ../../dotfiles/config/hypr;
      "${config.xdg.configHome}/smug".source = ../../dotfiles/config/smug;
      "${config.xdg.configHome}/zellij".source = ../../dotfiles/config/zellij;
    };

    # Home Manager controlled environment variables
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # Gnome settings, for computers it is installed on.
    dconf.settings = {
      # Change from just <Super>space so that the search light extension can use it.
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ "<Control><Super>space" ];
        switch-input-source-backward = [ "<Shift><Super>space" ];
      };

      # Stop messing up my screens....
      "org/gnome/mutter/keybindings" = {
        switch-monitor = [ ];
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
