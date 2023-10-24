local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.mapleader = ','

opt.smartcase = true
opt.ignorecase = true
opt.autoread = true
opt.swapfile = false
opt.showcmd = true
opt.hidden = true
opt.undofile = true
opt.wildmode = 'longest:full,full'
opt.laststatus = 3

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.foldenable = false

opt.signcolumn = 'yes'
opt.showmatch = true
opt.cursorline = false
opt.number = true
opt.clipboard = 'unnamedplus'
opt.spell = false
opt.langmap =
'ЙЦУКЕНГШЩФЫВАПРОЛДЖЯЧСМИТЬ;QWFPGJLUYARSTDHNEIOZXCVBKM,йцукенгшщфывапролджячсмить;qwfpgjluyarstdhneiozxcvbkm'
opt.updatetime = 300

opt.termguicolors = true
opt.colorcolumn = '100'
opt.wrap = false
opt.joinspaces = false
opt.spelllang = 'en,ru_yo'

cmd [[
    filetype plugin on
    syntax enable
]]

g.instant_markdown_mathjax = 1
g.vim_markdown_math = 1

-- -- Dap

-- Copen
local qf_size = "30"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        cmd(qf_size .. "wincmd_")
    end
})
