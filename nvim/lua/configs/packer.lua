-- Use :PackerSync to install any new plugins

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- File navigation
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use('theprimeagen/harpoon')
    use('kshenoy/vim-signature')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- Themes and syntax
    use 'savq/melange-nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Easier versioning
    use('mbbill/undotree')
    use({ 'airblade/vim-gitgutter', branch = 'main' })
    use('tpope/vim-fugitive')
end)
