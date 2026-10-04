local map = vim.keymap.set

-- no arrows
map("", "<up>", "", { desc = "Disable up arrow" })
map("", "<down>", "", { desc = "Disable down arrow" })
map("", "<left>", "", { desc = "Disable left arrow" })
map("", "<right>", "", { desc = "Disable right arrow" })
map("n", "q:", "", { desc = "Disable command-line window" })

-- common
map("n", "<leader>w", ":w<CR>", { silent = true, desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { silent = true, desc = "Close window" })
map("n", "<F1>", ":noh<CR>", { silent = true, desc = "Clear search highlighting" })

-- Windows moving
map("n", "<C-J>", "<C-W><C-J>", { silent = true, desc = "Focus window below" })
map("n", "<C-L>", "<C-W><C-L>", { silent = true, desc = "Focus window right" })
map("n", "<C-K>", "<C-W><C-K>", { silent = true, desc = "Focus window above" })
map("n", "<C-H>", "<C-W><C-H>", { silent = true, desc = "Focus window left" })

-- Tabs
map("n", "ta", ":tabnew %<CR>", { silent = true, desc = "Open file in new tab" })
map("n", "tq", ":tabclose<CR>", { silent = true, desc = "Close tab" })
map("n", "t1", "1gt", { silent = true, desc = "Go to tab 1" })
map("n", "t2", "2gt", { silent = true, desc = "Go to tab 2" })
map("n", "t3", "3gt", { silent = true, desc = "Go to tab 3" })
map("n", "t4", "4gt", { silent = true, desc = "Go to tab 4" })
map("n", "t5", "5gt", { silent = true, desc = "Go to tab 5" })
