return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		lazy = false,
		opts = {
			ensure_installed = {
				"cssls",
				"html",
				"jsonls",
				"lua_ls",
				"dockerls",
				"ts_ls",
				"eslint",
				"pyright",
				"rust_analyzer",
				"typos_lsp",
				"yamlls",
			},
		},
		config = function(_, opts)
			vim.lsp.config("rust_analyzer", {
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

			vim.lsp.config("lua_ls", {
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

			vim.lsp.config("ts_ls", {
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
			})

			vim.diagnostic.config({
				virtual_text = true,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})

			require("mason-lspconfig").setup(opts)
		end,
		keys = {
			{ "gd", vim.lsp.buf.definition },
		},
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {
			filewatching = "roslyn",
		},
		config = function(_, opts)
			vim.lsp.config("roslyn", {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
				},
			})

			require("roslyn").setup(opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf

					if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
						vim.api.nvim_create_autocmd("InsertCharPre", {
							desc = "Roslyn: Trigger an auto insert on '/'.",
							buffer = bufnr,
							callback = function()
								local char = vim.v.char

								if char ~= "/" then
									return
								end

								local row, col = unpack(vim.api.nvim_win_get_cursor(0))
								row, col = row - 1, col + 1
								local uri = vim.uri_from_bufnr(bufnr)

								local params = {
									_vs_textDocument = { uri = uri },
									_vs_position = { line = row, character = col },
									_vs_ch = char,
									_vs_options = {
										tabSize = vim.bo[bufnr].tabstop,
										insertSpaces = vim.bo[bufnr].expandtab,
									},
								}

								-- NOTE: We should send textDocument/_vs_onAutoInsert request only after
								-- buffer has changed.
								vim.defer_fn(function()
									client:request(
										---@diagnostic disable-next-line: param-type-mismatch
										"textDocument/_vs_onAutoInsert",
										params,
										function(err, result, _)
											if err or not result then
												return
											end

											vim.snippet.expand(string.gsub(result._vs_textEdit.newText, "\r\n", "\n"))
										end,
										bufnr
									)
								end, 1)
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			floating_window_above_cur_line = true,
			handler_opts = {
				border = "none",
			},
		},
	},
}
