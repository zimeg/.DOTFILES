local lsp = require('lsp-zero')
local config = require('lspconfig')
local cmp = require('cmp')

-- Lanuage configs
lsp.preset("recommended")
lsp.ensure_installed({
    'bashls',
    'denols',
    'gopls',
    'groovyls',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
})

config.denols.setup {
    root_dir = config.util.root_pattern("deno.json", "deno.jsonc"),
}
config.lua_ls.setup(lsp.nvim_lua_ls())
config.rust_analyzer.setup({})
config.tsserver.setup {
    root_dir = config.util.root_pattern("package.json"),
    single_file_support = false
}

-- Text completions
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({ mapping = cmp_mappings })

-- Buffer mappings
lsp.on_attach(function(_client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end)

-- Initialization
lsp.setup()
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
