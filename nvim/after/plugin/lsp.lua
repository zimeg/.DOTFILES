local lsp = require('lsp-zero')

lsp.preset("recommended")

-- Lanuage configs
lsp.ensure_installed({
    'gopls',
    'lua_ls',
    'rust_analyzer',
})

local config = require('lspconfig')
config.lua_ls.setup(lsp.nvim_lua_ls())

-- General mappings
local cmp = require('cmp')
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
