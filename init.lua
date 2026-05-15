-- Leader must be set before lazy.nvim loads so plugin keymaps register correctly.
vim.g.mapleader = " "

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.lsp")
require("config.keymaps")
