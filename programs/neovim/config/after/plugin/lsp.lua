local cmplsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local windows = require("lspconfig.ui.windows")

windows.default_options.border = "rounded"

vim.lsp.enable("astro")
vim.lsp.enable("bashls")
vim.lsp.enable("biome")
vim.lsp.enable("cssls")
vim.lsp.enable("denols")
vim.lsp.enable("dockerls")
vim.lsp.enable("golangci_lint_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("html")
vim.lsp.enable("htmx")
vim.lsp.enable("jqls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("nil_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("terraformls")
vim.lsp.enable("tflint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("yamlls")
vim.lsp.enable("zls")

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

--- Start the LSP for matching project files
---@param files any Searched files
---@return function function Comparator
local matches = function(files)
	local find = lspconfig.util.root_pattern(unpack(files))
	return function(buffer, start)
		local filename = vim.api.nvim_buf_get_name(buffer)
		if find(filename) then
			start()
		end
	end
end

vim.lsp.config["astro"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["bashls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["biome"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["cssls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["denols"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = matches({ "deno.json", "deno.jsonc" }),
}

vim.lsp.config["dockerls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["golangci_lint_ls"] = {
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
}

vim.lsp.config["gopls"] = {
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
}

vim.lsp.config["html"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["htmx"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html" },
}

vim.lsp.config["jqls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["jsonls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["lua_ls"] = {
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
}

vim.lsp.config["marksman"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["nil_ls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
}

vim.lsp.config["pyright"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["ruff"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["rust_analyzer"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["tailwindcss"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	root_markers = {
		"tailwind.config.cjs",
		"tailwind.config.js",
		"tailwind.config.mjs",
		"tailwind.config.ts",
	},
}

vim.lsp.config["terraformls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["tflint"] = {
	capabilities = capabilities,
	on_attach = on_attach,
}

vim.lsp.config["ts_ls"] = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		capabilities.allow_incremental_sync = true
		capabilities.document_formatting = false
	end,
	init_options = {
		maxTsServerMemory = 16384,
	},
	root_dir = matches({ "package.json" }),
	single_file_support = false,
}

vim.lsp.config["yamlls"] = {
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
}

vim.lsp.config["zls"] = {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = matches({ "build.zig" }),
}
