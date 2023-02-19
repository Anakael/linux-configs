return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- lsp
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    -- use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" } -- wait for diagnostics in o#
    -- lsp progress
    use 'j-hui/fidget.nvim'
    use { 'glepnir/lspsaga.nvim', branch = 'main' }
    use 'Hoffs/omnisharp-extended-lsp.nvim'
    use "folke/neodev.nvim"

    -- dap
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'rcarriga/nvim-dap-ui'
    use 'nvim-telescope/telescope-dap.nvim'

    -- tests
    use { 'nvim-neotest/neotest', requires = { 'Issafalcon/neotest-dotnet' } }

    -- languages
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'OmniSharp/omnisharp-vim'
    use { 'simrat39/rust-tools.nvim', requires = { 'nvim-lua/popup.nvim' } }
    -- markdown / tex / plantuml
    use { 'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' } }
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
    use 'lervag/vimtex'
    use 'aklt/plantuml-syntax'
    -- misc
    use 'numToStr/Comment.nvim'

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'onsails/lspkind-nvim'

    -- snipets
    use 'L3MON4D3/LuaSnip'
    use 'honza/vim-snippets'
    use 'saadparwaiz1/cmp_luasnip'

    -- git
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'

    -- misc
    -- core
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- theme
    use 'EdenEast/nightfox.nvim'
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use 'alvarosevilla95/luatab.nvim'
    use({
        "folke/noice.nvim", requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", }
    })

    -- auto
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'tpope/vim-surround'
    -- use 'cohama/lexima.vim' // is it used?

    -- other
    use 'itchyny/vim-cursorword'
    use 'gpanders/editorconfig.nvim' -- // to delete
    use 'kevinhwang91/nvim-bqf'
end)
