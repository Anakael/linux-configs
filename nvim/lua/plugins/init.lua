return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		config = true,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
	},
	{
		"karb94/neoscroll.nvim",
		config = true,
	},
	{
		-- lsp progress
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"kevinhwang91/nvim-bqf",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "DiffViewOpen",
		keys = {
			{ "<leader>d", ":DiffViewOpen<CR>" },
		},
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = "LspAttach",
		config = true,
	},
	"nvim-lua/plenary.nvim",
	"kyazdani42/nvim-web-devicons",
	"tpope/vim-surround",
	"aklt/plantuml-syntax",
	"tpope/vim-fugitive",
}
