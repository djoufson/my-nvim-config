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
