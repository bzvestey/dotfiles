{
  ...
}:

{
  imports = [
    # Core home-manager configuration
    ../../modules/home/core.nix

    # Program configurations (Plasma is Linux-only, so it is omitted here)
    ../../modules/home/atuin.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/git.nix
    ../../modules/home/jujutsu.nix
    ../../modules/home/k9s.nix
    ../../modules/home/ssh.nix
    ../../modules/home/vscode.nix
    ../../modules/home/yazi.nix
    ../../modules/home/zed.nix
    ../../modules/home/zsh.nix
  ];

  # Per-host user identity.
  local.user = {
    username = "bzvestey";
    homeDirectory = "/Users/bzvestey";
    fullName = "Bryan Vestey";
    email = "bryan@vestey.dev";
  };
}
