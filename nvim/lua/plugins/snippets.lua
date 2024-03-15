local setup = function()
    local luasnip = require('luasnip');
    luasnip.setup({
        update_events = 'TextChanged,TextChangedI'
    })
    local load_snippets = function()
        require('luasnip.loaders.from_vscode').lazy_load({ include = { 'rust' } })
        luasnip.filetype_extend("rust", { "rustdoc" })
        require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
        require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets', })
    end
    load_snippets()

    local map = vim.keymap.set
    map({ 'i', 's' }, '<C-n>', function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end)
    map({ 'i', 's' }, '<C-p>', function()
        if luasnip.choice_active() then
            luasnip.change_choice(-1)
        end
    end)

    local create_user_command = vim.api.nvim_create_user_command
    create_user_command('ReloadSnippets', function()
        load_snippets()
    end, {})
end

local M = {
    setup = setup
}

return M
