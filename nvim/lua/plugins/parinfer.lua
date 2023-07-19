local setup = function()
    local telescope_fzf_path = vim.fn.stdpath('data') .. '/lazy/parinfer-rust'
    os.execute('cd ' .. telescope_fzf_path .. ' && cargo build --release')
end

local M = {
    setup = setup
}

return M
