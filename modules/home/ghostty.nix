{
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.ghostty;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      font-family = "CommitMono Nerd Font";
      theme = "Dracula+";
    };
  };
}
