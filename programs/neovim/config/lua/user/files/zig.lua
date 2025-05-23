require("termcodes")

vim.api.nvim_create_autocmd({
	"FileType",
}, {
	pattern = {
		"zig",
	},
	callback = function()
		vim.fn.setreg("l", 'yiwostd.debug.print("{s}\\n", .{});' .. ESC .. "F{pA" .. ESC)
		vim.fn.setreg("t", 'otest "example" {' .. CR .. "}" .. ESC .. "ko")
	end,
})
