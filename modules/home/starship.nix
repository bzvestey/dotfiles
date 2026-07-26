{
  pkgs,
  ...
}:

{
  # Setup Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    extraPackages = [
      pkgs.jj-starship
    ];

    settings = {
      add_newline = false;

      format = "╭─$username$hostname$directory\n├─\${custom.jj}\n╰─$character";
      right_format = "";

      username = {
        show_always = true;
        style_user = "bold purple";
        style_root = "bold red";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold purple";
        format = ":[$hostname]($style) ";
      };

      directory = {
        format = "[$path]";
        truncation_length = 24;
        truncate_to_repo = false;
        truncation_symbol = ".../";
        repo_root_style = "bold cyan";
        before_repo_root_style = "bold blue";
        style = "bold cyan";
      };

      character = {
        success_symbol = "[➤](bold default)";
        error_symbol = "[➤](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      git_branch = {
        disabled = true;
        symbol = "";
        style = "bold yellow";
        format = "[‹](bold yellow)[$symbol$branch]($style)";
      };

      git_status = {
        disabled = true;
        style = "bold red";
        format = "[$all_status]($style)[›](bold yellow)";
        conflicted = " =";
        ahead = " ⇡";
        behind = " ⇣";
        diverged = " ⇕";
        untracked = " ✗";
        stashed = " $";
        modified = " ✗";
        staged = " +";
        renamed = " »";
        deleted = " ✘";
      };

      custom = {
        jj = {
          when = "jj-starship detect";
          shell = "jj-starship";
          format = "$output";
        };
      };
    };
  };
}
