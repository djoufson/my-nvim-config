-- LSP server configuration.
-- All `cmd` binaries are provided by Mason (its bin dir is prepended to PATH).

vim.lsp.config("csharp_ls", {
  cmd = { "csharp-ls" },
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git" },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "eslint.config.js", "eslint.config.mjs", ".eslintrc.json", ".eslintrc.js", "package.json", ".git" },
})

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
})

-- cspell-lsp: spell-checking LSP. Scoped to prose/commits to avoid noisy
-- diagnostics everywhere; widen `filetypes` if you want it on code too.
vim.lsp.config("cspell_ls", {
  cmd = { "cspell-lsp", "--stdio" },
  filetypes = { "markdown", "text", "gitcommit" },
  root_markers = { ".git" },
})

vim.lsp.enable({ "csharp_ls", "ts_ls", "eslint", "rust_analyzer", "cspell_ls" })
