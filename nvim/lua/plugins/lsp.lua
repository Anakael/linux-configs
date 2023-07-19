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
                -- cmd = {'dotnet' ,'/home/dmitry/Documents/Programming/omnisharp-roslyn/artifacts/publish/OmniSharp.Stdio.Driver/linux-x64/net6.0/OmniSharp.dll', '-v'},
                handlers = {
                    ['textDocument/definition'] = require('omnisharp_extended').handler
                },
            })
        end
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
    map('', '<space>f', vim_lsp.format)
    map('', '<space>t', ':ClangdSwitchSourceHeader<CR>')
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local function toSnakeCase(str)
      return string.gsub(str, "%s*[- ]%s*", "_")
    end

    if client.name == 'omnisharp' then
      local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
      for i, v in ipairs(tokenModifiers) do
        tokenModifiers[i] = toSnakeCase(v)
      end
      local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
      for i, v in ipairs(tokenTypes) do
        tokenTypes[i] = toSnakeCase(v)
      end
    end
  end,
})


local M = {
    setup = setup
}

return M
