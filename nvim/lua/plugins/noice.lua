local setup = function()
	require("noice").setup({
		lsp = {
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
		views = {
			cmdline_popup = {
				-- border = {
				-- 	style = "none",
				-- 	padding = { 1, 2 },
				-- },
                border = {},
				filter_options = {},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
		},
	})

    local default_opts = { noremap = false, silent = true }
	local map = vim.keymap.set
	map("", "<A-n>", ":NoiceDismiss<cr>", default_opts)
end

local M = {
	setup = setup,
}

return M
