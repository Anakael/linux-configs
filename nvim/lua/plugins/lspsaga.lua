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
			{ "<leader>rn", "Lspsaga rename<CR>" },
			{ "<space>a", ":Lspsaga code_action<CR>", mode = { "n", "v" }, silent = true },
			{ "<space>d", ":Lspsaga hover_doc<CR>", silent = true },
			{ "]g", ":Lspsaga diagnostic_jump_next<CR>" },
			{ "[g", ":Lspsaga diagnostic_jump_prev<CR>" },
			{
				"]r",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
			},
			{
				"[r",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
			},
		},
	},
}
