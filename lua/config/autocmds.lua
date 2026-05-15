-- Autocommands.

-- Auto-reload buffers when the underlying file changes on disk.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("AutoReloadExternal", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.bufexists(vim.api.nvim_get_current_buf()) == 1 then
      vim.cmd("checktime")
    end
  end,
})

-- Notify when a buffer was reloaded because the file changed externally.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("AutoReloadNotify", { clear = true }),
  callback = function()
    vim.notify("File changed on disk — buffer reloaded", vim.log.levels.WARN)
  end,
})

-- Reload the config when init.lua is saved.
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/init.lua",
  callback = function()
    vim.cmd("source <afile>")
    vim.notify("init.lua reloaded", vim.log.levels.INFO)
  end,
})
