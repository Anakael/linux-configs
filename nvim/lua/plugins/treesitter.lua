local setup = function()
	require("nvim-treesitter.configs").setup({
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
            "just"
		},
		highlight = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	})

	vim.filetype.add({
		pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
	})

	vim.cmd(":TSUpdate")
end

local M = {
	setup = setup,
}

return M
