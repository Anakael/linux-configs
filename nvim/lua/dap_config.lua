local dap = require('dap')

dap.adapters.cs = {
  type = 'executable',
  command = '/home/dmitry/.local/share/nvim/mason/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

require('dap.ext.vscode').load_launchjs()
