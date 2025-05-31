local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local plugins = require("plugins")

require("lazy").setup({
	{
		{
			"folke/neodev.nvim",
			config = true,
			dependencies = {
				"neovim/nvim-lspconfig",
			},
			priority = 1000,
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
				"ray-x/lsp_signature.nvim",
			},
			config = plugins.lsp,
		},
		{
			"MysticalDevil/inlay-hints.nvim",
			event = "LspAttach",
			dependencies = { "neovim/nvim-lspconfig" },
			config = function()
				require("inlay-hints").setup()
			end,
		},
		{
			-- lsp progress
			"j-hui/fidget.nvim",
			config = true,
		},
		{
			"L3MON4D3/LuaSnip",
			config = plugins.snippets,
			dependencies = { "rafamadriz/friendly-snippets" },
			build = "make install_jsregexp",
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-cmdline",
				"onsails/lspkind-nvim",
				"saadparwaiz1/cmp_luasnip",
			},
			config = plugins.cmp,
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-telescope/telescope-file-browser.nvim",
			},
			config = plugins.telescope,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"numToStr/Comment.nvim",
			config = true,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"windwp/nvim-ts-autotag",
				"nvim-treesitter/playground",
			},
			config = plugins.treesitter,
		},
		{
			"windwp/nvim-autopairs",
			config = true,
		},
		{
			"kevinhwang91/nvim-bqf",
			config = true,
		},
		{
			"glepnir/lspsaga.nvim",
			config = plugins.lspsaga,
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				-- display macro recording
				{ "yavorski/lualine-macro-recording.nvim" },
			},
			config = plugins.lualine,
		},
		{
			"alvarosevilla95/luatab.nvim",
			config = plugins.luatab,
		},
		{
			"folke/noice.nvim",
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
			config = plugins.noice,
		},
		{
			"kevinhwang91/nvim-bqf",
			config = true,
		},
		{
			"plasticboy/vim-markdown",
			dependencies = {
				"godlygeek/tabular",
			},
		},
		{
			"lewis6991/gitsigns.nvim",
			config = true,
		},
		{
			"nvim-neotest/neotest",
			dependencies = {
				"Issafalcon/neotest-dotnet",
				"nvim-neotest/nvim-nio",
			},
			config = plugins.neotest,
		},
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"theHamsta/nvim-dap-virtual-text",
				"rcarriga/nvim-dap-ui",
				"nvim-telescope/telescope-dap.nvim",
			},
			config = plugins.dap,
		},
		{
			"stevearc/oil.nvim",
			config = plugins.oil,
		},
		{
			"nvim-pack/nvim-spectre",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = plugins.spectre,
		},
		{
			"folke/trouble.nvim",
			config = plugins.trouble,
		},
		{
			"stevearc/conform.nvim",
			config = plugins.conform,
		},
		{
			"sindrets/diffview.nvim",
			cmd = {
				"DiffViewOpen",
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			opts = plugins.flash.opts,
			keys = plugins.flash.keys,
		},
		{

			"bassamsdata/namu.nvim",
			config = plugins.namu,
		},
		{
			"wtfox/jellybeans.nvim",
			priority = 1000,
			config = plugins.jellybeans,
		},
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			opts = plugins.snacks.opts,
			keys = plugins.snacks.keys,
		},
		{
			"karb94/neoscroll.nvim",
			config = plugins.neoscroll,
		},
		{
			"seblyng/roslyn.nvim",
			ft = "cs",
			opts = plugins.roslyn.opts,
		},
		{
			"chentoast/marks.nvim",
			event = "VeryLazy",
			opts = {},
		},
		"rafamadriz/friendly-snippets",
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"tpope/vim-surround",
		"itchyny/vim-cursorword",
		"aklt/plantuml-syntax",
		"tpope/vim-fugitive",
	},
}, {
	install = {
		colorscheme = { "jellybeans" },
	},
})
