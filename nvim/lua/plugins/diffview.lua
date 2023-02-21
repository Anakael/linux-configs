local setup = function()
    local actions = require("diffview.actions")
    require('diffview').setup {
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

    local map = vim.keymap.set
    map('n', '<leader>d', ':DiffviewOpen<CR>')
end

local M = {
    setup = setup
}

return M
