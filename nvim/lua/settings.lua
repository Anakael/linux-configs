local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

opt.smartcase = true
opt.autoread = true
opt.swapfile = false
opt.showcmd = true
opt.hidden = true
opt.undofile = true

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.signcolumn = 'yes'
opt.showmatch = true
opt.cursorline = true
opt.number = true
opt.clipboard = 'unnamedplus'
opt.spell = false
opt.langmap = 'ЙЦУКЕНГШЩФЫВАПРОЛДЖЯЧСМИТЬ;QWFPGJLUYARSTDHNEIOZXCVBKM,йцукенгшщфывапролджячсмить;qwfpgjluyarstdhneiozxcvbkm'

opt.background = 'dark'
opt.termguicolors = true
opt.colorcolumn = '100'
opt.wrap = false
opt.joinspaces = false


cmd [[
    filetype plugin on
    syntax enable
	colorscheme Iosvkem
]]

-- g.airline_theme='onedark'
g.instant_markdown_mathjax = 1
g.vim_markdown_math = 1
g.tagbar_position = 'left'
g.tagbar_compact = 1

-- CPP
-- g.cpp_class_scope_highlight = 1
-- g.cpp_member_variable_highlight = 1
-- g.cpp_class_decl_highlight = 1
-- g.cpp_experimental_simple_template_highlight = 1
-- g.cpp_concepts_highlight = 1

g.OmniSharp_highlighting = 0
g.OmniSharp_server_path = '/usr/bin/omnisharp'

g.ranger_replace_netrw = true
g.ranger_map_keys = false

-- Lualine
require('lualine').setup {
  options = {
    theme = 'codedark'
  },
  sections = {
    lualine_b = {'branch', 'diff',
                {'diagnostics',
                    sources={'nvim_lsp'},
                    symbols = {
                        error = ' ', -- xf659
                        warn = ' ', -- xf529
                        info = ' ', -- xf7fc
                        hint = ' ', -- xf838
                    }
                }},
    lualine_c = { { 'filename', path = 1 }, 'lsp_progress' },
    lualine_x = { },
    lualine_y = { },
  }
}

-- Treesitter
require('nvim-treesitter.configs').setup{
    ensure_installed = {'python', 'c_sharp', 'rust', 'lua'},
    highlight = {
        enable = true,
    }
}

-- Comment
require('Comment').setup{
    opleader = {
        line = 'cc'
    }
}

