-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

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
        set("n", "<C-f>h", vim.lsp.buf.hover, opts)          -- List hover information
        set("n", "<C-f>s", vim.lsp.buf.signature_help, opts) -- List signature information
        set("n", "<C-f>d", vim.lsp.buf.definition, opts)     -- Find definition
        set("n", "<C-f>D", vim.lsp.buf.declaration, opts)    -- Find declaration
        set("n", "<C-f>i", vim.lsp.buf.implementation, opts) -- Find implementation
        set("n", "<C-r>r", vim.lsp.buf.rename, opts)         -- Rename symbol

        -- Diagnostic Mappings
        vim.diagnostic.config({
            virtual_text = {
            },
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

        vim.keymap.set("n", "<C-n>", function()
            vim.diagnostic.open_float()
        end, { desc = "Show diagnostics for current line", buffer = ev.buf })
        set("n", "<C-g>l", vim.diagnostic.setloclist, { desc = "Populate loclist with diagnostics", buffer = ev.buf })
        set("n", "<C-g>q", vim.diagnostic.setqflist,
            { desc = "Populate quickfix list with diagnostics", buffer = ev.buf })
        set("n", "<C-g>n", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = ev.buf })
        set("n", "<C-g>p", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = ev.buf })

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

