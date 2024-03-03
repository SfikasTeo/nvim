-- lua/plugins/cmp.lua
local cmp = require("cmp")
local ls = require("luasnip")

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
)

-- luasnip
local set = vim.keymap.set
local opts = { silent = true }

-- Load snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Optional: Define your custom snippets here
ls.snippets = {}

-- Set up keybindings for LuaSnip
set({ "i" }, "<C-K>", function() ls.expand() end, opts)
set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, opts)
set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, opts)
set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, opts)

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
        }),
    },
})

-- Use buffer source for `/` (searching) and `:` (commands)
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
    }),
})

