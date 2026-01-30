{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bzvestey";
  home.homeDirectory = "/home/bzvestey";

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.hakuneko
    pkgs.discord

    # Temp
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".ssh/config".source = "/home/bzvestey/dev/dotfiles/ssh/config";
    ".tmux.conf".source = "/home/bzvestey/dev/dotfiles/tmux/tmux.conf";

    "${config.xdg.configHome}/cosmic".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/cosmic";
    "${config.xdg.configHome}/ghostty".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/ghostty";
    "${config.xdg.configHome}/hypr".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/hypr";
    "${config.xdg.configHome}/jj".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/jj";
    "${config.xdg.configHome}/k9s".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/k9s";
    "${config.xdg.configHome}/smug".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/smug";
    "${config.xdg.configHome}/zed".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/zed";
    "${config.xdg.configHome}/zellij".source = "${builtins.getEnv "HOME"}/dev/dotfiles/config/zellij";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bzvestey/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      # Change from just <Super>space so that the search light extension can use it.
      switch-input-source = [ "<Control><Super>space" ];
      switch-input-source-backward = [ "<Shift><Super>space" ];

      # Stop messing up my screens....
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Manage my zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      save = 100000;
      size = 100000;
    };

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.mydotfiles/zsh/custom";
      theme = "bzvestey";
      plugins = [
        "1password"
        "ansible"
        "direnv"
        "docker"
        "git"
        "golang"
        "gpg-agent"
        "kubectl"
        "node"
        "npm"
        "rsync"
        "rust"
        "ssh"
        "ssh-agent"
        "tailscale"
        "tmux"
      ];
    };
  };

  # Setup Atuin
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
  };
  
  # Setup VSCode
  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers
        rust-lang.rust-analyzer
        nefrob.vscode-just-syntax
        redhat.ansible
        redhat.vscode-yaml
        antyos.openscad
      ];
  };
}
