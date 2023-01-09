require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'cssls',
        'html',
        'jsonls',
        'sumneko_lua',
        'omnisharp',
        'rust_analyzer',
        'dockerls',
        'tsserver',
        'eslint',
        'pyright'
    }
})

local lsp_config = require('lspconfig')

require('mason-lspconfig').setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({})
    end,
    ['sumneko_lua'] = function()
        lsp_config.sumneko_lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'use' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                }
            }
        })
    end,
    ['rust_analyzer'] = function()
        local rust_analyzer_settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy'
                },
                cargo = {
                    allFeatures = true
                },
                rustfmt = {
                    extraArgs = { '+nightly' }
                },
            }
        }


        lsp_config.rust_analyzer.setup({
            settings = rust_analyzer_settings
        })

        require('rust-tools').setup({
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
                    buf_set_keymap('n', '<leader>em', '<cmd>lua require("rust-tools.expand_macro").expand_macro()<CR>',
                        default_opts)
                end,
                settings = rust_analyzer_settings
            },
        })
    end,
    ['omnisharp'] = function()
        lsp_config.omnisharp.setup({
            on_attach = function(_, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

                local mapping_opts = { noremap = true, silent = true }
                buf_set_keymap('n', '<space>t', ':OmniSharpTypeLookup<CR>', mapping_opts)
                -- buf_set_keymap('n', 'gd', ':OmniSharpGotoDefinition<CR>', mapping_opts)
                buf_set_keymap('n', 'fu', ':OmniSharpFixUsings<CR>', mapping_opts)
                buf_set_keymap('n', '<space>s', ':OmniSharpSignatureHelp<CR>', mapping_opts)
            end,
            handlers = {
                ['textDocument/definition'] = require('omnisharp_extended').handler
            }
        })
    end
})

-- vim.lsp.handlers['textDocument/codeAction'] = require('lsputil.codeAction').code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable signs
    signs = false,
})

require("lsp_signature").setup({
    floating_window_above_cur_line = false
})
