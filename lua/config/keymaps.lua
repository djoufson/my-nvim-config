-- Key mappings.

local map = vim.keymap.set

-- Neo-tree / window navigation
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Neotree: toggle explorer", silent = true })
map("n", "<leader>o", ":Neotree focus<CR>", { desc = "Neotree: focus explorer", silent = true })
map("n", "<leader>w", "<C-w>p", { desc = "Focus previous window (workspace)", silent = true })
map("n", "<leader>r", ":Neotree reveal<CR>", { desc = "Neotree: reveal current file", silent = true })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope: find files", silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope: live grep", silent = true })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope: buffers", silent = true })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope: help tags", silent = true })

-- Gitsigns
local function gs()
  return require("gitsigns")
end

map("n", "]c", function() gs().nav_hunk("next") end, { desc = "Gitsigns: next hunk", silent = true })
map("n", "[c", function() gs().nav_hunk("prev") end, { desc = "Gitsigns: previous hunk", silent = true })
map("n", "<leader>hs", function() gs().stage_hunk() end, { desc = "Gitsigns: stage hunk", silent = true })
map("n", "<leader>hr", function() gs().reset_hunk() end, { desc = "Gitsigns: reset hunk", silent = true })
map("n", "<leader>hp", function() gs().preview_hunk() end, { desc = "Gitsigns: preview hunk", silent = true })
map("n", "<leader>hb", function() gs().blame_line() end, { desc = "Gitsigns: blame line", silent = true })
