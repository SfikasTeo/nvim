-- lua/plugins/neotree.lua

require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    default_component_configs = {
    	container = {
    		enable_character_fade = true,
    	},
    	indent = {
    		indent_size = 2,
    		padding = 0,
    		with_markers = true,
    		indent_marker = "│",
    		last_indent_marker = "└",
    		highlight = "NeoTreeIndentMarker",
    		with_expanders = nil,
    		expander_collapsed = "",
    		expander_expanded = "",
    		expander_highlight = "NeoTreeExpander",
    	},
    	icon = {
    		folder_closed = "",
    		folder_open = "",
    		folder_empty = "",
    		default = "",
    		highlight = "NeoTreeFileIcon",
    	},
    	modified = {
    		symbol = "",
    		highlight = "NeoTreeModified",
    	},
    	name = {
    		trailing_slash = false,
    		use_git_status_colors = true,
    		highlight = "NeoTreeFileName",
    	},
    	git_status = {
    		symbols = {
    			added = "✚",
    			modified = "",
    			deleted = "✖",
    			renamed = "",
    			untracked = "",
    			ignored = "",
    			unstaged = "",
    			staged = "",
    			conflict = "",
    		},
    	},
    	file_size = {
    		enabled = true,
    		required_width = 60,
    	},
    	type = {
    		enabled = true,
    		required_width = 90,
    	},
    	last_modified = {
    		enabled = true,
    		required_width = 120,
    	},
    	created = {
    		enabled = true,
    		required_width = 140,
    	},
    	symlink_target = {
    		enabled = true,
    		required_width = 160,
    	},
    },
    window = {
    	position = "left",
    	width = 30,
    	mapping_options = {
    		noremap = true,
    		nowait = true,
    	},
    	mappings = {
    		-- Disable default mappings
    		["s"] = "noop",
    		["S"] = "noop",
    		["a"] = "noop",
    		["d"] = "noop",
    		["o"] = "noop",
    		["m"] = "noop",
    		["<space>"] = "noop",
    		-- Window management mappings
    		["<C-w>s"] = "open_split",
    		["<C-w>v"] = "open_vsplit",
    		["<C-w>t"] = "open_tabnew",
    		-- Preview
    		["P"] = {
    			"toggle_preview",
    			config = {
    				use_float = true,
    				use_image_nvim = false,
    			},
    		},
    		["l"] = "focus_preview",
    		["<cr>"] = "open",
    		["?"] = "show_help",
    		["<esc>"] = "cancel",
    		["<"] = "prev_source",
    		[">"] = "next_source",
    		["q"] = "close_window",
    		["<2-LeftMouse>"] = "open",
    		["i"] = "show_file_details",
    		["w"] = "open_with_window_picker",
    		["e"] = "toggle_auto_expand_width",
    		-- Navigation mappings
    		["C"] = "close_all_nodes",
    		["<bs>"] = "navigate_up",
    		["ad"] = "add_directory",
    		["t"] = "toggle_node",
    		["c"] = "close_node",
    		["."] = "set_root",
    		["R"] = "refresh",
    		["dd"] = "delete",
    		["r"] = "rename",
    		["af"] = "add",
    		-- Clipboard mappings
    		["x"] = "cut_to_clipboard",
    		["y"] = "copy_to_clipboard",
    		["p"] = "paste_from_clipboard",
    		-- Order mappings
    		["oc"] = "order_by_created",
    		["od"] = "order_by_diagnostics",
    		["og"] = "order_by_git_status",
    		["om"] = "order_by_modified",
    		["on"] = "order_by_name",
    		["os"] = "order_by_size",
    		["ot"] = "order_by_type",
    	},
    },
    filesystem = {
    	filtered_items = {
    		visible = true,
    		hide_dotfiles = true,
    		hide_gitignored = true,
    		hide_hidden = true,
    		hide_by_name = {},
    		hide_by_pattern = {},
    		always_show = {},
    		never_show = {},
    		never_show_by_pattern = {},
    	},
    	follow_current_file = {
    		enabled = true,
    		leave_dirs_open = true,
    	},
    	hijack_netrw_behavior = "open_default",
    	use_libuv_file_watcher = true,
    	window = {
    		mappings = {
    			["H"] = "toggle_hidden",
    			["esc"] = "clear_filter",
    		},
    	},
    },
    buffers = {
    	follow_current_file = {
    		enabled = true,
    		leave_dirs_open = false,
    	},
    	group_empty_dirs = false,
    	show_unloaded = true,
    	window = {
    		mappings = {
    			["dd"] = "buffer_delete",
    		},
    	},
    },
    git_status = {
    	mappings = {
    		["A"] = "noop",
    		["gc"] = "noop",
    		["gp"] = "noop",
    		["gg"] = "noop",
    		["ga"] = "git_add_file",
    		["gr"] = "git_revert_file",
    		["gu"] = "git_unstage_file",
    		["i"] = "show_file_details",
    		["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
    		["oc"] = { "order_by_created", nowait = false },
    		["od"] = { "order_by_diagnostics", nowait = false },
    		["om"] = { "order_by_modified", nowait = false },
    		["on"] = { "order_by_name", nowait = false },
    		["os"] = { "order_by_size", nowait = false },
    		["ot"] = { "order_by_type", nowait = false },
    	},
    },
})

vim.api.nvim_set_keymap("n", "<leader>op", ":Neotree reveal<CR>", { noremap = true, silent = true })
