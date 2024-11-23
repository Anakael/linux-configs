local M = {
    lsp = require('plugins.lsp').setup,
    nightfox = require('plugins.nightfox').setup,
    cmp = require('plugins.cmp').setup,
    snippets = require('plugins.snippets').setup,
    telescope = require('plugins.telescope').setup,
    treesitter = require('plugins.treesitter').setup,
    lspsaga = require('plugins.lspsaga').setup,
    lualine = require('plugins.lualine').setup,
    luatab = require('plugins.luatab').setup,
    noice = require('plugins.noice').setup,
    neotest = require('plugins.neotest').setup,
    oil = require('plugins.oil').setup,
    trouble = require('plugins.trouble').setup,
    conform = require('plugins.conform').setup,
    flash = require('plugins.flash'),
}

return M
