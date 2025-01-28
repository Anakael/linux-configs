local setup = function()
    local trouble = require('trouble')
    trouble.setup({
        height = 30,
        severity = vim.diagnostic.severity.ERROR
    })
    local map = vim.keymap.set
    map('n', '<leader>xx', function() trouble.toggle('diagnostics') end)
end

local M = {
    setup = setup
}

return M
