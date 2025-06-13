return {
	{
		"folke/trouble.nvim",
		opts = {
			height = 30,
			severity = vim.diagnostic.severity.ERROR,
		},
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle("diagnostics")
				end,
			},
		},
	},
}
