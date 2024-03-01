-- lua/plugins/none-ls.lua
local null = require("null-ls")
local formatter = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

null.setup({
	-- Specify Linters-Formatters-diagnostics
	-- Wraps them into an LSP
	sources = {
        -- Bash
        formatter.shellharden,
        -- Lua
		formatter.stylua,
        -- Web
		formatter.prettier,
        -- Python
        formatter.isort,
        formatter.black,
        diagnostics.mypy,
	},
})

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, {})
