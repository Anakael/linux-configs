return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local registry = require("mason-registry")
			registry.refresh(function(success)
				if not success then
					vim.notify("Mason registry refresh failed; see :MasonLog", vim.log.levels.ERROR)
					return
				end
				for _, name in ipairs({ "stylua", "prettierd", "eslint_d", "csharpier" }) do
					local package = registry.get_package(name)
					if not package:is_installed() and not package:is_installing() then
						package:install()
					end
				end
			end)
		end,
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
				"roslyn_ls",
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
			{ "gd", vim.lsp.buf.definition, desc = "LSP definition" },
		},
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
