return {
	{

		"bassamsdata/namu.nvim",
		opts = {
			-- Enable the modules you want
			namu_symbols = {
				enable = true,
				options = {}, -- here you can configure namu
			},
			-- Optional: Enable other modules if needed
			ui_select = { enable = false }, -- vim.ui.select() wrapper
		},
		keys = {
			{ "<F8>", ":Namu symbols<cr>" },
		},
	},
}
