require("termcodes")

vim.api.nvim_create_autocmd({
	"FileType",
}, {
	pattern = {
		"python",
	},
	callback = function()
		vim.fn.setreg("l", 'yiwoprint(f": {}\\n")' .. ESC .. "F:Pf{p$")
	end,
})
