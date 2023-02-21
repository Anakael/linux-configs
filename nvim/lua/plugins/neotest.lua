local setup = function()
    local neotest = require('neotest')
    neotest.setup({
        adapters = {
            require('neotest-dotnet')({
                discovery_root = 'solution'
            })
        },
        quickfix = {
            enabled = true,
            open = false
        }
    })

    local create_user_command = vim.api.nvim_create_user_command

    create_user_command('Test', function(args)
        local strategy = 'integrated'
        if args.args == "debug" then
            strategy = 'dap'
        end
        neotest.run.run({ strategy = strategy })
    end, { nargs = '?' })

    create_user_command('TestStop', function()
        neotest.run.stop()
    end, {})

    create_user_command('TestSummary', function()
        neotest.summary.toggle()
    end, {})
end

local M = {
    setup = setup
}

return M

