-- Use :PackerSync to install any new plugins

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- File navigation
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Themes
    use 'savq/melange-nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
end)
