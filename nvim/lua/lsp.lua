local lsp_installer = require 'nvim-lsp-installer'

lsp_installer.on_server_ready(function(server)
	local opts = {}
    if server.name == "sumneko_lua" then

        opts.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the 'vim', 'use' global
                    globals = {'vim', 'use'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    elseif server.name == "rust_analyzer" then
        opts.settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                cargo = {
                    allFeatures = true
                }
            }
        }
        require('rust-tools').setup{
            tools = {
                inlay_hints = {
                    parameter_hints_prefix = '🠔  ',
                    other_hints_prefix = '⇨  '
                }
            },
            server = {
                on_attach = function(_, bufnr)
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local default_opts = { noremap = true, silent = true }
                    buf_set_keymap('n', '<leader>em', '<cmd>lua require("rust-tools.expand_macro").expand_macro()<CR>', default_opts)

                end,
                cmd = server._default_options.cmd,
                settings = opts.settings,
            }
        }
        return
    elseif server.name == "omnisharp" then
        local on_attach = function(_, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            -- Mappings.
            local mapping_opts = { noremap = true, silent = true }
            vim.cmd [[ autocmd CursorHold *.cs :OmniSharpTypeLookup]]
            buf_set_keymap('n', 'gd', ':OmniSharpGotoDefinition<CR>', mapping_opts)
            buf_set_keymap('n', 'gi', ':OmniSharpFindImplementations<CR>', mapping_opts)
            buf_set_keymap('n', 'gu', ':OmniSharpFindUsages<CR>', mapping_opts)
            buf_set_keymap('n', 'od', ':OmniSharpDocumentation<CR>', mapping_opts)
            buf_set_keymap('n', 'fu', ':OmniSharpFixUsings<CR>', mapping_opts)
            buf_set_keymap('', '<C-\\>', ':OmniSharpSignatureHelp<CR>', mapping_opts)
        end
        opts.on_attach = on_attach
    end
	server:setup(opts)
end)

vim.lsp.handlers['textDocument/codeAction'] = require('lsputil.codeAction').code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Disable signs
      signs = false,
    }
  )

-- nvim-cmp settings
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.o.completeopt = 'menuone,noselect'
local cmp = require 'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
        { name = 'path' }
	},
    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<CR>'] = cmp.mapping.confirm(),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = false,
            menu = ({
                buffer = '[Buff]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                path = '[Path]',
        })}),
    },
    experimental = {
        ghost_text = true
    }
}
