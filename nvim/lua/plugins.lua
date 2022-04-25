return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

	-- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'arkav/lualine-lsp-progress'

	-- debug
    use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
    use { 'theHamsta/nvim-dap-virtual-text', requires = {'mfussenegger/nvim-dap'}}
    use 'nvim-telescope/telescope-dap.nvim'

    -- run
    use 'vim-test/vim-test'
    use 'tpope/vim-dispatch'
    use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }

    -- language
    use 'OmniSharp/omnisharp-vim'
    use { 'simrat39/rust-tools.nvim', requires = { 'nvim-lua/popup.nvim' }}

    use 'cespare/vim-toml'

	-- code actions
    use 'RishabhRD/popfix'
    -- use 'RishabhRD/nvim-lsputils'

    -- cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'onsails/lspkind-nvim'

    -- snipets
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    -- git
    use 'tpope/vim-fugitive'
    use 'kdheepak/lazygit.nvim'
    use 'lewis6991/gitsigns.nvim'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	-- misc
    use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use 'majutsushi/tagbar'
    use 'tpope/vim-surround'
    use { 'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' }}
    use 'lervag/vimtex'
    use 'itchyny/vim-cursorword'
    use 'numToStr/Comment.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'aklt/plantuml-syntax'
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
    use { 'liuchengxu/vim-clap', run = ':Clap install-binary' }
    use 'folke/lsp-colors.nvim'
    use { 'alvarosevilla95/luatab.nvim', requires='kyazdani42/nvim-web-devicons' }
    use 'cohama/lexima.vim'

    -- file manager
    use { "nvim-telescope/telescope-file-browser.nvim" }
end)
