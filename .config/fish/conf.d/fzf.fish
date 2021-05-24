# Because of scoping rules, to capture the shell variables exactly as they are, we must read
# them before even executing __fzf_search_shell_variables. We use psub to store the
# variables' info in temporary files and pass in the filenames as arguments.
# This variable is intentionally global so that it can be referenced by custom key bindings and tests
set --global fzf_search_vars_cmd '__fzf_search_shell_variables (set --show | psub) (set --names | psub)'

# Set up the default, mnemonic key bindings unless the user has chosen to customize them
if not set --query fzf_fish_custom_keybindings
    # \cp is Ctrl+p
    bind \cp 'fzf; commandline -f repaint'
    bind \cr __fzf_search_history
    bind \cv $fzf_search_vars_cmd

    # set up the same key bindings for insert mode if using fish_vi_key_bindings
    if test "$fish_key_bindings" = fish_vi_key_bindings -o "$fish_key_bindings" = fish_hybrid_key_bindings
        bind --mode insert \cp 'fzf; commandline -f repaint'
        bind --mode insert \cr __fzf_search_history
        bind --mode insert \cv $fzf_search_vars_cmd
    end
end

# If FZF_DEFAULT_OPTS is not set, then set some sane defaults. This also affects fzf outside of this plugin.
# See https://github.com/junegunn/fzf#environment-variables
if not set --query FZF_DEFAULT_OPTS
    # cycle allows jumping between the first and last results, making scrolling faster
    # layout=reverse lists results top to bottom, mimicking the familiar layouts of git log, history, and env
    # border makes clear where the fzf window begins and ends
    # height=90% leaves space to see the current command and some scrollback, maintaining context of work
    # preview-window=wrap wraps long lines in the preview window, making reading easier
    # marker=* makes the multi-select marker more distinguishable from the pointer (since both default to >)
    set --global --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'
end

function _fzf_uninstall --on-event fzf_uninstall
    # Not going to erase FZF_DEFAULT_OPTS because too hard to tell if it was set by the user or by this plugin
    if not set --query fzf_fish_custom_keybindings
        bind --erase --all \cp
        bind --erase --all \cr
        bind --erase --all \cv

        set_color --italics cyan
        echo "fzf.fish key bindings removed"
        set_color normal
    end

    set --erase __fzf_search_vars_cmd
    functions --erase _fzf_uninstall
end
