require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets' })
require('luasnip').setup({
    update_events = 'TextChanged,TextChangedI'
})
