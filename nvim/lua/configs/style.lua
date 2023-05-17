-- Set the scheme
vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'

-- Remove the background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Customize the status bar
vim.cmd([[highlight StatusLeft guifg=#b89984]])
vim.cmd([[highlight StatusRight guifg=#7A6C60]])
vim.cmd([[
    set statusline=%#StatusLeft#\%F\ %R
    set statusline+=\%=
    set statusline+=\%#StatusRight#\ %M\%l:%c\ ]])
