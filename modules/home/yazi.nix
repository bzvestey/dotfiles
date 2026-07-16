{
  pkgs,
  ...
}:

{
  # TUI based file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
    settings = {
      extract = {
        rules = [
          {
            name = "*.zip";
            run = "unzip -d \"%(out)\" \"%(in)\"";
          }
          {
            name = "*.tar.gz";
            run = "tar -xzf \"%(in)\"";
          }
          {
            name = "*.rar";
            run = "unrar x \"%(in)\"";
          }
        ];
      };
    };
    package = (pkgs.yazi.override { _7zz = pkgs._7zz-rar; });
    extraPackages = with pkgs; [
      _7zz-rar
      unzip
      gnutar
      unrar
    ];
  };
}
