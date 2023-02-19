local map = vim.keymap.set
local default_opts = { silent = true }

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

local vim_lsp = vim.lsp.buf
-- lsp
map('n', 'gd', vim_lsp.definition, default_opts)
map('', '<space>f', vim_lsp.format, default_opts)
map('', '<space>t', ':ClangdSwitchSourceHeader<CR>', default_opts)

local telescope = require('telescope.builtin')
-- telescope
map('n', '<leader>f', telescope.find_files, default_opts)
map('n', '<leader>s', telescope.grep_string, default_opts)
map('n', '<leader><S-s>', telescope.live_grep, default_opts)
map('n', 'gu', telescope.lsp_references, default_opts)
map('n', 'gi', telescope.lsp_implementations, default_opts)

-- git
map('n', '<leader>d', ':DiffviewOpen<CR>', default_opts)

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

local dap = require('dap')
local dapui = require('dapui')
-- Dap
map('n', '<F29>', dap.terminate, default_opts) -- C-F5
map('n', '<F5>', dap.continue, default_opts)
map('n', '<F9>', dap.toggle_breakpoint, default_opts)
map('n', '<F10>', dap.step_over, default_opts)
map('n', '<F11>', dap.step_into, default_opts)
map('n', '<F12>', dap.step_out, default_opts)
map('n', '<F6>', dapui.toggle, default_opts)

-- Lspsaga
map('n', '<space>a', '<cmd>Lspsaga code_action<CR>', default_opts)
map('v', '<space>a', '<cmd>Lspsaga code_action<CR>', default_opts)
map('n', '[g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', default_opts)
map('n', ']g', '<cmd>Lspsaga diagnostic_jump_next<CR>', default_opts)
local lspsaga_diagnostic = require('lspsaga.diagnostic')
local severity_opts = { severity = vim.diagnostic.severity.ERROR }
map('n', '[r', function()
    lspsaga_diagnostic:goto_prev(severity_opts)
end, default_opts)
map('n', ']r', function()
    lspsaga_diagnostic:goto_next(severity_opts)
end, default_opts)
map('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', default_opts)
map({ 'n', 't' }, '<A-t>', '<cmd>Lspsaga term_toggle fish<CR>', default_opts)
map('n', '<space>d', '<cmd>Lspsaga hover_doc<CR>', default_opts)
map('n', '<F8>', '<cmd>Lspsaga outline<CR>', default_opts)
