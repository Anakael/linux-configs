return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
		},
		cmd = "Telescope",
		opts = {
			defaults = {
				layout_strategy = "vertical",
				layout_config = { preview_height = 0.7, },
			},
        },
        keys = {
            { "<leader>f", function() require("telescope.builtin").find_files() end },
            { "<leader>s", function() require("telescope.builtin").grep_string() end },
            { "<leader><S-s>", function() require("telescope.builtin").live_grep() end },
            { "gu", function() require("telescope.builtin").lsp_references() end },
            { "gi", function() require("telescope.builtin").lsp_implementations() end },
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)
            telescope.load_extension("file_browser")
            -- telescope.load_extension("noice")
            telescope.load_extension("fzf")
        end,
	},
}
