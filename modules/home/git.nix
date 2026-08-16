{
  osConfig,
  ...
}:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    settings = {
      user = {
        name = osConfig.myConfig.user.displayName;
        email = osConfig.myConfig.user.email;
      };
      github = {
        user = "bzvestey";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
