return {
	{
		"alvarosevilla95/luatab.nvim",
		opts = {

			windowCount = function(index)
				return index .. " "
			end,
			title = function(bufnr)
				local file = vim.fn.bufname(bufnr)
				local buftype = vim.fn.getbufvar(bufnr, "&buftype")
				local filetype = vim.fn.getbufvar(bufnr, "&filetype")

				if buftype == "help" then
					return "help:" .. vim.fn.fnamemodify(file, ":t:r")
				elseif buftype == "quickfix" then
					return "quickfix"
				elseif filetype == "TelescopePrompt" then
					return "Telescope"
				elseif buftype == "terminal" then
					local _, mtch = string.match(file, "term:(.*):(%a+)")
					return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
				elseif file == "" then
					return "[Empty]"
				else
					return vim.fn.fnamemodify(file, ":p:h:t") .. "/" .. vim.fn.fnamemodify(file, ":t")
				end
			end,
		},
	},
}
