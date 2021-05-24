source ~/.asdf/asdf.fish

alias fd="fdfind"
alias bat="batcat"

set -gx EDITOR "/usr/bin/vim"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden"
set -gx FZF_DEFAULT_OPTS "
--layout=reverse
--info=inline
--height=80%
--multi
--ansi
--preview-window=:hidden
--preview 'bash -c \"([[ -f {} ]] && (batcat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200\"'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
"

set fzf_fd_opts --hidden --exclude=.git

