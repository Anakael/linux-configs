local setup = function()
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			cs = { "csharpier" },
		},
	})
	vim.api.nvim_create_user_command("Format", function(args)
		local range = nil
		if args.count ~= -1 then
			local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			range = {
				start = { args.line1, 0 },
				["end"] = { args.line2, end_line:len() },
			}
		end
		require("conform").format({ lsp_fallback = true, range = range })
	end, { range = true })
	local default_opts = { noremap = false, silent = true }
	local map = vim.keymap.set
	map("", "<space>f", ":Format<cr>", default_opts)
end

local M = {
	setup = setup,
}

return M
