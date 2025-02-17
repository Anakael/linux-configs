local setup = function()
	vim.o.completeopt = "menuone,noselect"

	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
		},
		mapping = {
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		formatting = {
			format = require("lspkind").cmp_format({
				with_text = false,
				menu = {
					buffer = "[Buff]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					path = "[Path]",
				},
			}),
		},
		experimental = {
			ghost_text = true,
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "normal:normal,floatborder:borderbg,cursorline:pmenusel,search:none",
			}),
			completion = cmp.config.window.bordered({
				winhighlight = "normal:normal,floatborder:borderbg,cursorline:pmenusel,search:none",
			}),
		},
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
		matching = { disallow_symbol_nonprefix_matching = false },
	})
end

local M = {
	setup = setup,
}

return M
