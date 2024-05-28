local map = vim.keymap.set
local default_options = { silent = true }

-- no arrows
map("", "<up>", "")
map("", "<down>", "")
map("", "<left>", "")
map("", "<right>", "")
map("n", "q:", "")

-- common
map("n", "<leader>w", ":w<CR>", default_options)
map("n", "<leader>q", ":q<CR>", default_options)
map("n", "<F1>", ":noh<CR>", default_options)
map("n", "<F2>", ":set spell!<CR>", default_options)

-- Windows moving
map("n", "<C-J>", "<C-W><C-J>", default_options)
map("n", "<C-L>", "<C-W><C-L>", default_options)
map("n", "<C-K>", "<C-W><C-K>", default_options)
map("n", "<C-H>", "<C-W><C-H>", default_options)

-- -- Tabs
map("n", "ta", ":tabnew %<CR>", default_options)
map("n", "tq", ":tabclose<CR>", default_options)
map("n", "t1", "1gt", default_options)
map("n", "t2", "2gt", default_options)
map("n", "t3", "3gt", default_options)
map("n", "t4", "4gt", default_options)
map("n", "t5", "5gt", default_options)

-- git
map("", "<leader>g", ":LazyGit<cr>", default_options)
map("", "<leader>d", ":DiffviewOpen<CR>", default_options)

-- flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, default_options)
