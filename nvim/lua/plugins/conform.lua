return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd", "eslint_d" },
				typescriptreact = { "prettierd", "eslint_d" },
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "csharpier",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				conform.format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
		end,
		keys = {
			{ "<space>f", ":Format<cr>", mode = { "n", "v" }, silent = true },
		},
	},
}
