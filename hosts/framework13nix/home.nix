{
  ...
}:

{
  imports = [
    # Core home-manager configuration
    ../../modules/home/core.nix

    # Program configurations
    ../../modules/home/atuin.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/git.nix
    ../../modules/home/jujutsu.nix
    ../../modules/home/k9s.nix
    ../../modules/home/plasma.nix
    ../../modules/home/ssh.nix
    ../../modules/home/vscode.nix
    ../../modules/home/yazi.nix
    ../../modules/home/zed.nix
    ../../modules/home/zsh.nix
  ];

  # Per-host user identity.
  local.user = {
    username = "bzvestey";
    homeDirectory = "/home/bzvestey";
    fullName = "Bryan Vestey";
    email = "bryan@vestey.dev";
  };
}
