{
  config,
  ...
}:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.local.user.fullName;
        email = config.local.user.email;
      };
    };
  };
}
