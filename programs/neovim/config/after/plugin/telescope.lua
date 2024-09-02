local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Load native sorting methods
telescope.load_extension("fzf")

-- Correct quick spellings
vim.keymap.set("n", "<leader>f ", builtin.spell_suggest)

-- Find tracked repo files
vim.keymap.set("n", "<leader>fa", builtin.git_files)

-- Peak into stashed saves
vim.keymap.set("n", "<leader>fB", builtin.git_stash)

-- View different branches
vim.keymap.set("n", "<leader>fb", builtin.git_branches)

-- Show commits for a file
vim.keymap.set("n", "<leader>fC", builtin.git_bcommits)

-- List the project commits
vim.keymap.set("n", "<leader>fc", builtin.git_commits)

-- Jump to a typed pattern
vim.keymap.set("n", "<leader>fD", builtin.lsp_type_definitions)

-- Learn the implementation
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions)

-- Find all files contained
vim.keymap.set("n", "<leader>ff", builtin.find_files)

-- Reveal unversioned saves
vim.keymap.set("n", "<leader>fg", builtin.git_status)

-- Gain perspective on what matters
vim.keymap.set("n", "<leader>fp", builtin.planets)

-- Show references to code
vim.keymap.set("n", "<leader>fr", builtin.lsp_references)

-- Find files with a string
vim.keymap.set("n", "<leader>fS", function()
	builtin.grep_string({ search = vim.fn.input("> ") })
end)

-- Update for string search
vim.keymap.set("n", "<leader>fs", builtin.live_grep)
