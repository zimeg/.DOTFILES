local cmplsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local windows = require("lspconfig.ui.windows")

windows.default_options.border = "rounded"

--- Available LSP possibilities
---@class lsp.ClientCapabilities
local capabilities =
	vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmplsp.default_capabilities())

--- Set a new normal mode keymap
---@param lhs string Mapping
---@param rhs function Action
---@param bufnr number Buffer number
local keymap = function(lhs, rhs, bufnr)
	vim.keymap.set("n", lhs, rhs, {
		remap = false,
		silent = true,
		buffer = bufnr,
	})
end

--- Map combos to the buffer LSP on attach
---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
	keymap("gd", vim.lsp.buf.definition, bufnr)
	keymap("gr", vim.lsp.buf.references, bufnr)
	keymap("K", vim.lsp.buf.hover, bufnr)
	keymap("crn", vim.lsp.buf.rename, bufnr)
end

lspconfig.astro.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.biome.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.denols.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	format = false,
})

lspconfig.golangci_lint_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		command = {
			"golangci-lint",
			"run",
			"--output.json.path",
			"stdout",
			"--show-stats=false",
			"--issues-exit-code=1",
		},
	},
})

lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedvariable = true,
				unusedwrite = true,
				useany = true,
			},
			gofumpt = true,
			staticcheck = true,
		},
	},
})

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.htmx.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.jqls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			hint = {
				enable = true,
			},
		},
	},
})

lspconfig.marksman.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.nil_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.ruff.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = lspconfig.util.root_pattern(
		"tailwind.config.cjs",
		"tailwind.config.js",
		"tailwind.config.mjs",
		"tailwind.config.ts"
	),
})

lspconfig.terraformls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tflint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		capabilities.allow_incremental_sync = true
		capabilities.document_formatting = false
	end,
	init_options = {
		maxTsServerMemory = 16384,
	},
	root_dir = lspconfig.util.root_pattern("package.json"),
	single_file_support = false,
})

lspconfig.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		yaml = {
			schemaStore = {
				url = "https://www.schemastore.org/api/json/catalog.json",
				enable = true,
			},
		},
	},
})
