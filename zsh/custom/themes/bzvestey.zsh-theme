# ZSH Theme

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n:%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[magenta]%}%n:%m%{$reset_color%}'
    local user_symbol='➤'
fi

local current_dir='%{$terminfo[bold]$fg[red]%}[%{$terminfo[bold]$fg[blue]%}%~%{$terminfo[bold]$fg[red]%}]%{$reset_color%}'
local git_branch='$(git_prompt_info)'

PROMPT="╭${user_host} ${current_dir}
╰${user_symbol} "
RPROMPT="${git_branch}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
