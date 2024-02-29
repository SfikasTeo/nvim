-- lua/plugins/lspconfig.lua
local lspconfig = require('lspconfig')

-- Setup installed LSPs:
lspconfig.asm_lsp.setup{}
lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.neocmake.setup{}
lspconfig.html.setup{}
lspconfig.tsserver.setup{}
lspconfig.lua_ls.setup{}
lspconfig.pylsp.setup{}
lspconfig.rust_analyzer.setup{}

-- Configure Mappings
local set = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    set('n', 'K', vim.lsp.buf.hover, opts)
    set('n', 'gD', vim.lsp.buf.declaration, opts)
    set('n', 'gd', vim.lsp.buf.definition, opts)
    set('n', 'gi', vim.lsp.buf.implementation, opts)
    set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    set({ 'n', 'v' }, '<C-f>a', vim.lsp.buf.code_action, opts)
    set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
