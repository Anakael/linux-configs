---@type snacks.Config
local opts = {
	image = { enabled = true },
	indent = { enabled = true },
	lazygit = { enabled = true },
}

local keys = {
	{
		"<leader>g",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
}

local M = {
	opts = opts,
    keys = keys
}

return M
