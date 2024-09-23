-- lua/plugins/multicursor.lua

local mc = require("multicursor-nvim")
local wk = require("which-key")

mc.setup({})

-- Customize how cursors look.
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

wk.add({
    mode = { "n", "v" },
    {
        -- Move w/o adding cursor
        { "<up>", function() mc.lineSkipCursor(-1) end, desc = "Move main cursor above" },
        { "<down>", function() mc.lineSkipCursor(1) end, desc = "Move main cursor below" },
        -- Add cursors under/above the current cursor
        { "<S-up>", function() mc.lineAddCursor(-1) end, desc = "Add cursor above" },
        { "<S-down>", function() mc.lineAddCursor(1) end, desc = "Add cursor below" },
        -- Add or skip adding a new cursor by matching word/selection
        { "<leader>j", function() mc.matchAddCursor(1) end },
        { "<leader>k", function() mc.matchAddCursor(-1) end },
        { "<leader>J", function() mc.matchSkipCursor(1) end },
        { "<leader>K", function() mc.matchSkipCursor(-1) end },
        -- Alter main cursor to next/previous cursor
        { "<S-right>", mc.nextCursor, desc = "Move to next cursor" },
        { "<S-left>", mc.prevCursor, desc = "Move to previous cursor" },
        -- Delete cursor
        { "<leader>cx", mc.deleteCursor, desc = "Delete cursor" },
        -- Move main cursor w/o affecting the others
        { "<leader>ct", mc.toggleCursor, desc = "Toggle multicursor" },
        -- Duplicate cursors, reset relatively to the position of the main cursor
        { "<leader>cr", mc.duplicateCursors, desc = "Reset cursors on main" },
        -- Clear all cursors
        { "<leader>cc", mc.clearCursors, desc = "Clear all cursors" },
        -- Rotate the contents of the visuall selection of each cursor
    },
})

wk.add({
    mode = { "n" },
    {
        { "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                end
            end
        },
        -- Restore the cursors that were cleared
        { "<leader>cR", mc.restoreCursors, desc = "Restore cleared cursors" },
    }
})

wk.add({
    mode = { "v" },
    {
        { "<leader>ca", mc.alignCursors, desc = "Align cursor columns" },
        { "<leader>ct", function() mc.transposeCursors(1) end, desc = "Transpose selections forward" },
        { "<leader>cT", function() mc.transposeCursors(-1) end, desc = "Transpose selections backward" },
        { "I", mc.insertVisual, desc = "Insert cursor on each line" },
        { "A", mc.appendVisual, desc = "Append cursor on each line" },
        { "M", mc.matchCursors, desc = "Split selection by regex matches" },
        { "S", mc.splitCursors, desc = "Split selection by regex separator" },
    }
})
