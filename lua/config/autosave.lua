-- Auto-save, VS Code `files.autoSave: afterDelay` style.
--
-- Writing happens on a debounce: every edit restarts a per-buffer timer and the
-- write lands DELAY_MS after you stop typing, so a burst of keystrokes is one
-- write, not one per character. Leaving insert mode, leaving the buffer or
-- losing focus flushes immediately (VS Code's `onFocusChange`).
--
-- Writes go through `update`, which is a no-op when the buffer isn't modified,
-- and they do NOT suppress autocmds — BufWritePost still fires, so anything
-- hanging off save (format-on-save, linters, the config reload) keeps working.

local DELAY_MS = 1000

-- Filetypes that are meant to be reviewed and written explicitly.
local excluded_filetypes = {
  gitcommit = true,
  gitrebase = true,
  ["neo-tree"] = true,
}

vim.g.autosave_enabled = true

local timers = {}

local function should_save(buf)
  if not vim.g.autosave_enabled or vim.b[buf].autosave_disabled then
    return false
  end
  if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].modified then
    return false
  end
  -- Only real, writable, file-backed buffers: skips terminals, quickfix,
  -- help, prompts and plugin scratch buffers (all of which set `buftype`).
  if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable or vim.bo[buf].readonly then
    return false
  end
  if excluded_filetypes[vim.bo[buf].filetype] then
    return false
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" or vim.uv.fs_stat(vim.fs.dirname(name)) == nil then
    return false
  end
  return true
end

local function cancel(buf)
  local timer = timers[buf]
  if timer then
    timer:stop()
    timer:close()
    timers[buf] = nil
  end
end

-- `silent!` keeps a failed write (read-only file, vanished directory) from
-- interrupting typing with an error prompt; `lockmarks` keeps '[ and '] intact.
local function save(buf)
  cancel(buf)
  if not should_save(buf) then
    return
  end
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! lockmarks update")
  end)
end

local function schedule_save(buf)
  cancel(buf)
  if not should_save(buf) then
    return
  end
  local timer = vim.uv.new_timer()
  timers[buf] = timer
  -- uv callbacks run in a fast-event context where the API is off-limits.
  timer:start(DELAY_MS, 0, function()
    vim.schedule(function()
      save(buf)
    end)
  end)
end

local group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Typing (TextChangedI), normal-mode edits and undo/redo (TextChanged).
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = group,
  callback = function(args)
    schedule_save(args.buf)
  end,
})

-- Flush points: don't wait out the delay when the edit is clearly finished.
vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
  group = group,
  callback = function(args)
    save(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = group,
  callback = function(args)
    cancel(args.buf)
  end,
})

vim.api.nvim_create_user_command("AutoSaveToggle", function()
  vim.g.autosave_enabled = not vim.g.autosave_enabled
  vim.notify("Auto-save " .. (vim.g.autosave_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end, { desc = "Toggle auto-save globally" })

vim.api.nvim_create_user_command("AutoSaveToggleBuffer", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.b[buf].autosave_disabled = not vim.b[buf].autosave_disabled
  vim.notify("Auto-save " .. (vim.b[buf].autosave_disabled and "disabled" or "enabled") .. " for this buffer", vim.log.levels.INFO)
end, { desc = "Toggle auto-save for the current buffer" })
