local setup = function()
	require("namu").setup({
		-- Enable the modules you want
		namu_symbols = {
			enable = true,
			options = {}, -- here you can configure namu
		},
		-- Optional: Enable other modules if needed
		ui_select = { enable = false }, -- vim.ui.select() wrapper
	})
	-- === Suggested Keymaps: ===
	vim.keymap.set("n", "<F8>", ":Namu symbols<cr>", {
		desc = "Jump to LSP symbol",
		silent = true,
	})
end

local M = {
	setup = setup,
}

return M
