-- Lead with space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick escape
vim.keymap.set("i", "kj", "<Esc>")

-- Fast file explorer
vim.keymap.set("n", "<leader>kj", vim.cmd.Ex)

-- Improved searching
vim.keymap.set("n", "/", ":set hls<CR>/")
vim.keymap.set("n", "#", ":set hls<CR>#")
vim.keymap.set("n", "*", ":set hls<CR>*")
vim.keymap.set("n", "HH", ":set invhlsearch<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Invisible characters
vim.keymap.set("n", "LL", ":lua vim.wo.list = not vim.wo.list<CR>", { noremap = true, silent = true })

-- Better scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
vim.keymap.set("v", "]e", vim.diagnostic.goto_next)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)
vim.keymap.set("v", "[e", vim.diagnostic.goto_prev)

vim.keymap.set("n", "]h", vim.cmd.GitGutterNextHunk)
vim.keymap.set("v", "]h", vim.cmd.GitGutterNextHunk)
vim.keymap.set("n", "[h", vim.cmd.GitGutterPrevHunk)
vim.keymap.set("v", "[h", vim.cmd.GitGutterPrevHunk)

-- Wrapped movements
vim.keymap.set("n", "$", "g$")
vim.keymap.set("v", "$", "g$")
vim.keymap.set("n", "0", "g0")
vim.keymap.set("v", "0", "g0")
vim.keymap.set("n", "g$", "$")
vim.keymap.set("v", "g$", "$")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "k", "gk")

-- Moveable selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stable appends
vim.keymap.set("n", "J", "m'J`'")

-- Copyless deletes
vim.keymap.set("n", "dd", '"_dd')

-- System copies
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Silent deletions
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Easier versioning
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>hd", vim.cmd.GitGutterDiffOrig)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Session management
vim.keymap.set("n", "<leader><C-r>", ":source Session.vim<CR>")
vim.keymap.set("n", "<leader><C-s>", ":Obsess<CR>")
vim.keymap.set("n", "<leader><C-x>", ":Obsess!<CR>")
