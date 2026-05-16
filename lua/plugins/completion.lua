-- Autocompletion: blink.cmp (Rust-core fuzzy matching, batteries included).
-- `version = "*"` pulls a tagged release that ships a prebuilt fuzzy binary,
-- so no Rust toolchain / build step is required.
return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    -- `default` preset: <C-space> open, <C-y> accept, <C-n>/<C-p> or
    -- <Up>/<Down> to cycle, <C-e> hide. Doesn't hijack <Tab>/<CR>.
    keymap = { preset = "default" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
