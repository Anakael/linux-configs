return {
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			flat_ui = false,
		},
		config = function(_, opts)
			local jellybeans = require("jellybeans")
			jellybeans.setup(opts)
			vim.cmd([[colorscheme jellybeans-mono]])
		end,
	},
}
