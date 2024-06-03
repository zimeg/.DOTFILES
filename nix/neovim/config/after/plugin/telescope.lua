local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Load native sorting methods
telescope.load_extension("fzf")

-- Find files from current directory
vim.keymap.set("n", "<leader>ff", builtin.find_files)

-- Find files within git repository
vim.keymap.set("n", "<leader>fa", builtin.git_files)

-- Search for a specific string with ripgrep
vim.keymap.set("n", "<leader>fs", builtin.live_grep)

-- Find files with a specific string
vim.keymap.set("n", "<leader>fd", function()
	builtin.grep_string({ search = vim.fn.input("> ") })
end)
