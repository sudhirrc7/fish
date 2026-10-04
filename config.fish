zoxide init fish | source

alias n='nvim'
alias nvimc="nvim --clean"
alias vi='~/Downloads/nvim-macos-arm64/bin/nvim'
alias vic='~/Downloads/nvim-macos-arm64/bin/nvim --clean'
alias cls='clear'
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l="eza -a | grep -e '^\.'" # show only dotfiles
alias python='python3'
alias update='brew update && brew upgrade && brew cleanup'
alias g++='g++-16'

# alias cat='bat'
# alias chad='NVIM_APPNAME=nvchad nvim'
alias agents='/Users/sudhir/.config/cmux/agents.sh'
if status is-interactive
    bind \eb tmux_sessionizer
end

# if status is-interactive
#     # Enable Vi keybinding
#     fish_vi_key_bindings
#     set fish_cursor_default block
#     set fish_cursor_insert line
#     set fish_vi_force_cursor
# end

function nvimfzf
    nvim (fzf --preview='cat {}')
end

function hxfzf
    hx (fzf --preview='cat {}')
end

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

set -gx ANDROID_HOME /Volumes/devssd/Android/sdk
set -gx ANDROID_SDK_ROOT /Volumes/devssd/Android/sdk
set -gx ANDROID_AVD_HOME /Volumes/devssd/Android/avd

fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path /Users/sudhir/.local/share/nvim/mason/bin
fish_add_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# Set up fzf key bindings
fzf --fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Use Neovim as command line editor
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx PATH $HOME/.duckdb/cli/latest $PATH

# Ctrl+X Ctrl+E → edit command in nvim
bind \cx\ce edit_command_buffer

starship init fish | source

# ${UserConfigDir}/fish/config.fish
# disabled: carapace replaces fish's own completions for ~2000 commands (ls, nvim, cat, ...)
# and breaks the inline path autosuggestions (e.g. `ls dow` -> `ls Downloads/`)
# carapace _carapace | source

fish_add_path /Users/sudhir/.spicetify

# Created by `pipx` on 2026-03-04 15:27:21
set PATH $PATH /Users/sudhir/.local/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME /Users/sudhir/Library/pnpm
if not string match -q -- "$PNPM_HOME/bin" $PATH
    set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

# druk
fish_add_path /Users/sudhir/.druk/bin
