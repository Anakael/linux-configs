return {
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Spectre",
		keys = {
			{ "<leader>rr", function() require("spectre").open() end, desc = "Search and replace in project" },
		},
		opts = {
			default = {
				replace = {
					cmd = "sd",
				},
			},
		},
	},
}
