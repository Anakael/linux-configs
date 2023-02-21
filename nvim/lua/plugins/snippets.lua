local setup = function()
    local snipmate_path = vim.fn.stdpath('data') .. '/lazy/vim-snippets/snippets'
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets', snipmate_path } })
    require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets' })
    require('luasnip').setup({
        update_events = 'TextChanged,TextChangedI'
    })
end

local M = {
    setup = setup
}

return M
