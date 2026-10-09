# Neovim Configuration

A personal [Neovim](https://neovim.io/) config managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim **0.11+** (uses the native `vim.lsp.config` / `vim.lsp.enable` API)
- `git` (for the lazy.nvim bootstrap)
- A [Nerd Font](https://www.nerdfonts.com/) for file-explorer icons
- `csharp-ls` is installed via Mason for C# LSP support

## Install

Clone into your Neovim config directory:

```sh
git clone <this-repo> ~/.config/nvim
```

On first launch, lazy.nvim is bootstrapped automatically and plugins are installed
according to `lazy-lock.json`. Run `:Mason` to install LSP servers, then restart.

## Structure

```
init.lua            -- sets <leader>, then loads config modules in order
lua/config/         -- editor settings (options, autocmds, keymaps, lsp, lazy)
lua/plugins/         -- one file per plugin spec, auto-imported by lazy.nvim
lazy-lock.json      -- pinned plugin versions
```

To add a plugin, create a new file in `lua/plugins/` that returns a lazy.nvim spec.

## Plugins

- **neo-tree.nvim** — file explorer
- **telescope.nvim** — fuzzy finder
- **nvim-lspconfig** + **mason.nvim** + **mason-lspconfig.nvim** — LSP tooling
- **nvim-treesitter** (`main` branch) — syntax highlighting
- **gitsigns.nvim** + **vim-fugitive** — git integration
- **blink.cmp** — autocompletion
- **bufferline.nvim** — VS Code-style tab bar for open files

## Keymaps

Leader is `<Space>`.

### Files & windows

| Mapping       | Action                        |
| ------------- | ----------------------------- |
| `<leader>e`   | Toggle Neo-tree explorer      |
| `<leader>o`   | Focus Neo-tree explorer       |
| `<leader>r`   | Reveal current file in tree   |
| `<leader>w`   | Focus previous window         |

### Tabs (bufferline)

Every file you open becomes a tab in the bar at the top, VS Code-style. These
are buffers, not Vim's native `:tabnew` tab pages.

| Mapping                     | Action                                   |
| --------------------------- | ---------------------------------------- |
| `<S-h>` / `<S-l>`           | Previous / next tab (on-screen order)    |
| `<leader>1` … `<leader>8`   | Go to tab 1–8                            |
| `<leader>9`                 | Go to last tab                           |
| `<leader>bj`                | Jump to a tab by pressing its letter     |
| `<leader>fb`                | Fuzzy-find among open tabs (Telescope)   |
| `<leader>x`                 | Close current tab (keeps the window)     |
| `<leader>bo`                | Close all other tabs                     |
| `<leader>bh` / `<leader>bl` | Move current tab left / right            |
| `<leader>bp`                | Pin / unpin current tab                  |

`<S-h>` / `<S-l>` override Vim's `H` / `L` (cursor to top/bottom of screen).
`]b` / `[b` (Neovim defaults) also cycle buffers, but in buffer-number order.
Clicking a tab switches to it; its `x` or a right-click closes it.

### Telescope

| Mapping       | Action                        |
| ------------- | ----------------------------- |
| `<leader>ff`  | Find files                    |
| `<leader>fg`  | Live grep                     |
| `<leader>fb`  | Buffers                       |
| `<leader>fh`  | Help tags                     |

### Git (gitsigns)

| Mapping       | Action                        |
| ------------- | ----------------------------- |
| `]c` / `[c`   | Next / previous hunk          |
| `<leader>hs`  | Stage hunk                    |
| `<leader>hr`  | Reset hunk                    |
| `<leader>hp`  | Preview hunk                  |
| `<leader>hb`  | Blame line                    |

Inline blame for the current line shows automatically (no keymap).

### Completion (blink.cmp)

`default` preset — does not remap `<Tab>` or `<CR>`. Insert mode.

| Mapping            | Action                        |
| ------------------ | ----------------------------- |
| `<C-l>`            | Open/toggle completion menu   |
| `<C-y>`            | Accept selected item          |
| `<C-n>` / `<C-p>`  | Next / previous item          |
| `<C-e>`            | Dismiss menu                  |
| `<Tab>` / `<S-Tab>`| Jump between snippet fields   |

Entry documentation auto-shows while navigating the menu (no keymap).
`<C-Space>` is intentionally unmapped (conflicts with macOS / not
deliverable by Apple Terminal).

### LSP (documentation & actions)

Normal mode. Requires an LSP attached to the buffer (`:LspInfo`).

| Mapping       | Action                                          |
| ------------- | ----------------------------------------------- |
| `K`           | Hover docs for symbol under cursor (Vim default)|
| `<C-l>`       | Hover docs — same key as completion, by design  |
| `<leader>c`   | Code actions / quick fixes (also `gra`, a Neovim default) |

Press `K` / `<C-l>` again to focus the hover window and scroll it; `q` closes it.

## Behavior

- Buffers auto-reload when files change on disk (with a notification).
- Saving `init.lua` re-sources it automatically. Changes under `lua/` need a
  Neovim restart.
