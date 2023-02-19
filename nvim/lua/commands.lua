local create_user_command = vim.api.nvim_create_user_command

-- neotest
local neotest = require('neotest')
create_user_command('Test', function(args)
    local strategy = 'integrated'
    if args.args == "debug" then
        strategy = 'dap'
    end
    neotest.run.run({strategy = strategy})
end, { nargs = '?' })

create_user_command('TestStop', function()
    neotest.run.stop()
end, { })

create_user_command('TestSummary', function()
    neotest.summary.toggle()
end, { })

