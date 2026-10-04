return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim", "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		opts = {
			defaults = {
				layout_strategy = "vertical",
				layout_config = { preview_height = 0.7 },
			},
		},
		keys = {
			{ "<leader>f", function() require("telescope.builtin").find_files() end, desc = "Find files" },
			{ "<leader>s", function() require("telescope.builtin").grep_string() end, desc = "Search word in project" },
			{ "<leader><S-s>", function() require("telescope.builtin").live_grep() end, desc = "Search project" },
			{ "gu", function() require("telescope.builtin").lsp_references() end, desc = "LSP references" },
			{ "gi", function() require("telescope.builtin").lsp_implementations() end, desc = "LSP implementations" },
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},
}
