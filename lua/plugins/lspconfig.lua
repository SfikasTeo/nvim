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
lspconfig.pylsp.setup({})
lspconfig.rust_analyzer.setup({})

-- Configure Mappings
local set = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		set("n", "gs", vim.lsp.buf.hover, opts)
		set("n", "gS", vim.lsp.buf.signature_help, opts)

        -- inline with the default nvim mappings:
		set("n", "gd", vim.lsp.buf.definition, opts)
		set("n", "gD", vim.lsp.buf.declaration, opts)
		set("n", "gi", vim.lsp.buf.implementation, opts)

        -- Refactoring with LSP
		set("n", "RR", vim.lsp.buf.rename, opts)

        -- Intergrate with telescope
		set({ "n", "v" }, "<C-f>a", vim.lsp.buf.code_action, opts)

        -- LSP based formatting
		set("n", "<leader>F", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- Lsp Workspace Mappings
		set("n", "<C-w>a", vim.lsp.buf.add_workspace_folder, opts)
		set("n", "<C-w>r", vim.lsp.buf.remove_workspace_folder, opts)
		set("n", "<C-w>l", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})

