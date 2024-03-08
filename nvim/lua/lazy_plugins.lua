local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
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

local plugins = require('plugins')

require('lazy').setup({
        {
            {
                'EdenEast/nightfox.nvim',
                priority = 10000,
                config = plugins.nightfox,
            },
            {
                'folke/neodev.nvim',
                config = true,
                dependencies = {
                    'neovim/nvim-lspconfig'
                },
                priority = 1000
            },
            {
                'simrat39/rust-tools.nvim',
                dependencies = {
                    'nvim-lua/popup.nvim'
                },
            },
            {
                'williamboman/mason.nvim',
                dependencies = {
                    'williamboman/mason-lspconfig.nvim',
                    'neovim/nvim-lspconfig',
                    'Hoffs/omnisharp-extended-lsp.nvim',
                    'ray-x/lsp_signature.nvim',
                },
                config = plugins.lsp
            },
            {
                -- lsp progress
                'j-hui/fidget.nvim',
                config = true
            },
            {
                'L3MON4D3/LuaSnip',
                config = plugins.snippets,
                dependencies = { "rafamadriz/friendly-snippets" },
                build = "make install_jsregexp"

            },
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-nvim-lsp',
                    'onsails/lspkind-nvim',
                    'saadparwaiz1/cmp_luasnip',
                },
                config = plugins.cmp
            },
            {
                'nvim-telescope/telescope.nvim',
                dependencies = {
                    'nvim-telescope/telescope-file-browser.nvim'
                },
                config = plugins.telescope
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
            {
                'numToStr/Comment.nvim',
                config = true
            },
            {
                'nvim-treesitter/nvim-treesitter',
                dependencies = {
                    'windwp/nvim-ts-autotag'
                },
                config = plugins.treesitter
            },
            {
                'windwp/nvim-autopairs',
                config = true
            },
            {
                'kevinhwang91/nvim-bqf',
                config = true
            },
            {
                'glepnir/lspsaga.nvim',
                config = plugins.lspsaga
            },
            {
                'nvim-lualine/lualine.nvim',
                config = plugins.lualine
            },
            {
                'alvarosevilla95/luatab.nvim',
                config = plugins.luatab
            },
            {
                'folke/noice.nvim',
                dependencies = {
                    'MunifTanjim/nui.nvim',
                    'rcarriga/nvim-notify'
                },
                config = plugins.noice
            },
            {
                'kevinhwang91/nvim-bqf',
                config = true
            },
            {
                'plasticboy/vim-markdown',
                dependencies = {
                    'godlygeek/tabular'
                }
            },
            {
                'lewis6991/gitsigns.nvim',
                config = true
            },
            {
                'nvim-neotest/neotest',
                dependencies = {
                    'Issafalcon/neotest-dotnet'
                },
                config = plugins.neotest
            },
            {
                'mfussenegger/nvim-dap',
                dependencies = {
                    'theHamsta/nvim-dap-virtual-text',
                    'rcarriga/nvim-dap-ui',
                    'nvim-telescope/telescope-dap.nvim'
                },
                config = plugins.dap
            },
            {
                'stevearc/oil.nvim',
                config = plugins.oil
            },
            {
                'nvim-pack/nvim-spectre',
                dependencies = {
                    'nvim-lua/plenary.nvim',
                }
            },
            {
                "folke/trouble.nvim",
                config = plugins.trouble
            },
            "rafamadriz/friendly-snippets",
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'tpope/vim-surround',
            'itchyny/vim-cursorword',
            'aklt/plantuml-syntax',
            'tpope/vim-fugitive',
        },
    },
    {
        install = {
            colorscheme = { 'nightfox' }
        }
    })
