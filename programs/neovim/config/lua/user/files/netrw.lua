vim.api.nvim_create_autocmd({
	"FileType",
}, {
	pattern = "netrw",
	callback = function()
		vim.opt.relativenumber = true
	end,
})
