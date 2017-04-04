# ZSH Theme
ZSH_THEME_GIT_PROMPT_PREFIX="$fg[blue]‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY=" $fg[red]✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" $fg[blue]✔"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n:%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[magenta]%}%n:%m%{$reset_color%}'
    local user_symbol='➤'
fi

local current_dir='%{$terminfo[bold]$fg[red]%}[%{$fg[blue]%}%~%{$terminfo[bold]$fg[red]%}]%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${user_host} ${current_dir}
╰─${user_symbol} "
RPS1="${git_branch}"
