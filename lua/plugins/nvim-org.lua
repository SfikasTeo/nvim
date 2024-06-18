-- lua/plugins/org-nvim.lua

local org = require("orgmode")
local org_bullets = require("org-bullets")

org.setup({
	org_agenda_files = "~/org/**/*",
	org_default_notes_file = "~/org/index.org",
    org_startup_folded = "showeverything",
})

org_bullets.setup({})

-- local org_roam = require("org-roam")
-- org_roam.setup({
-- 	require("org-roam").setup({
-- 		directory = "~/org/",
-- 		database = {
-- 			path = "~/org/org-roam.db",
-- 			update_on_save = true,
-- 			persist = true,
-- 		},
-- 	}),
-- })
