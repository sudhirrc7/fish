zoxide init fish | source

alias n='nvim'
alias cls='clear'
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles
alias python='python3'
alias update='brew update && brew upgrade && brew cleanup'
alias cat ='bat'

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

starship init fish | source

# ${UserConfigDir}/fish/config.fish
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source

fish_add_path /Users/sudhir/.spicetify
