require("termcodes")

vim.api.nvim_create_autocmd({
	"FileType",
}, {
	pattern = {
		"go",
	},
	callback = function()
		vim.fn.setreg("e", "oif err != nil {" .. CR .. "return err" .. CR .. "}" .. ESC)
		vim.fn.setreg("l", 'yiwofmt.Printf("%+v\\n", )' .. ESC .. "hpF(lpa: " .. ESC .. "$")
		vim.fn.setreg(
			"t",
			"ofunc TestExample(t *testing.T) {"
				.. CR
				.. "tests := map[string]struct{}{}"
				.. CR
				.. "for name, tt := range tests {"
				.. CR
				.. "t.Run(name, func(t *testing.T) {"
				.. CR
				.. "})"
				.. CR
				.. "}"
				.. CR
				.. "}"
				.. ESC
				.. "5k$2hi"
		)
	end,
})
