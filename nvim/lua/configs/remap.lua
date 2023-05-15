-- Lead with space
vim.g.mapleader = " "

-- Quick escape
vim.keymap.set("i", "kj", "<Esc>")

-- Fast file explorer
vim.keymap.set("n", "<leader>kj", vim.cmd.Ex)

-- Improved searching
vim.keymap.set("n", "HH", ":nohls<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Moveable selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stable appends
vim.keymap.set("n", "J", "mzJ`z")

-- System copies
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Silent deletions
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Easier undos
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
