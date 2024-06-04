local jdtls = require("jdtls")

local config = {
	cmd = { vim.fn.getenv("JDTLS_PATH") },
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
}
jdtls.start_or_attach(config)
