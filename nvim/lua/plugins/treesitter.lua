return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag"
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
				"just",
			},
		},
	},
}
