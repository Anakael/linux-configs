return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
		},
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"python",
				"c_sharp",
				"rust",
				"lua",
				"cpp",
				"tsx",
				"scss",
				"html",
				"vim",
				"regex",
				"bash",
				"markdown",
				"markdown_inline",
				"hyprlang",
				"just",
			},
		},
		init = function()
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
		end,
	},
}
