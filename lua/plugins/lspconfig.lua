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
		set("n", "<C-f>i", vim.lsp.buf.hover, opts)
		set("n", "<C-f>s", vim.lsp.buf.signature_help, opts)

		-- inline with the default nvim mappings:
		set("n", "gd", vim.lsp.buf.definition, opts)
		set("n", "gD", vim.lsp.buf.declaration, opts)
		set("n", "gi", vim.lsp.buf.implementation, opts)

		-- Intergrate with telescope
		set({ "n", "v" }, "<C-f>a", vim.lsp.buf.code_action, opts)

		-- LSP based formatting
		set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		-- LSP based Refactoring
		set("n", "<leader>r", vim.lsp.buf.rename, opts)
	end,
})

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

