local keys = {
	{
		"s",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
	{
		"R",
		mode = { "n", "x", "o" },
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
	},
}

local opts = {
	modes = {
		search = {
			enabled = true,
		},
		char = {
			jump_labels = true,
		},
	},
}

local M = {
	keys = keys,
	opts = opts,
}

return M
