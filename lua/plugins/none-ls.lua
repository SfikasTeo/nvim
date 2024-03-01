-- lua/plugins/none-ls.lua
local null = require("null-ls")
local formatter = null.builtins.formatting
local diagnostic = null.builtins.diagnostics

null.setup({
	-- Specify Linters-Formatters-diagnostics
	-- Wraps them into an LSP
	sources = {
		formatter.stylua,
		formatter.prettier,
	},
})

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})
