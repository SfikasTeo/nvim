-- lua/plugins/lsp/init.lua
local lspconfig = require("lspconfig")

-- Utility function for common setup tasks
local on_attach = function(_, bufnr)
	local set = vim.keymap.set
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- Key mappings
	set("n", "<leader>r", vim.lsp.buf.rename, opts)
	set("n", "<leader>e", vim.lsp.buf.signature_help, opts)
	set("n", "K", vim.lsp.buf.hover, opts)
	set("n", "gd", vim.lsp.buf.definition, opts)
	set("n", "gD", vim.lsp.buf.declaration, opts)
	set("n", "gi", vim.lsp.buf.implementation, opts)

	set("n", "<C-g>l", vim.diagnostic.setloclist, { desc = "Populate loclist with diagnostics", buffer = bufnr })
	set("n", "<C-g>q", vim.diagnostic.setqflist, { desc = "Populate quickfix list with diagnostics", buffer = bufnr })
	set("n", "<C-g>[", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = bufnr })
	set("n", "<C-g>]", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = bufnr })

	-- User commands
	vim.api.nvim_create_user_command(
		"LspAddWorkspace",
		vim.lsp.buf.add_workspace_folder,
		{ desc = "Add workspace folder" }
	)
	vim.api.nvim_create_user_command(
		"LspRemoveWorkspace",
		vim.lsp.buf.remove_workspace_folder,
		{ desc = "Remove workspace folder" }
	)
	vim.api.nvim_create_user_command("LspListWorkspaces", function()
		vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO)
	end, { desc = "List all workspace folders" })
	vim.api.nvim_create_user_command("LspFormatDocument", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format document" })

	-- Set up autocommand for signature help
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.signature_help()
		end,
	})
end

local servers = {
	tsserver = {},
	asm_lsp = {},
	lua_ls = {},
	html = {},
	clangd = require("plugins.lsp.clangd"),
	pylsp = require("plugins.lsp.pylsp"),
	taplo = require("plugins.lsp.taplo"),
	rust_analyzer = require("plugins.lsp.rust_analyzer"),
}

for name, config in pairs(servers) do
	config.on_attach = on_attach
	lspconfig[name].setup(config)
end

-- Diagnostic settings
vim.diagnostic.config({
	virtual_text = {},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		border = "rounded",
		source = "always",
		prefix = "● ",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

