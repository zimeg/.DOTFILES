local proximity = require("proximity")

proximity.setup({
	targets = {
		["<leader>pc"] = {
			"CHANGE.log",
			"CHANGELOG.md",
		},
		["<leader>pf"] = {
			"flake.nix",
		},
		["<leader>pgi"] = {
			".gitignore",
		},
		["<leader>pm"] = {
			".github/MAINTAINERS_GUIDE.md",
			"MAINTAINERS_GUIDE.md",
			"docs/MAINTAINERS_GUIDE.md",
		},
		["<leader>pp"] = {
			"build.gradle",
			"go.mod",
			"main.tf",
			"package.json",
			"pyproject.toml",
		},
		["<leader>pr"] = {
			"README.md",
		},
	},
})
