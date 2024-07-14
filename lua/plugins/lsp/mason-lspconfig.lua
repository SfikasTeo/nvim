-- lua/plugins/mason-lspconfig.lua
require("mason-lspconfig").setup({
	-- Install LSPs that are setup via lspconfig
	automatic_installation = false,

	-- Install following LSPs:
	ensure_installed = {
		"asm_lsp",
		"bashls",
		"clangd",
		"html",
		"tsserver",
		"lua_ls",
		"pylsp",
		"rust_analyzer",
	},
})
