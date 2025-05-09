require("termcodes")

vim.api.nvim_create_autocmd({
	"FileType",
}, {
	pattern = {
		"javascript",
		"typescript",
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		vim.bo.tabstop = 2
		vim.fn.setreg(
			"e",
			"otry {" .. CR .. "} catch (error) {" .. CR .. "console.error(error);" .. CR .. "}" .. ESC .. "3k$"
		)
		vim.fn.setreg("l", "yiwoconsole.log();" .. ESC .. "F(" .. ESC .. 'pa", ' .. ESC .. 'p;a"' .. ESC .. "$")
		vim.fn.setreg(
			"t",
			'odescribe("example", () => {' .. CR .. 'it("should", () => {' .. CR .. "});" .. CR .. "});" .. ESC .. "2ko"
		)
	end,
})
