return {
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = {
				enable = false,
			},
		},
		keys = {
			{ "<space>a", ":Lspsaga code_action<CR>", mode = { "n", "v" }, silent = true },
			{ "<space>d", ":Lspsaga hover_doc<CR>", silent = true },
		},
	},
}
