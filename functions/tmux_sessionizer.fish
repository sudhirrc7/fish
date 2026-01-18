function __tmux_sessionizer__max_depth
    if set -q TMUX_SESSIONIZER_MAX_DEPTH
        echo $TMUX_SESSIONIZER_MAX_DEPTH
    else
        echo 4
    end
end

function __tmux_sessionizer__list_dirs
    set -l depth (__tmux_sessionizer__max_depth)

    if command -q fd
        fd --type d --hidden --follow --max-depth $depth \
            --exclude .git --exclude node_modules --exclude .cache . $HOME
        return
    end

    if command -q find
        command find -L $HOME -maxdepth $depth \
            \( -name .git -o -name node_modules -o -name .cache \) -prune -o \
            -type d -print
        return
    end
end

function __tmux_sessionizer__preview_cmd
    if command -q eza
        echo 'eza -la --group-directories-first --color=always {} | head -200'
        return
    end

    if command -q exa
        echo 'exa -la --group-directories-first --color=always {} | head -200'
        return
    end

    if command -q ls
        echo 'ls -la {} | head -200'
        return
    end
end

# function __tmux_sessionizer__pick_dir
#     set -l preview (__tmux_sessionizer__preview_cmd)
#     __tmux_sessionizer__list_dirs \
#         | string replace -r '^' '' \
#         | fzf --prompt='dir> ' --height=100% --layout=reverse --border \
#         --preview=$preview --preview-window='right,60%,wrap'
# end

function __tmux_sessionizer__pick_dir
    set -l preview (__tmux_sessionizer__preview_cmd)
    __tmux_sessionizer__list_dirs \
        | string replace -r '^' '' \
        | fzf --prompt='dir> ' \
        --preview=$preview --preview-window='right,60%,wrap'
end

function __tmux_sessionizer__hash
    set -l input $argv[1]

    if command -q md5sum
        echo -n $input | md5sum | awk '{print $1}'
        return
    end

    if command -q sha1sum
        echo -n $input | sha1sum | awk '{print $1}'
        return
    end

    echo 00000000
end

function __tmux_sessionizer__session_name
    set -l dir $argv[1]
    set -l base (basename $dir)
    if test -z "$base"
        set base home
    end

    set base (string replace -ar '[^A-Za-z0-9_]+' '_' -- $base)

    if set -q TMUX_SESSIONIZER_UNIQUE_NAMES
        set -l h (__tmux_sessionizer__hash $dir)
        set -l short (string sub -l 8 -- $h)
        echo "$base""_""$short"
        return
    end

    echo "$base"
end

function __tmux_sessionizer__go
    set -l dir $argv[1]
    if test -z "$dir"
        return 0
    end

    set -l name (__tmux_sessionizer__session_name $dir)

    if set -q TMUX
        tmux has-session -t "$name" 2>/dev/null
        if test $status -eq 0
            tmux switch-client -t "$name"
        else
            tmux new-session -d -s "$name" -c "$dir"
            tmux switch-client -t "$name"
        end
        return 0
    end

    tmux new-session -A -s "$name" -c "$dir"
end

function tmux_sessionizer --description 'Alt+b: fzf home dirs, spawn/switch tmux session in selected dir'
    if not command -q fzf
        echo 'tmux_sessionizer: fzf not found in PATH' 1>&2
        return 127
    end

    if not command -q tmux
        echo 'tmux_sessionizer: tmux not found in PATH' 1>&2
        return 127
    end

    set -l in_popup 0
    if set -q TMUX_SESSIONIZER_IN_POPUP
        set in_popup 1
    end

    if set -q TMUX
        if test $in_popup -eq 0
            tmux display-popup -E -h 80% -w 90% -d "$HOME" "env TMUX_SESSIONIZER_IN_POPUP=1 fish -lc tmux_sessionizer"
            return 0
        end

        set -l dir (__tmux_sessionizer__pick_dir)
        __tmux_sessionizer__go "$dir"
        return 0
    end

    set -l dir (__tmux_sessionizer__pick_dir)
    __tmux_sessionizer__go "$dir"
end
