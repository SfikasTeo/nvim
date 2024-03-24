-- lua/plugins/rust-tools.lua

local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

local opts = {
    tools = {
        runnables = {
            use_telescope = true
        },
        debuggables = {
            use_telescope = true
        },
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
    },
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
            },
        },
    },
}

require('rust-tools').setup(opts)

