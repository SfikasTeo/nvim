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
			["<C-p>"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_image_nvim = true,
				},
			},
			-- Remove default
			["s"] = "none",
			["d"] = "none",
			-- Add global
			["P"] = "focus_preview",
			[",,"] = "cancel",
			["<C-c>"] = "close_window",
			["<C-b>"] = "navigate_up",
			["<C-s>"] = "open_split",
			["<C-v>"] = "open_vsplit",
			["<C-o>"] = "open",
			["t"] = "toggle_node",
			["T"] = "open_tabnew",
			["c"] = "close_node",
			["C"] = "close_all_nodes",
			["R"] = "refresh",
			["a"] = {
				"show_help",
				nowait = true,
				config = {
					title = "Add",
					prefix_key = "a",
				},
			},
			["af"] = "add",
			["ad"] = "add_directory",
			["dd"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
			["i"] = "show_file_details",
			["."] = "set_root",
			["m"] = "move",
			["o"] = {
				"show_help",
				nowait = true,
				config = {
					title = "Order by",
					prefix_key = "o",
				},
			},
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
				[",,"] = "clear_filter",
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
				["g"] = {
					"show_help",
					nowait = false,
					config = {
						title = "Git action",
						prefix_key = "g",
					},
				},
				["gA"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree reveal<CR>", { noremap = true, silent = true })
