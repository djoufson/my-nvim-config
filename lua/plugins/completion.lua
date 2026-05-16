-- Autocompletion: blink.cmp (Rust-core fuzzy matching, batteries included).
-- `version = "*"` pulls a tagged release that ships a prebuilt fuzzy binary,
-- so no Rust toolchain / build step is required.
return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    -- `default` preset: <C-y> accept, <C-n>/<C-p> or <Up>/<Down> to cycle,
    -- <C-e> hide. Doesn't hijack <Tab>/<CR>.
    -- The preset's menu-toggle is <C-Space>, which collides with a macOS
    -- shortcut AND is undeliverable by Apple Terminal. Moved to <C-l>, a
    -- plain Ctrl+letter chord every terminal can transmit.
    keymap = {
      preset = "default",
      ["<C-Space>"] = {}, -- release the conflicting key
      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
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
