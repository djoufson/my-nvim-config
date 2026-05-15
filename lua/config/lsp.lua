-- LSP server configuration.

vim.lsp.config("csharp_ls", {
  cmd = { "csharp-ls" }, -- provided by Mason
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git" },
})

vim.lsp.enable("csharp_ls")
