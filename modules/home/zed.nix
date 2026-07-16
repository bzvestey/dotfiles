{
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    mutableUserSettings = true;

    userSettings = {
      project_panel = {
        dock = "left";
      };
      outline_panel = {
        dock = "left";
      };
      collaboration_panel = {
        dock = "left";
      };
      agent = {
        dock = "right";
        sidebar_side = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };
      git_panel = {
        dock = "left";
        sort_by_path = false;
      };
    };
  };
}
