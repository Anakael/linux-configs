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

g.OmniSharp_highlighting = 0
g.OmniSharp_server_path = '/home/dmitry/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run'
g.OmniSharp_selector_ui = 'clap'
g.OmniSharp_selector_findusages = 'clap'

g.ranger_replace_netrw = true
g.ranger_map_keys = false

-- Lualine
require('lualine').setup {
  options = {
    theme = 'codedark'
  },
  sections = {
    lualine_c = { { 'filename', path = 1 }, 'lsp_progress' },
    lualine_x = { },
    lualine_y = { },
  }
}

-- Just wait
-- require("bufferline").setup{
--     options = {
--         numbers = function(opts)
--             return string.format('%s', opts.ordinal)
--         end,
--         show_buffer_close_icons = false,
--         show_close_icon = false,
--         show_tab_indicators = false,
--         tab_size = 1,
--         diagnostics = "nvim_lsp",
--         diagnostics_update_in_insert = true,
--         diagnostics_indicator = function(count, level, diagnostics_dict, context)
--           local s = ""
--           for e, n in pairs(diagnostics_dict) do
--             local sym = e == "error" and " "
--               or (e == "warning" and " " or "" )
--             s = s .. n .. sym .. " "
--           end
--           print(s)
--           if string.len(s) ~= 0 then
--             s = string.sub(s, 1, -2)
--           end
--           return s
--         end
--     }
-- }

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
require('dapui').setup()
require('nvim-dap-virtual-text').setup()

-- Telecope
require('telescope').setup()
-- File manager
require('telescope').load_extension('file_browser')
