{
  config,
  inputs,
  primaryUser,
  ...
}:

{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # User owning the Homebrew prefix
    user = primaryUser;

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;

    # Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs;
    };

    # Enable fully-declarative tap management.
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    taps = builtins.attrNames config.nix-homebrew.taps ++ [
      "nikitabobko/tap"
    ];
    brews = [
      "node@24"
    ];
    casks = [
      # OS enhancements
      "aerospace"

      # Terminal
      "ghostty"

      # Temporary
      "microsoft-teams"
    ];
  };
}
