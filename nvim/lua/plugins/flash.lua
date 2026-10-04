return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"s",
				desc = "Flash jump",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
			},
			{
				"R",
				desc = "Flash Treesitter selection",
				function()
					require("flash").treesitter()
				end,
				mode = { "n", "x", "o" },
			},
		},
	},
}
