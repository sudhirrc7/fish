source /usr/share/cachyos-fish-config/cachyos-config.fish
zoxide init fish | source

alias n='nvim'
alias cls='clear'

if status is-interactive
    bind \eb tmux_sessionizer
end

fish_add_path ~/.config/emacs/bin

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end

# Set up fzf key bindings
fzf --fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opencode
fish_add_path /home/sudhir/.opencode/bin

fish_add_path /home/sudhir/.spicetify

# Use Neovim as command line editor
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx PATH $HOME/.duckdb/cli/latest $PATH

# Ctrl+X Ctrl+E → edit command in nvim
bind \cx\ce edit_command_buffer
