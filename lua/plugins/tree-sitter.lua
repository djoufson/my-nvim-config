return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Parsers we want available. Names are *parser* names (e.g. `c_sharp`),
      -- which are not always the same as Neovim filetypes (e.g. `cs`).
      local parsers = { "javascript", "rust", "typescript", "c", "go", "lua", "vim", "vimdoc", "c_sharp", "json", "markdown" }

      require("nvim-treesitter").install(parsers)

      -- On the `main` branch highlighting is per-buffer and opt-in: there is
      -- no global `highlight = { enable = true }`. We start it on FileType.
      -- pcall swallows the error for buffers whose parser isn't installed,
      -- and sidesteps the parser-name vs filetype-name mismatch entirely.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
