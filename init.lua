local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.opt.autoread = true
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("AutoReloadExternal", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.bufexists(vim.api.nvim_get_current_buf()) == 1 then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("AutoReloadNotify", { clear = true }),
  callback = function()
    vim.notify("File changed on disk — buffer reloaded", vim.log.levels.WARN)
  end,
})

require("lazy").setup({
  -- NeoTree for IDE like file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  -- LSP support
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" }
  },
})

vim.lsp.config("csharp_ls", {
  cmd = { "csharp-ls" }, -- provided by Mason
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git" },
})

vim.lsp.enable("csharp_ls")

local map = vim.keymap.set

map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Neotree: toggle explorer", silent = true })
map("n", "<leader>o", ":Neotree focus<CR>", { desc = "Neotree: focus explorer", silent = true })
map("n", "<leader>w", "<C-w>p", { desc = "Focus previous window (workspace)", silent = true })
map("n", "<leader>r", ":Neotree reveal<CR>", { desc = "Neotree: reveal current file", silent = true })

map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope: find files", silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope: live grep", silent = true })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope: buffers", silent = true })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope: help tags", silent = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/init.lua",
  callback = function()
    vim.cmd("source <afile>")
    vim.notify("init.lua reloaded", vim.log.levels.INFO)
  end,
})

