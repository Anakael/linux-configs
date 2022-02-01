-- nvim-cmp settings
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.o.completeopt = 'menuone,noselect'
local cmp = require 'cmp'

local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end
    },
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
        { name = 'path' },
        { name = 'ultisnips' }
	},
    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<CR>'] = cmp.mapping.confirm(),
        ['<Tab>'] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.compose({ 'select_next_item', 'jump_forwards' })(fallback)
          end,
          { "i", "s" }
        ),
        ['<S-Tab>'] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.compose({ 'select_prev_item', 'jump_backwards' })(fallback)
          end,
          { "i", "s" }
        ),
    },
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = false,
            menu = ({
                buffer = '[Buff]',
                nvim_lsp = '[LSP]',
                ultisnips = '[UltiSnips]',
                path = '[Path]',
        })}),
    },
    experimental = {
        ghost_text = true
    }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
})
