-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")

-- Setup installed LSPs:
lspconfig.asm_lsp.setup({})
-- lspconfig.bashls.setup({})
lspconfig.clangd.setup({
	-- Makes clangd compatible with copilot
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern(
			"Makefile",
			"configure.ac",
			"configure.in",
			"config.h.in",
			"meson.build",
			"meson_options.txt",
			"build.ninja"
		)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
			"lspconfig.util"
		).find_git_ancestor(fname)
	end,
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})
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
				-- Need to be installed separately
				isort = { enabled = true },
				black = { enabled = true },
				mypy = { enabled = true },
			},
		},
	},
})

-- Configure Mappings
local set = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }

		-- Global Key Mappings
		set("n", "<leader>r", vim.lsp.buf.rename, opts) -- Rename symbol
		set("n", "K", vim.lsp.buf.signature_help, opts) -- Show signature information
		set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
		set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
		set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
		set("n", "gh", vim.lsp.buf.hover, opts) -- Show hover information

		-- Diagnostic Mappings
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

		set("n", "<C-g>l", vim.diagnostic.setloclist, { desc = "Populate loclist with diagnostics", buffer = ev.buf })
		set(
			"n",
			"<C-g>q",
			vim.diagnostic.setqflist,
			{ desc = "Populate quickfix list with diagnostics", buffer = ev.buf }
		)
		set("n", "<C-g>j", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = ev.buf })
		set("n", "<C-g>k", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = ev.buf })

		-- User Commands
		local usr_cmd = vim.api.nvim_create_user_command
		-- Add Workspace Folder Command
		usr_cmd("LspAddWorkspace", function()
			vim.lsp.buf.add_workspace_folder()
		end, { desc = "Add workspace folder" })

		-- Remove Workspace Folder Command
		usr_cmd("LspRemoveWorkspace", function()
			vim.lsp.buf.remove_workspace_folder()
		end, { desc = "Remove workspace folder" })

		-- List Workspace Folders Command
		usr_cmd("LspListWorkspaces", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List all workspace folders" })

		-- Format Document
		usr_cmd("LspFormatDocument", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format document" })
	end,
})
