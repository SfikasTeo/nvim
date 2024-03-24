-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")

-- Setup installed LSPs:
lspconfig.asm_lsp.setup({})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.neocmake.setup({})
lspconfig.html.setup({})
lspconfig.tsserver.setup({})
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
                    enabled = true,
					maxLineLength = 120,
                    ignore = { "W391" },
				},
				pyflakes = { enabled = false },
				pylint = { enabled = false},
				yapf = { enabled = false },
				isort = { enabled = true },
                black = { enabled = true },
				mypy = { enabled = true },
			},
		},
	},
})
lspconfig.rust_analyzer.setup({})

-- Configure Mappings
local set = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		set("n", "<C-f>h", vim.lsp.buf.hover, opts)
		set("n", "<C-f>s", vim.lsp.buf.signature_help, opts)
		set("n", "<C-f>d", vim.lsp.buf.definition, opts)
		set("n", "<C-f>D", vim.lsp.buf.declaration, opts)
		set("n", "<C-f>i", vim.lsp.buf.implementation, opts)
		set("n", "<leader>r", vim.lsp.buf.rename, opts)
	end,
})

-- User Commands

-- Add Workspace Folder Command
vim.api.nvim_create_user_command("LspAddWorkspace", function()
	vim.lsp.buf.add_workspace_folder()
end, { desc = "Add workspace folder" })

-- Remove Workspace Folder Command
vim.api.nvim_create_user_command("LspRemoveWorkspace", function()
	vim.lsp.buf.remove_workspace_folder()
end, { desc = "Remove workspace folder" })

-- List Workspace Folders Command
vim.api.nvim_create_user_command("LspListWorkspaces", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List all workspace folders" })

-- Format Document
vim.api.nvim_create_user_command("LspFormatDocument", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format document" })

