# CLAUDE.md

This repo is a personal fish shell config (`~/.config/fish`) on macOS (Apple Silicon). There is no build or test suite — changes take effect in new shells or after `source ~/.config/fish/config.fish`.

## Where things go

- `config.fish` — aliases, small inline functions, env vars, `PATH`, key bindings, tool init (`zoxide`, `fzf`, `starship`, OrbStack). Most personal edits land here.
- `functions/<name>.fish` — autoloaded functions; the file name must match the function name. Prefer this for anything longer than a few lines.
- `conf.d/*.fish` — sourced before `config.fish`, alphabetically. Personal ones: `deno.fish`, `fvm.fish`.
- `completions/<cmd>.fish` — tab completions.

## Don't hand-edit

- **Fisher-managed files** — anything installed by a plugin in `fish_plugins` (fzf.fish, nvm.fish, bass, sdkman-for-fish, fisher itself): `functions/_fzf_*`, `functions/fzf_configure_bindings.fish`, `functions/nvm.fish`, `functions/_nvm_*`, `functions/bass.fish`, `functions/__bass.py`, `functions/sdk.fish`, `functions/__sdkman-noexport-init.sh`, `functions/fisher.fish`, `conf.d/fzf.fish`, `conf.d/nvm.fish`, `conf.d/sdk.fish`, and their completions. `fisher update` overwrites them. Add/remove plugins via `fisher install` / `fisher remove`, which also update `fish_plugins`.
- **`fish_variables`** — universal variables written by fish (`set -U`). Change values with `set -U`, not by editing the file.
- **Generated completions** — `completions/copilot.fish`, `orbctl.fish`, `docker.fish`, `kubectl.fish`, `bun.fish` come from the tools themselves; regenerate rather than edit.

## Things to know

- The active prompt is **starship** (`starship init fish | source`). `functions/fish_prompt.fish`, `fish_right_prompt.fish` and `fish_mode_prompt.fish` are fully commented out.
- carapace is intentionally disabled (it breaks fish's inline path autosuggestions) — don't re-enable it.
- Vi key bindings are intentionally commented out.
- Android SDK and FVM/Flutter caches live on an external SSD at `/Volumes/devssd`.
- Keep the existing style: 4-space indentation, `fish_add_path` for new `PATH` entries, `set -gx` for exported vars.

## Checking changes

```fish
fish -n config.fish                 # syntax check a file
fish_indent -w functions/foo.fish   # format a file in place
fish -c 'functions foo'             # confirm a function autoloads
```
