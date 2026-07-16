{
  config,
  ...
}:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    settings = {
      user = {
        name = config.local.user.fullName;
        email = config.local.user.email;
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
