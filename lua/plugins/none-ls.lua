-- lua/plugins/none-ls.lua
local null = require("null-ls")
local formatter = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

-- LSP intergration to Linters-Formatters
null.setup({
	sources = {
		-- Bash
		formatter.shellharden,
        formatter.shfmt,
		-- Lua
		formatter.stylua,
		-- Web
		formatter.prettier,
        -- Python
        formatter.isort,
        formatter.black,
        diagnostics.mypy,
        diagnostics.flake8,
	},
})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})

