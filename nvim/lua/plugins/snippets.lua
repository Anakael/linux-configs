local setup = function()
    require('luasnip').setup({
        update_events = 'TextChanged,TextChangedI'
    })
    require('luasnip.loaders.from_vscode').lazy_load({ include = { 'rust' } })
    require('luasnip').filetype_extend("rust", { "rustdoc" })
    require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
    require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets', })
end

local M = {
    setup = setup
}

return M
