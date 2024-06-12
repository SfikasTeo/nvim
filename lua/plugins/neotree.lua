-- lua/plugins/neotree.lua
require("neo-tree").setup({
	close_if_last_window = false,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
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
			symbol = "",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				added = "",
				modified = "󰑏",
				deleted = "󰅖",
				renamed = "➜",
				untracked = "",
				ignored = "󰛑",
				unstaged = "",
				staged = "",
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
			["e"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_image_nvim = true,
				},
			},
			["s"] = false,
			["a"] = false,
			["d"] = false,
			["o"] = false,
			["<leader>op"] = "close_window",
			["<C-w>e"] = "focus_preview",
			["<C-w>s"] = "open_split",
			["<C-w>v"] = "open_vsplit",
			["<C-w>t"] = "open_tabnew",
			["R"] = "refresh",
			["b"] = "navigate_up",
			["t"] = "toggle_node",
			["c"] = "close_node",
			["C"] = "close_all_nodes",
			["af"] = "add",
			["ad"] = "add_directory",
			["dd"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["?"] = "show_help",
			["h"] = "prev_source",
			["l"] = "next_source",
			["i"] = "show_file_details",
			["."] = "set_root",
			["m"] = "move",
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
			visible = false,
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true,
			hide_by_name = {},
			hide_by_pattern = {},
			always_show = {},
			never_show = {},
			never_show_by_pattern = {},
		},
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = false,
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
			leave_dirs_open = true,
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
		window = {
			position = "float",
			mappings = {
				["g"] = false,
				["gA"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>op", ":Neotree reveal<CR>", { noremap = true, silent = true })

