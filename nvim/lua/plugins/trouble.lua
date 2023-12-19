local setup = function()
    local trouble = require('trouble')
    trouble.setup({
        height = 30,
        severity = vim.diagnostic.severity.ERROR
    })
    local map = vim.keymap.set
    map('n', '<leader>xt', function() trouble.toggle('workspace_diagnostics') end)
end

local M = {
    setup = setup
}

return M
