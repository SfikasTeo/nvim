-- lua/plugins/rustaceanvim.lua

local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                cargo = {
                    allFeatures = true,
                },
                inlayHints = {
                    enable = true,
                    parameterHints = true,
                    chainingHints = true,
                    typeHints = true,
                },
                diagnostics = {
                    enable = true,
                },
                procMacro = {
                    enable = true,
                },
            }
        },
    },
}

local opts = { noremap = true, silent = true }
local set = vim.keymap.set
local usr_cmd = vim.api.nvim_create_user_command

-- Rust-specific keybindings
set('n', 'J', function() vim.cmd.RustLsp('joinLines') end, opts)
set('n', '<C-r>m', function() vim.cmd.RustLsp('expandMacro') end, opts)
set('n', '<C-r>e', function() vim.cmd.RustLsp('explainError') end, opts)
set('n', '<C-r>R', function() vim.cmd.RustLsp('ssr') end, opts)
set('n', '<C-r>d', function() vim.cmd.RustLsp('renderDiagnostic') end, opts)

-- User commands
usr_cmd("RustLsp runnables", function() vim.cmd.RustLsp('runnables') end, {})
usr_cmd("RustLsp testables", function() vim.cmd.RustLsp('testables') end, {})
usr_cmd("RustLsp debuggables", function() vim.cmd.RustLsp('debuggables') end, {})
usr_cmd("RustLsp openCargo", function() vim.cmd.RustLsp('openCargo') end, {})
usr_cmd("RustLsp parentModule", function() vim.cmd.RustLsp('parentModule') end, {})
usr_cmd("RustLsp crateGraph", function() vim.cmd.RustLsp('crateGraph') end, {})
usr_cmd("RustLsp syntaxTree", function() vim.cmd.RustLsp('SyntaxTree') end, {})

    --    {
    --        'mrcjkb/rustaceanvim',
    --        version = '^4',
    --        ft = { 'rust' },
    --        config = function()
    --            require('plugins.rustacean')
    --        end,
    --    },

