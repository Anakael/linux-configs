local change_variant = function(direction)
	local luasnip = require("luasnip")
	if luasnip.choice_active() then
		luasnip.change_choice(direction)
	end
end

return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		opts = {
			update_events = "TextChanged,TextChangedI",
		},
		keys = {
			{
				"<C-n>",
				function()
					change_variant(1)
				end,
			},
			mode = { { "i", "s" } },
			{
				"<C-p>",
				function()
					change_variant(-1)
				end,
			},
			mode = { { "i", "s" } },
		},
		config = function(_, opts)
			local luasnip = require("luasnip")
			luasnip.setup(opts)
			local load_snippets = function()
				require("luasnip.loaders.from_vscode").lazy_load({ include = { "rust" } })
				luasnip.filetype_extend("rust", { "rustdoc" })
				require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
				require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
			end
			load_snippets()

			vim.api.nvim_create_user_command("ReloadSnippets", function()
				load_snippets()
			end, {})
		end,
	},
}
