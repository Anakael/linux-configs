local map = vim.keymap.set

-- no arrows
map('', '<up>', '')
map('', '<down>', '')
map('', '<left>', '')
map('', '<right>', '')
map('n', 'q:', '')

-- common
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<F1>', ':noh<CR>')
map('n', '<F2>', ':set spell!<CR>')

-- Windows moving
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-H>', '<C-W><C-H>')

-- Tabs
map('n', 'ta', ':tabnew %<CR>')
map('n', 'tq', ':tabclose<CR>')
map('n', 't1', '1gt')
map('n', 't2', '2gt')
map('n', 't3', '3gt')
map('n', 't4', '4gt')
map('n', 't5', '5gt')
