local setup = function()
    local g = vim.g
    g.loaded_netrw = 1
    g.loaded_netrwPlugin = 1
    require("oil").setup({
        view_options = {
            show_hidden = true
        }
    })

    local map = vim.keymap.set
    map('', '<leader>n', ':Oil<CR>')
end

local M = {
    setup = setup
}

return M
