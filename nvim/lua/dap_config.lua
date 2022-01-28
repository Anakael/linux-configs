local dap = require('dap')

local log_base_path = '/home/dmitry/Documents/Programming/nosql2h2021-study-programms'

dap.adapters.netcoredbg = {
  type = 'executable',
  command = '/usr/bin/netcoredbg',
  args = {'--interpreter=vscode',
        string.format("--engineLogging=%s/netcoredbg.engine.log", log_base_path),
        string.format("--log=%s/netcoredbg.log", log_base_path),
  }
}

dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    cwd = '/home/dmitry/Documents/Programming/nosql2h2021-study-programms/StudyProgramms.Web/bin/Debug/net5.0/',
    program =  '/home/dmitry/Documents/Programming/nosql2h2021-study-programms/StudyProgramms.Web/bin/Debug/net5.0/StudyProgramms.Web.dll',
    env = { ASPNETCORE_ENVIRONMENT = 'Development' }
  },
}
