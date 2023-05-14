local builtin = require('telescope.builtin')

-- Load native sorting methods
require('telescope').load_extension('fzf')

-- Find files from current directory
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- Find files within git repository
vim.keymap.set('n', '<leader>fa', builtin.git_files, {})

-- TODO: Search for a specific string
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("> ") });
end)
