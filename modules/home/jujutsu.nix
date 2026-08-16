{
  osConfig,
  ...
}:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = osConfig.myConfig.user.displayName;
        email = osConfig.myConfig.user.email;
      };
    };
  };
}
