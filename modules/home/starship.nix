{
  ...
}:

{
  # Setup Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = "╭─$username$hostname$directory\n╰─$character";
      right_format = "$git_branch$git_status";

      username = {
        show_always = true;
        style_user = "bold magenta";
        style_root = "bold red";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold magenta";
        format = ":[$hostname]($style) ";
      };

      directory = {
        format = "[\\[](bold red)[$path](bold blue)[\\]](bold red) ";
        truncation_length = 8;
        truncation_symbol = ".../";
      };

      character = {
        success_symbol = "[➤ ](bold default)";
        error_symbol = "[➤ ](bold red)";
        vimcmd_symbol = "[❮ ](bold green)";
      };

      git_branch = {
        symbol = "";
        style = "bold yellow";
        format = "[‹](bold yellow)[$symbol$branch]($style)";
      };

      git_status = {
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
    };
  };
}
