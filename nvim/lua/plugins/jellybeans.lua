return {
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme jellybeans]])
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "None" })
		end,
	},
}
