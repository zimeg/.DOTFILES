local conform = require("conform")

conform.setup({
	quiet = true,
	formatters_by_ft = {
		astro = { "prettierd" },
		bash = { "shfmt" },
		css = { "prettierd" },
		deno = { "denols" },
		go = { "goimports", "gofmt" },
		html = { "prettierd" },
		json = { "jq", "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		nix = { "nixpkgs_fmt" },
		python = { "isort", "black", "ruff" },
		rust = { "rustfmt" },
		sh = { "shfmt" },
		sql = { "pg_format", "sql_formatter" },
		yaml = { "prettierd" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
	format_on_save = function()
		if vim.g.disable_autoformat then
			return
		end
		return {
			lsp_fallback = true,
			timeout_ms = 800,
		}
	end,
	log_level = vim.log.levels.DEBUG,
})
