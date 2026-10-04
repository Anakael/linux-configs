return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		dependencies = { "mason-org/mason.nvim" },
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.install({
				"python", "c_sharp", "rust", "lua", "cpp", "tsx", "typescript", "javascript",
				"scss", "css", "html", "json", "yaml", "vim", "regex", "bash",
				"markdown", "markdown_inline", "just",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("ConfigTreesitter", { clear = true }),
				desc = "Enable Treesitter highlighting when a parser is available",
				callback = function(args)
					-- Parser installation is asynchronous; keep syntax highlighting until it is ready.
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if lang and vim.treesitter.language.add(lang) then
						vim.treesitter.start(args.buf, lang)
					end
				end,
			})
		end,
	},
}
