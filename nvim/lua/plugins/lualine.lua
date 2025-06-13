return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ "yavorski/lualine-macro-recording.nvim" },
		},
		opts = {
			options = {
				theme = "jellybeans",
			},
			sections = {
				lualine_a = { "mode", { "macro_recording", "%S" } },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {},
				lualine_y = {},
			},
		},
	},
}
