local configs = require("nvim-treesitter.configs")
local context = require("treesitter-context")

configs.setup({
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
