-- Set the scheme
vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'

-- Remove the background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
