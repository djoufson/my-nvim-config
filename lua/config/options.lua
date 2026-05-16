-- General editor options.

vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation: 4 spaces, no hard tabs.
vim.opt.expandtab = true -- insert spaces instead of a tab character
vim.opt.shiftwidth = 4 -- width of an indent step (<<, >>, autoindent)
vim.opt.tabstop = 4 -- a literal tab renders as 4 columns
vim.opt.softtabstop = 4 -- <Tab>/<BS> in insert mode acts on 4 spaces
vim.opt.scrolloff = 8 -- scroll offset

vim.opt.autoread = true
vim.opt.updatetime = 1000

vim.o.autowriteall = true

vim.opt.guicursor = "" -- fat cursor
