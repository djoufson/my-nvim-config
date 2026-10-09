-- bufferline.nvim: VS Code-style tab bar. Every file you open is a buffer, and
-- every listed buffer shows up as a "tab" across the top — in the order you
-- opened them. (These are buffers, not Vim's native :tabpages, which are
-- window layouts — closer to VS Code's editor groups than to its file tabs.)

-- Close a buffer without closing the window it's shown in. Plain :bdelete
-- closes the window too, which collapses the layout (e.g. leaves Neo-tree as
-- the only window). Instead, show another buffer in every window displaying
-- it first, then delete it.
local function close_buffer(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      local alt = vim.fn.bufnr("#")
      if alt > 0 and alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.cmd.buffer(alt)
      else
        vim.cmd.bprevious()
      end
      -- Last listed buffer: bprevious stayed put, so fall back to an empty one.
      if vim.api.nvim_win_get_buf(win) == buf then
        vim.cmd.enew()
      end
    end)
  end
  -- Autosave covers files, but force so scratch/unnamed buffers can't block.
  pcall(vim.api.nvim_buf_delete, buf, { force = true })
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    -- Shift+h / Shift+l: previous / next tab, in on-screen order.
    -- (Overrides H/L "cursor to top/bottom of screen"; use zt/zb-style
    -- motions or <C-u>/<C-d> instead.)
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Tabs: previous" },
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Tabs: next" },
    -- Reorder the current tab.
    { "<leader>bh", "<cmd>BufferLineMovePrev<CR>", desc = "Tabs: move left" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<CR>", desc = "Tabs: move right" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Tabs: toggle pin" },
    { "<leader>bj", "<cmd>BufferLinePick<CR>", desc = "Tabs: jump (pick by letter)" },
    -- Closing.
    { "<leader>x", function() close_buffer(0) end, desc = "Tabs: close current" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Tabs: close others" },
    -- <leader>1..9: jump to tab by position, like Cmd+1..9 in VS Code.
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Tabs: go to 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Tabs: go to 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Tabs: go to 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Tabs: go to 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Tabs: go to 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Tabs: go to 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Tabs: go to 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Tabs: go to 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer -1<CR>", desc = "Tabs: go to last" },
  },
  opts = {
    options = {
      mode = "buffers",
      close_command = close_buffer, -- the tab's "x" (mouse) and :BufferLineClose*
      right_mouse_command = close_buffer,
      diagnostics = "nvim_lsp", -- error/warning counts on the tab, like VS Code
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      separator_style = "thin",
      -- Keep the tab bar from sitting above the Neo-tree sidebar.
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
}
