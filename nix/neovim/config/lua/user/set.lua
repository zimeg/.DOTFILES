vim.opt.guicursor = ""
vim.opt.updatetime = 50

-- Remove the mouse
vim.opt.mouse = ""

-- Silent vim
vim.opt.visualbell = false

-- Fancy line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Space the side bar
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"

-- Smarter indentation
vim.opt.smartindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Fast file explorer
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"

-- Improved searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Line length guards
vim.opt.wrap = false

-- Better scrolling
vim.opt.scrolloff = 6

-- Easier undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undodir"
vim.opt.undofile = true
