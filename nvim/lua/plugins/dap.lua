local setup = function()
    local dap = require('dap')
    dap.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes",  size = 0.4 },
                    { id = "watches", size = 0.6 }
                },
                size = 50,
                position = "left"
            },
            {
                elements = {
                    "repl",
                },
                size = 10,
                position = "bottom"
            }
        }
    })
    require('nvim-dap-virtual-text').setup({})


    local netcoredbg_path = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg'
    dap.adapters.cs = {
        type = 'executable',
        command = netcoredbg_path,
        args = { '--interpreter=vscode' }
    }

    require('dap.ext.vscode').load_launchjs()

    local map = vim.keymap.set
    local dapui = require('dapui')
    map('n', '<F29>', dap.terminate) -- C-F5
    map('n', '<F5>', dap.continue)
    map('n', '<F9>', dap.toggle_breakpoint)
    map('n', '<F10>', dap.step_over)
    map('n', '<F11>', dap.step_into)
    map('n', '<F12>', dap.step_out)
    map('n', '<F6>', dapui.toggle)
end

local M = {
    setup = setup
}

return M
