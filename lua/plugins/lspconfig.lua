-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")

-- Setup installed LSPs:
lspconfig.asm_lsp.setup({})
lspconfig.bashls.setup({
	settings = {
		shellcheck = {
			enable = true,
			-- exclude = { "SC1090", "SC2034", "SC2154" },
		},
	},
})
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
				pylint = { enabled = false },
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

		-- Key Mappings
		set("n", "<C-f>h", vim.lsp.buf.hover, opts) -- List hover information
		set("n", "<C-f>s", vim.lsp.buf.signature_help, opts) -- List signature information
		set("n", "<C-f>d", vim.lsp.buf.definition, opts) -- Find definition
		set("n", "<C-f>D", vim.lsp.buf.declaration, opts) -- Find declaration
		set("n", "<C-f>i", vim.lsp.buf.implementation, opts) -- Find implementation
		set("n", "<leader>r", vim.lsp.buf.rename, opts) -- Rename symbol

		-- Diagnostic Mappings
        vim.keymap.set("n", "<C-g>f", function()
            vim.diagnostic.open_float(nil, {
                focus = false,
                scope = "cursor",
                border = "rounded",
                source = "always",
                prefix = "● ",
            })
        end, { desc = "Show diagnostics for current line", buffer = ev.buf })
        set("n", "<C-g>l", vim.diagnostic.setloclist, { desc = "Populate loclist with diagnostics", buffer = ev.buf })
        set("n", "<C-g>q", vim.diagnostic.setqflist, { desc = "Populate quickfix list with diagnostics", buffer = ev.buf })
        set("n", "<C-g>n", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = ev.buf })
        set("n", "<C-g>p", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = ev.buf })
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

