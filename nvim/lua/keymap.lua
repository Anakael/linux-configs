local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

vim.g.mapleader = ','

-- no arrows
map('', '<up>', '', default_opts)
map('', '<down>', '', default_opts)
map('', '<left>', '', default_opts)
map('', '<right>', '', default_opts)

-- common
map('n', '<leader>w', ':w<CR>', default_opts)
map('n', '<leader>e', ':tabe %<CR>', default_opts)
map('n', '<F1>', ':noh<CR>', default_opts)

-- lsp
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implemenation()<CR>', default_opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
map('v', '<space>a', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", default_opts)
map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', default_opts)
map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', default_opts)
cmd 'command Format :lua vim.lsp.buf.formatting()<CR>'

-- telescope
map('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files()<CR>', default_opts)
map('n', '<leader>s', '<cmd>lua require("telescope.builtin").grep_string()<CR>', default_opts)
map('n', '<leader><S-s>', '<cmd>lua require("telescope.builtin").live_grep()<CR>', default_opts)
map('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>', default_opts)

-- tagbar
map('', '<F8>', ':TagbarToggle<CR>', default_opts)

-- Ranger
map('', '<leader>n', ':Ranger<CR>', default_opts)
map('', '<leader>r', ':RangerWorkingDirectory<CR>', default_opts)

-- Windows moving
map('n', '<C-J>', '<C-W><C-J>', default_opts)
map('n', '<C-L>', '<C-W><C-L>', default_opts)
map('n', '<C-K>', '<C-W><C-K>', default_opts)
map('n', '<C-H>', '<C-W><C-H>', default_opts)

