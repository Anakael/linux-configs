return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

	-- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'arkav/lualine-lsp-progress'

    -- language
	use 'OmniSharp/omnisharp-vim'

	use 'cespare/vim-toml'

	-- code actions
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'

	-- cmp
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'onsails/lspkind-nvim'

	-- misc
	use 'neutaaaaan/iosvkem'
	use 'jiangmiao/auto-pairs'
    use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
	use 'majutsushi/tagbar'
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
	use 'plasticboy/vim-markdown'
	use 'lervag/vimtex'
	use 'python-rope/ropevim'
	use 'itchyny/vim-cursorword'
	use 'numToStr/Comment.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
	use { 'francoiscabrol/ranger.vim', requires = {'rbgrouleff/bclose.vim'}}
	use 'aklt/plantuml-syntax'
	use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
    use { 'liuchengxu/vim-clap', run = ':Clap install-binary' }

end)
