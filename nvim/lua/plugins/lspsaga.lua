local setup = function()
	require("lspsaga").setup({
		lightbulb = {
			enable = false,
		},
		diagnostic = {
			on_insert = false,
		},
	})

	local map = vim.keymap.set

	map("n", "<space>a", "<cmd>Lspsaga code_action<CR>")
	map("v", "<space>a", "<cmd>Lspsaga code_action<CR>")
	map("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	map("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	local lspsaga_diagnostic = require("lspsaga.diagnostic")
	local severity_opts = { severity = vim.diagnostic.severity.ERROR }
	map("n", "[r", function()
		lspsaga_diagnostic:goto_prev(severity_opts)
	end)
	map("n", "]r", function()
		lspsaga_diagnostic:goto_next(severity_opts)
	end)
	map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
	map("n", "<space>d", "<cmd>Lspsaga hover_doc<CR>")
end

local M = {
	setup = setup,
}

return M
