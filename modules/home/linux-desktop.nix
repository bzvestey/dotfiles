_:

{
  xdg.configFile = {
    cosmic.source = ../../dotfiles/config/cosmic;
    hypr.source = ../../dotfiles/config/hypr;
    smug.source = ../../dotfiles/config/smug;
  };

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = [ "<Control><Super>space" ];
      switch-input-source-backward = [ "<Shift><Super>space" ];
    };

    "org/gnome/mutter/keybindings" = {
      switch-monitor = [ ];
    };
  };
}
