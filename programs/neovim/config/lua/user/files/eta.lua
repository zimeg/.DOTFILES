vim.api.nvim_create_autocmd({
	"BufRead",
	"BufNewFile",
}, {
	pattern = "*.eta",
	callback = function()
		vim.cmd.set("filetype=html")
	end,
})
