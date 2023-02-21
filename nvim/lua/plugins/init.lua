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
    diffview = require('plugins.diffview').setup,
    neotest = require('plugins.neotest').setup,
}

return M
