return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
        ---@type snacks.Config
		opts = {
            image = { enabled = true },
            indent = { enabled = true },
            lazygit = { enabled = true },
        },
		keys = {
	        { "<leader>g", function() require("snacks").lazygit() end },
        }
	},
}
