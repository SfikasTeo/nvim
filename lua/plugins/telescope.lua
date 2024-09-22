-- lua/plugins/telescope.lua
local telescope = require("telescope")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local set = vim.keymap.set
local default_set = { noremap = true, silent = true }

telescope.setup({
	defaults = {
		layout_config = {
			width = 0.9,
			height = 0.9,
			horizontal = {
				preview_width = 0.6,
			},
			vertical = {
				preview_height = 0.6,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob",
			"!**/.git/*",
		},
		mappings = {
			i = { -- insert_mode mappings
				["<leader>q"] = actions.send_to_qflist,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				["<C-e>"] = actions.move_selection_previous,
				["<C-w>v"] = actions.select_vertical,
				["<C-w>s"] = actions.select_horizontal,
				["<C-w>t"] = actions.select_tab,
			},
			n = { -- normal_mode mappings
				["<leader>q"] = actions.send_to_qflist,
				["<C-c>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				["<C-e>"] = actions.move_selection_previous,
				["<C-w>v"] = actions.select_vertical,
				["<C-w>s"] = actions.select_horizontal,
				["<C-w>t"] = actions.select_tab,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob",
				"!**/.git/*",
			},
		},
		diagnostics = {
			layout_strategy = "vertical",
		},
		loclist = {
			theme = "dropdown",
		},
		quickfix = {
			theme = "dropdown",
		},
		jumplist = {
			theme = "dropdown",
		},
		commands = {
			theme = "dropdown",
		},
		marks = {
			theme = "dropdown",
		},
		current_buffer_fuzzy_find = {
			theme = "dropdown",
		},
		lsp_incoming_calls = {
			theme = "dropdown",
		},
		lsp_outgoing_calls = {
			theme = "dropdown",
		},
        lsp_references = {
            theme = "dropdown",
        },
		highlights = {
			theme = "dropdown",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

-- Set telescope specific keybindings
set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, default_set) -- Find in current buffer
set("n", "<leader>fF", builtin.find_files, default_set) -- Find files in CWD
set("n", "<leader>fG", builtin.live_grep, default_set) -- Grep inside files in CWD
set("n", "<leader>f/", builtin.highlights, default_set) -- Find Highlights
set("n", "<leader>fc", builtin.commands, default_set) -- Find available Commands
set("n", "<leader>fR", builtin.registers, default_set) -- Find register contents
set("n", "<leader>fl", builtin.loclist, default_set) -- List Location list
set("n", "<leader>fj", builtin.jumplist, default_set) -- List Jump list
set("n", "<leader>fq", builtin.quickfix, default_set) -- List Quickfix list
set("n", "<leader>fm", builtin.marks, default_set) -- List Marks
set("n", "<leader>ft", builtin.treesitter, default_set) -- Lists tree-sitter objects
set("n", "<leader>fd", builtin.diagnostics, default_set) -- List diagnostics/bugs
set("n", "<leader>fa", vim.lsp.buf.code_action, default_set) -- List code-actions
set("n", "<leader>fi", builtin.lsp_incoming_calls, default_set) -- Find symbol incoming calls
set("n", "<leader>fo", builtin.lsp_outgoing_calls, default_set) -- Find symbol outgoing calls
set("n", "<leader>fr", builtin.lsp_references, default_set) -- Find symbol references

-- Advanced Bindings

-- Utility function to check if inside a Git repo and get root
local function get_git_root()
	if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true" then
		return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	end
end

local function path_to_clipboard(prompt_bufnr)
	local selection = action_state.get_selected_entry(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	-- check if you are inside a git repo
	local cwd = picker.cwd or vim.fn.getcwd()

	-- Construct an absolute path
	local path = cwd .. "/" .. selection.value
	vim.notify("Copied to clipboard: " .. path)
	path = vim.fn.fnamemodify(path, ":p")

	vim.fn.setreg("+", path)
end

local function select_theme(theme_name)
	local theme_map = {
		ivy = themes.get_ivy(),
		dropdown = themes.get_dropdown(),
		cursor = themes.get_cursor(),
		list = {
			previewer = false,
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
				anchor = "center",
				width = 0.4,
				height = 0.3,
			},
		},
		default = {},
	}
	return theme_map[theme_name] or theme_map.default
end

local function set_opts(theme_name, cwd_path)
	local opts = select_theme(theme_name)
	opts.cwd = cwd_path or get_git_root() or vim.fn.getcwd()
	opts.attach_mappings = function(prompt_bufnr, map)
		map("n", "yy", function()
			path_to_clipboard(prompt_bufnr)
		end)
		return true
	end

	return opts
end

-- Usage of the modified function
set("n", "<leader>ff", function()
	builtin.find_files(set_opts())
end, default_set)
set("n", "<leader>fg", function()
	builtin.live_grep(set_opts())
end, default_set)

set("n", "<leader>.", function()
	builtin.find_files(set_opts("ivy"))
end, default_set)

set("n", "<leader>,", function()
	builtin.buffers(select_theme("ivy"))
end, default_set)

-- Org:
set("n", "<leader>on", function()
	builtin.find_files(set_opts("ivy", "~/org/"))
end, default_set)
set("n", "<leader>of", function()
	builtin.live_grep(set_opts("ivy", "~/org/"))
end, default_set)

-- User commands
local usr_cmd = vim.api.nvim_create_user_command
usr_cmd("Telescope help-tags", function()
	require("telescope.builtin").help_tags()
end, { desc = "Open Telescope Help Tags" })

usr_cmd("Telescope keymaps", function()
	require("telescope.builtin").keymaps()
end, { desc = "Open Telescope Keymaps" })

usr_cmd("Telescope man-pages", function()
	require("telescope.builtin").man_pages()
end, { desc = "Open Telescope Man Pages" })

-- Load extensions
telescope.load_extension("ui-select")
