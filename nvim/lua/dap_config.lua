local dap = require('dap')

dap.adapters.cs = {
  type = 'executable',
  command = '/usr/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

require('dap.ext.vscode').load_launchjs()
