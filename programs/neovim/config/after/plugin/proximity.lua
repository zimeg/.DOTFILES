local proximity = require("proximity")

proximity.setup({
	targets = {
		["<leader>pc"] = { "CHANGELOG.md" },
		["<leader>pf"] = { "flake.nix" },
		["<leader>pm"] = { ".github/MAINTAINERS_GUIDE.md" },
		["<leader>pp"] = { "package.json", "pyproject.toml" },
		["<leader>pr"] = { "README.md" },
	},
})
