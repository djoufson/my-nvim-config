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

## Keymaps

Leader is `<Space>`.

| Mapping       | Action                        |
| ------------- | ----------------------------- |
| `<leader>e`   | Toggle Neo-tree explorer      |
| `<leader>o`   | Focus Neo-tree explorer       |
| `<leader>r`   | Reveal current file in tree   |
| `<leader>w`   | Focus previous window         |
| `<leader>ff`  | Telescope: find files         |
| `<leader>fg`  | Telescope: live grep          |
| `<leader>fb`  | Telescope: buffers            |
| `<leader>fh`  | Telescope: help tags          |

## Behavior

- Buffers auto-reload when files change on disk (with a notification).
- Saving `init.lua` re-sources it automatically. Changes under `lua/` need a
  Neovim restart.
