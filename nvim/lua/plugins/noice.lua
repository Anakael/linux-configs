return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				long_message_to_split = true,
				lsp_doc_border = false,
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						find = "before #",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						find = "Couldn't find a trigger char",
					},
					opts = { skip = true },
				},
			},
		},
		keys = {
			{ "<A-n>", ":NoiceDismiss<cr>" },
		},
	},
}
