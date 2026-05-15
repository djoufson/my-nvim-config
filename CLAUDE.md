# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Pure Lua, no build step.

## Commands

- Smoke-test the config loads without errors:
  `nvim --headless "+lua print('ok')" +qa`
- Headless sync of plugins (install/update per `lazy-lock.json`):
  `nvim --headless "+Lazy! sync" +qa`
- Inside Neovim: `:Lazy` (plugin UI), `:Lazy reload <plugin>`, `:checkhealth`, `:Mason` (LSP server installs).

There is no test suite, linter, or build. `lazy-lock.json` pins plugin commits and is committed — update it via `:Lazy update` / `:Lazy sync`.

## Architecture

Load order is defined in `init.lua` and is significant:

1. `vim.g.mapleader` is set in `init.lua` **before anything else** — it must be set before lazy.nvim loads or plugin keymaps register against the wrong leader.
2. `config.options` → `config.autocmds` → `config.lazy` → `config.lsp` → `config.keymaps`.
3. `config.keymaps` is loaded **after** `config.lazy` on purpose: mappings reference plugin commands (`:Neotree`, `:Telescope`) that only exist once plugins are registered.

Directory layout:

- `lua/config/` — non-plugin settings, one concern per file (`options`, `autocmds`, `keymaps`, `lsp`, `lazy`).
- `lua/plugins/` — plugin specs. Every `.lua` file here returns a lazy.nvim spec table and is auto-imported via `{ import = "plugins" }` in `lua/config/lazy.lua`. **To add a plugin, drop a new file here** — do not edit a central list.

`lua/config/lazy.lua` bootstraps lazy.nvim itself (clones it to `stdpath("data")` if missing).

LSP is split: plugin installation (`nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`) lives in `lua/plugins/lsp.lua`, while server enablement (`csharp_ls`) lives in `lua/config/lsp.lua` using the native `vim.lsp.config` / `vim.lsp.enable` API (Neovim 0.11+), not `lspconfig` framework calls.

## Gotchas

- The `ReloadConfig` autocmd in `lua/config/autocmds.lua` only re-sources `init.lua` itself. Edits to files under `lua/` require a full Neovim restart (or targeted `:Lazy reload`) to take effect.
- `csharp_ls` is expected to be provided by Mason; the server config assumes it is on the Mason path.
