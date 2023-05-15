-- Lead with space
vim.g.mapleader = " "

-- Quick escape
vim.keymap.set("i", "kj", "<Esc>")

-- Fast file explorer
vim.keymap.set("n", "<leader>kj", vim.cmd.Ex)

-- Improved searching
vim.keymap.set("n", "HH", ":nohls<CR>")

-- Better scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
