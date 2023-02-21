local setup = function()
    require('lualine').setup({
        options = {
            theme = 'codedark'
        },
        sections = {
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = {},
            lualine_y = {},
        }
    })
end

local M = {
    setup = setup
}

return M

