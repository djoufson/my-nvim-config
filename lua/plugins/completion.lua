-- Autocompletion: blink.cmp (Rust-core fuzzy matching, batteries included).
-- `version = "*"` pulls a tagged release that ships a prebuilt fuzzy binary,
-- so no Rust toolchain / build step is required.
return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    -- `enter` preset, VS Code-style: <CR> accepts the highlighted entry (the
    -- first one is preselected) and falls back to a newline when no menu is
    -- open. <C-n>/<C-p> or <Up>/<Down> to cycle, <C-e> hide.
    -- The preset's menu-toggle is <C-Space>, which collides with a macOS
    -- shortcut AND is undeliverable by Apple Terminal. Moved to <C-l>, a
    -- plain Ctrl+letter chord every terminal can transmit.
    keymap = {
      preset = "enter",
      ["<C-Space>"] = {}, -- release the conflicting key
      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
      -- <Esc> dismisses the menu and stays in insert mode; with no menu
      -- open, "hide" does nothing and <Esc> falls back to leaving insert.
      ["<Esc>"] = { "hide", "fallback" },
    },
    completion = {
      -- Show the doc popup for the highlighted entry automatically while
      -- navigating the menu — no keypress needed to read it.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
