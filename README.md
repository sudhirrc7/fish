# My Fish Config

Personal [fish shell](https://fishshell.com/) configuration for macOS (Apple Silicon), living at `~/.config/fish`.

## Layout

```
config.fish      # main config: aliases, functions, PATH, key bindings, tool init
conf.d/          # snippets auto-sourced before config.fish (fzf, nvm, sdkman, deno, fvm)
functions/       # autoloaded functions (one function per file, named after the file)
completions/     # tab completions (mostly plugin-installed or tool-generated)
fish_plugins     # plugin list managed by fisher
fish_variables   # universal variables, written by fish itself — don't hand-edit
```

## Plugins

Managed with [fisher](https://github.com/jorgebucaran/fisher) (see `fish_plugins`):

- `jorgebucaran/fisher` — plugin manager
- `edc/bass` — run bash scripts/utilities from fish
- `reitzig/sdkman-for-fish` — SDKMAN! (`sdk`) support
- `patrickf1/fzf.fish` — fzf key bindings for files, git log/status, history, processes, variables
- `jorgebucaran/nvm.fish` — Node version manager

Install / sync plugins:

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher update
```

## External tools expected

Not all are required, but the config calls these at startup or in aliases:

| Tool | Used for |
| --- | --- |
| [starship](https://starship.rs/) | prompt |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | smarter `cd` (`z`) |
| [fzf](https://github.com/junegunn/fzf) | fuzzy finding, `nvimfzf`, `hxfzf`, tmux sessionizer |
| [eza](https://github.com/eza-community/eza) | `ls`, `la`, `ll`, `lt`, `l` aliases |
| [neovim](https://neovim.io/) | `$EDITOR` / `$VISUAL`, `n` alias |
| [yazi](https://github.com/sxyazi/yazi) | file manager (`y` cds into the last dir on exit) |
| [tmux](https://github.com/tmux/tmux) + `fd` | `tmux_sessionizer` |
| Homebrew | `update` alias |

Also wired into `PATH`: Android SDK and Flutter/FVM (both on an external SSD at `/Volumes/devssd`), bun, pnpm, deno, duckdb, pipx, Mason (nvim), JetBrains Toolbox, OrbStack.

## Handy bits

| Command / key | What it does |
| --- | --- |
| `Alt+b` | `tmux_sessionizer` — fzf-pick a directory under `$HOME` and open/switch to a tmux session there |
| `Ctrl+X Ctrl+E` | edit the current command line in nvim |
| `y` | launch yazi, cd to where you exit |
| `nvimfzf` / `hxfzf` | fzf-pick a file and open it in nvim / helix |
| `cppfolders` | scaffold `a`–`g` folders with `x.cpp`, `input.txt`, `output.txt` (competitive programming) |
| `update` | `brew update && brew upgrade && brew cleanup` |

`tmux_sessionizer` honours `TMUX_SESSIONIZER_MAX_DEPTH` (default `4`) and `TMUX_SESSIONIZER_UNIQUE_NAMES` (append a path hash to session names).

## Setup on a new machine

```fish
git clone <this-repo> ~/.config/fish
fisher update
```

Then install the tools above (e.g. `brew install starship zoxide fzf eza neovim yazi tmux fd`) and adjust any hard-coded paths in `config.fish` (`/Users/sudhir/...`, `/Volumes/devssd/...`).
