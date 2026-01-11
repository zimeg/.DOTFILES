local config = require("nvim-treesitter.config")
local context = require("treesitter-context")

config.setup({
	modules = {},
	ensure_installed = {},
	ignore_install = {},
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

context.setup({
	mode = "topline",
})

vim.treesitter.language.register("markdown", "mdx")
