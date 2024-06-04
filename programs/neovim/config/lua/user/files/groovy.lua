vim.api.nvim_create_autocmd({
	"BufRead",
	"BufNewFile",
}, {
	pattern = "*.gradle",
	callback = function()
		vim.cmd.set("filetype=groovy")
	end,
})
