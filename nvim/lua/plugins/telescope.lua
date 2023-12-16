local setup = function()
    local g = vim.g
    g.netrw_banner = 0
    require('telescope').setup({
        defaults = {
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.7
            }
        },
    })
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('dap')
    require("telescope").load_extension("noice")
    require("telescope").load_extension("fzf")

    local map = vim.keymap.set
    local telescope = require('telescope.builtin')
    map('n', '<leader>f', telescope.find_files)
    map('n', '<leader>s', telescope.grep_string)
    map('n', '<leader><S-s>', telescope.live_grep)
    map('n', 'gu', telescope.lsp_references)
    map('n', 'gi', telescope.lsp_implementations)
end

local M = {
    setup = setup
}

return M
