local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

opt.smartcase = true
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
opt.langmap = 'ЙЦУКЕНГШЩФЫВАПРОЛДЖЯЧСМИТЬ;QWFPGJLUYARSTDHNEIOZXCVBKM,йцукенгшщфывапролджячсмить;qwfpgjluyarstdhneiozxcvbkm'
opt.updatetime = 300

opt.termguicolors = true
opt.colorcolumn = '100'
opt.wrap = false
opt.joinspaces = false
opt.spelllang= 'en,ru_yo'


cmd [[
    filetype plugin on
    syntax enable
]]

-- g.airline_theme='onedark'
g.instant_markdown_mathjax = 1
g.vim_markdown_math = 1
g.tagbar_position = 'left'
g.tagbar_compact = 1

-- latex
g.Tex_GotoError = 0
g.vimtex_quickfix_enabled = 0
g.vimtex_compiler_latexmk = {
    options = {
        '-pdf',
        '-shell-escape'
    }
}

g.OmniSharp_highlighting = 0
g.OmniSharp_server_path = '/home/dmitry/.local/share/nvim/mason/bin/omnisharp'

-- Lualine
require('lualine').setup {
  options = {
    theme = 'codedark'
  },
  sections = {
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { },
    lualine_y = { },
  }
}

-- Treesitter
require('nvim-treesitter.configs').setup{
    ensure_installed = {'python', 'c_sharp', 'rust', 'lua', 'cpp'},
    highlight = {
        enable = true,
    }
}

-- Comment
require('Comment').setup{
    opleader = {
        lines = 'cc'
    }
}

-- Luatab
require('luatab').setup{
    windowCount = function(index)
        return index .. ' '
    end,
    title = function(bufnr)
        local file = vim.fn.bufname(bufnr)
        local buftype = vim.fn.getbufvar(bufnr, '&buftype')
        local filetype = vim.fn.getbufvar(bufnr, '&filetype')

        if buftype == 'help' then
            return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
        elseif buftype == 'quickfix' then
            return 'quickfix'
        elseif filetype == 'TelescopePrompt' then
            return 'Telescope'
        elseif buftype == 'terminal' then
            local _, mtch = string.match(file, "term:(.*):(%a+)")
            return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
        elseif file == '' then
            return '[Empty]'
        else
            return vim.fn.fnamemodify(file, ':p:h:t') .. '/' .. vim.fn.fnamemodify(file, ':t')
        end
    end
}

-- Dap
require('dapui').setup{
    layouts = {
        {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "watches", size = 0.6 }
            },
            size = 50,
            position = "left"
        },
        {
            elements = {
              "repl",
            },
            size = 10,
            position = "bottom"
        }
    }
}
require('nvim-dap-virtual-text').setup({})


-- Telecope
require('telescope').setup()
g.netrw_banner = 0
require('telescope').load_extension('file_browser')
require('telescope').load_extension('dap')

-- Tests
g['test#csharp#runner'] = 'dotnettest'
g['test#strategy'] = 'dispatch'

--git
require('gitsigns').setup()
local actions = require("diffview.actions")
require('diffview').setup{
    file_panel = {
        win_config = {
            width = 45
        }
    },
    key_bindings = {
        file_panel = {
            ["e"] = actions.goto_file_edit,
            ["o"] = actions.focus_entry,
            ["<space>"] = actions.toggle_stage_entry,
            ["j"] = actions.select_next_entry,
            ["k"] = actions.select_prev_entry,
        }
    }
}
-- lazygit
g.lazygit_floating_window_scaling_factor = 1

-- Copen

local qf_size = "50"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        cmd(qf_size .. "wincmd_")
    end
})

-- Nightfox
require('nightfox').setup({
    palettes = {
        nightfox = {
            bg1 = "#1d1f21",
            bg2 = "#303030"
        }
    }
})

cmd 'colorscheme nightfox'

-- Fidget
require('fidget').setup{}

-- Lsp saga
require('lspsaga').init_lsp_saga({
    code_action_lightbulb = {
        enable = false
    }
})
