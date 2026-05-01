{
  config,
  pkgs,
  ...
}:

let
  # Detect if we're on Darwin
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/bzvestey" else "/home/bzvestey";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bzvestey";
  home.homeDirectory = homeDir;

  # Allow unfree packages
  # nixpkgs config is managed by the system flake when using home-manager.useGlobalPkgs = true

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
    ".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;

    "${config.xdg.configHome}/cosmic".source = ../../dotfiles/config/cosmic;
    "${config.xdg.configHome}/hypr".source = ../../dotfiles/config/hypr;
    "${config.xdg.configHome}/smug".source = ../../dotfiles/config/smug;
    "${config.xdg.configHome}/zed".source = ../../dotfiles/config/zed;
    "${config.xdg.configHome}/zellij".source = ../../dotfiles/config/zellij;
  };

  # Home Manager controlled environmebnt variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Gnome settings, for computers it is insalled on.
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

    envExtra = "GARAGE_CONFIG_FILE=\"${homeDir}/.config/garage/config.toml\";\n";

    oh-my-zsh = {
      enable = true;
      custom = "${../../dotfiles/zsh/custom}";
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

  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    settings = {
      user = {
        name = "Bryan Vestey";
        email = "bryan@vestey.dev";
      };
      github = {
        user = "bzvestey";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      font-family = "CommitMono Nerd Font";
      theme = "Dracula+";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Bryan Vestey";
        email = "bryan@vestey.dev";
      };
    };
  };

  programs.k9s = {
    enable = true;
    aliases = {
      dp = "deployments";
      sec = "v1/secrets";
      jo = "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies";
    };
    settings = {
      liveViewAutoRefresh = "false";
      screenDumpDir = "/home/bzvestey/.local/state/k9s/screen-dumps";
      refreshRate = "2";
      maxConnRetry = "5";
      readOnly = "false";
      noExitOnCtrlC = "false";
      ui = {
        enableMouse = "false";
        headless = "false";
        logoless = "false";
        crumbsless = "false";
        reactive = "false";
        noIcons = "false";
        defaultsToFullScreen = "false";
      };
      skipLatestRevCheck = "false";
      disablePodCounting = "false";
      shellPod = {
        image = "busybox:1.35.0";
        namespace = "default";
        limits = {
          cpu = "100m";
          memory = "100Mi";
        };
      };
      imageScans = {
        enable = "false";
        exclusions = {
          namespaces = "[]";
          labels = "{}";
        };
      };
      logger = {
        tail = "100";
        buffer = "5000";
        sinceSeconds = "-1";
        textWrap = "false";
        showTime = "false";
      };
      thresholds = {
        cpu = {
          critical = "90";
          warn = "70";
        };
        memory = {
          critical = "90";
          warn = "70";
        };
      };
    };
  };

  # TUI based file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
    # This might be needed if I continue to have extraction issues
    # package = (yazi.override { _7zz = _7zz-rar; });
    extraPackages = with pkgs; [
      _7zz-rar
    ];
  };
}
