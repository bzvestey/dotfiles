{
  config,
  ...
}:

{
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

    envExtra = "GARAGE_CONFIG_FILE=\"${config.home.homeDirectory}/.config/garage/config.toml\";\n";

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
}
