local setup = function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"cssls",
			"html",
			"jsonls",
			"lua_ls",
			"omnisharp",
			"rust_analyzer",
			"dockerls",
			"tsserver",
			"eslint",
			"pylyzer",
		},
	})

	local lsp_config = require("lspconfig")

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		["cssls"] = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lsp_config.cssls.setup({
				capabilities = capabilities,
			})
		end,
		["lua_ls"] = function()
			lsp_config.lua_ls.setup({
				settings = {
					Lua = {
						telemetry = {
							enable = false,
						},
						hint = {
							enable = true,
						},
					},
				},
			})
		end,
		["rust_analyzer"] = function()
			lsp_config.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						cargo = {
							allFeatures = true,
						},
						rustfmt = {
							extraArgs = { "+nightly" },
						},
						inlayHints = {
							bindingModeHints = {
								enable = false,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = {
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							reborrowHints = {
								enable = "never",
							},
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			})
		end,
		["omnisharp"] = function()
			lsp_config.omnisharp.setup({
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").handler,
				},
				settings = {
					RoslynExtensionsOptions = {
						InlayHintsOptions = {
							EnableForParameters = true,
							ForLiteralParameters = true,
							ForIndexerParameters = true,
							ForObjectCreationParameters = true,
							ForOtherParameters = true,
							SuppressForParametersThatDifferOnlyBySuffix = false,
							SuppressForParametersThatMatchMethodIntent = false,
							SuppressForParametersThatMatchArgumentName = false,
							EnableForTypes = true,
							ForImplicitVariableTypes = true,
							ForLambdaParameterTypes = true,
							ForImplicitObjectCreatio = true,
						},
					},
				},
			})
		end,
		["tsserver"] = function()
			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end
			lsp_config.tsserver.setup({
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
				on_attach = function(_, _)
					local default_opts = { noremap = false, silent = true }
					local map = vim.keymap.set
					map("", "<space>p", ":Format<cr>:OrganizeImports<cr>", default_opts)
				end,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})
		end,
		["pylyzer"] = function()
			lsp_config.pylyzer.setup({
				settings = {
					python = {
						inlayHints = true,
					},
				},
			})
		end,
	})

	-- Hyprlang LSP
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		pattern = { "*.hl", "hypr*.conf" },
		callback = function(event)
			print(string.format("starting hyprls for %s", vim.inspect(event)))
			vim.lsp.start({
				name = "hyprlang",
				cmd = { "hyprls" },
				root_dir = vim.fn.getcwd(),
			})
		end,
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Disable signs
		signs = false,
	})

	require("lsp_signature").setup({
		floating_window_above_cur_line = true,
	})
	local map = vim.keymap.set
	local vim_lsp = vim.lsp.buf
	-- lsp
	map("n", "gd", vim_lsp.definition)
	-- map('', '<space>f', vim_lsp.format)
	map("", "<space>p", ":ClangdSwitchSourceHeader<CR>")
end

local M = {
	setup = setup,
}

return M
