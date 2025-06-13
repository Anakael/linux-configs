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
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
			},
			{
				"R",
				function()
					require("flash").treesitter()
				end,
				mode = { "n", "x", "o" },
			},
		},
	},
}
