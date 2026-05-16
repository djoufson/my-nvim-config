-- dressing.nvim: render vim.ui.select (LSP code actions, etc.) as a small
-- floating popup at the cursor — same feel as the blink.cmp completion menu.
-- Navigate with <Up>/<Down> (or j/k), <CR> to confirm, <Esc> to cancel.
return {
  "stevearc/dressing.nvim",
  opts = {
    select = {
      -- Force the builtin float. Without this, dressing would auto-pick
      -- Telescope (installed) and show a centered finder instead.
      backend = { "builtin" },
      builtin = {
        relative = "cursor", -- anchor at the cursor, like completion
      },
    },
  },
}
