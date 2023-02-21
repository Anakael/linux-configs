local cmd = vim.cmd

local setup = function()
    require('nightfox').setup({
        palettes = {
            nightfox = {
                bg1 = "#1d1f21",
                bg2 = "#303030"
            }
        }
    })

    cmd('colorscheme nightfox')
end

local M = {
    setup = setup
}

return M
