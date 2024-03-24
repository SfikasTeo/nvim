-- lua/plugins/gitsigns.lua
local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 10,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },

    yadm = {
        enable = false,
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk navigation
        map("n", "<C-g>j", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "<C-g>k", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })
        --
        -- Actions
        map("n", "<C-g>s", gs.stage_hunk)
        map("n", "<C-g>S", gs.stage_buffer)
        map("n", "<C-g>u", gs.undo_stage_hunk)
        map("n", "<C-g>r", gs.reset_hunk)
        map("n", "<C-g>R", gs.reset_buffer)
        map("n", "<C-g>b", gs.toggle_current_line_blame)

        -- Text object
        map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")

        -- User commands
        local usr_cmd = vim.api.nvim_create_user_command
        usr_cmd("GitSigns diffhead", function()
            gs.diffthis()
        end, { desc = "Show diff against the git HEAD" })

        usr_cmd("GitSigns diffref", function(opts)
            gs.diffthis(opts.args)
        end, { nargs = 1, desc = "Show diff against any git reference" })

        usr_cmd("GitSigns diffthis", function()
            gs.diffthis()
        end, { desc = "Show diff against last save" })
    end,
})

