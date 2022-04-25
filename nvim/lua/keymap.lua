local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ','

-- no arrows
map('', '<up>', '', default_opts)
map('', '<down>', '', default_opts)
map('', '<left>', '', default_opts)
map('', '<right>', '', default_opts)

-- common
map('n', '<leader>w', ':w<CR>', default_opts)
map('n', '<leader>q', ':q<CR>', default_opts)
map('n', '<F1>', ':noh<CR>', default_opts)
map('n', '<F2>', ':set spell!<CR>', default_opts)

-- lsp
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
map('v', '<space>a', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", default_opts)
map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', default_opts)
map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', default_opts)
map('', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_opts)
map('', '<space>t', ':ClangdSwitchSourceHeader<CR>', default_opts)

-- telescope
map('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files()<CR>', default_opts)
map('n', '<leader>s', '<cmd>lua require("telescope.builtin").grep_string()<CR>', default_opts)
map('n', '<leader><S-s>', '<cmd>lua require("telescope.builtin").live_grep()<CR>', default_opts)
map('n', 'gu', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', default_opts)
map('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', default_opts)

-- git
map('n', '<leader>g', ':LazyGit<CR>', default_opts)
map('n', '<leader>d', ':DiffviewOpen<CR>', default_opts)

-- tagbar
map('', '<F8>', ':TagbarToggle<CR>', default_opts)

-- File manager
map('', '<leader>n', ':Telescope file_browser path=%:p:h<CR>', default_opts)

-- Windows moving
map('n', '<C-J>', '<C-W><C-J>', default_opts)
map('n', '<C-L>', '<C-W><C-L>', default_opts)
map('n', '<C-K>', '<C-W><C-K>', default_opts)
map('n', '<C-H>', '<C-W><C-H>', default_opts)

-- Tabs
map('n', 'ta', ':tabnew %<CR>', default_opts)
map('n', 'tq', ':tabclose<CR>', default_opts)
map('n', 't1', '1gt', default_opts)
map('n', 't2', '2gt', default_opts)
map('n', 't3', '3gt', default_opts)
map('n', 't4', '4gt', default_opts)
map('n', 't5', '5gt', default_opts)

-- Dap
map('n', '<F29>', '<cmd>lua require("dap").terminate()<CR>', default_opts) -- C-F5
map('n', '<F5>', '<cmd>lua require("dap").continue()<CR>', default_opts)
map('n', '<F9>', '<cmd>lua require("dap").toggle_breakpoint()<CR>', default_opts)
map('n', '<F10>', '<cmd>lua require("dap").step_over()<CR>', default_opts)
map('n', '<F11>', '<cmd>lua require("dap").step_into()<CR>', default_opts)
map('n', '<F12>', '<cmd>lua require("dap").step_out()<CR>', default_opts)
map('n', '<F6>', '<cmd>lua require("dapui").toggle()<CR>', default_opts)
