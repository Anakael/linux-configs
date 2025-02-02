local setup = function()
	require("jellybeans").setup()
	vim.cmd.colorscheme("jellybeans")
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "None" })
end

local M = {
	setup = setup,
}

return M
