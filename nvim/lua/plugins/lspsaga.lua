return {
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = {
				enable = false,
			},
			ui = {
				border = "none",
			},
		},
		keys = {
			{ "<leader>rn", ":Lspsaga rename<CR>", silent = true, desc = "LSP rename" },
			{ "<space>a", ":Lspsaga code_action<CR>", mode = { "n", "v" }, silent = true, desc = "LSP code action" },
			{ "<space>d", ":Lspsaga hover_doc<CR>", silent = true, desc = "LSP documentation" },
			{
				"]g",
				desc = "Next diagnostic",
				function()
					require("lspsaga.diagnostic"):goto_next()
				end,
				silent = true,
			},
			{
				"[g",
				desc = "Previous diagnostic",
				function()
					require("lspsaga.diagnostic"):goto_prev()
				end,
				silent = true,
			},
			{
				"]r",
				desc = "Next error",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				silent = true,
			},
			{
				"[r",
				desc = "Previous error",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				silent = true,
			},
		},
	},
}
