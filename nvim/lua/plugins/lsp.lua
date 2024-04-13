local setup = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'cssls',
            'html',
            'jsonls',
            'lua_ls',
            'omnisharp',
            'rust_analyzer',
            'dockerls',
            'tsserver',
            'eslint',
            'pyright',
            'clangd',
        }
    })

    local lsp_config = require('lspconfig')

    require('mason-lspconfig').setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
        ['cssls'] = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            lsp_config.cssls.setup({
                capabilities = capabilities
            })
        end,
        ['lua_ls'] = function()
            lsp_config.lua_ls.setup({
                settings = {
                    Lua = {
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
                        buf_set_keymap('n', '<leader>em',
                            '<cmd>lua require("rust-tools.expand_macro").expand_macro()<CR>',
                            default_opts)
                    end,
                    settings = rust_analyzer_settings
                },
            })
        end,
        ['omnisharp'] = function()
            lsp_config.omnisharp.setup({
                handlers = {
                    ['textDocument/definition'] = require('omnisharp_extended').handler
                },
            })
        end,
        ['tsserver'] = function()
            local function organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) }
                }
                vim.lsp.buf.execute_command(params)
            end
            lsp_config.tsserver.setup({
                on_attach = function(_, _)
                    local default_opts = { noremap = false, silent = true }
                    local map = vim.keymap.set
                    map("", "<space>f", ":Format<cr>:OrganizeImports<cr>", default_opts)
                end,
                commands = {
                    OrganizeImports = {
                        organize_imports,
                        description = "Organize Imports",
                    }
                }
            })
        end,
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Disable signs
            signs = false,
        })

    require("lsp_signature").setup({
        floating_window_above_cur_line = true
    })
    local map = vim.keymap.set
    local vim_lsp = vim.lsp.buf
    -- lsp
    map('n', 'gd', vim_lsp.definition)
    -- map('', '<space>f', vim_lsp.format)
    map('', '<space>t', ':ClangdSwitchSourceHeader<CR>')
end

local M = {
    setup = setup
}

return M
